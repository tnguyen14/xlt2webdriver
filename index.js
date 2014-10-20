'use strict';

var fs = require('fs');
var path = require('path');
var parse = require('./lib/parse');
var createTestSuite = require('./lib/testSuite');
var junk = require('junk');
var mkdirp = require('mkdirp');
var readdirp = require('readdirp');
var es = require('event-stream');
var config = require('./config.json');

// paths
var scriptsPath = 'vendor/ecom-gui-test/scripts/';
var outPath = config.dist;
var command = 'A_common/command/';
var smoketest = 'TESTS/SiteGenesis/PUBLIC/smoketest';
var appmodules = 'app/SiteGenesis/';
var commandPath = path.join(scriptsPath, command);
var commandPathOut = path.join(outPath, command);
var smoketestPath = path.join(scriptsPath, smoketest);
var smoketestPathOut = path.join(outPath, smoketest);
var appmodulesPath = path.join(scriptsPath, appmodules);
var appmodulesPathOut = path.join(outPath, appmodules);

// make dist dir
mkdirp.sync(outPath);

// common commands
fs.readdir(commandPath, function (err, files) {
	if (err) throw err;
	mkdirp.sync(commandPathOut);
	files.filter(junk.not).forEach(function (file) {
		fs.readFile(path.join(commandPath, file), 'utf8', function (err, res) {
			if (err) throw err;
			var fileName = path.basename(file, '.xml');
			fs.writeFileSync(path.join(commandPathOut, fileName + '.js'), parse(res, fileName));
		});
	});
});

// app modules
var appModulesStream = readdirp({
	root: appmodulesPath,
	fileFilter: '*.xml'
});
appModulesStream
	.on('warn', function (err) {
		console.error('non-fatal error', err);
		appModulesStream.destroy();
	})
	.on('error', function (err) {
		console.error('fatal error', err);
	})
	.pipe(es.mapSync(function (m) {
		fs.readFile(path.join(appmodulesPath, m.path), 'utf8', function (err, res) {
			if (err) throw err;
			var basename = path.basename(m.path, '.xml');
			var dirname = path.dirname(m.path);
			mkdirp.sync(path.join(appmodulesPathOut, dirname));
			fs.writeFileSync(path.join(appmodulesPathOut, dirname, basename + '.js'), parse(res, dirname + '/' + basename));
		});
	}))
	.pipe(es.stringify())
	.pipe(process.stdout);


function testSuite(ts) {
	mkdirp.sync(path.join(smoketestPathOut, ts));
	fs.readdir(path.join(smoketestPath, ts), function (err, cases) {
		if (err) throw err;
		cases = cases.filter(junk.not);
		cases.forEach(function (tc) {
			testCase(path.join(smoketestPath, ts, tc), ts);
		});
		fs.writeFileSync(path.join(smoketestPathOut, ts, 'index.js'), createTestSuite(cases, ts));
	});
}

function testCase(tc, ts) {
	fs.readFile(tc, 'utf8', function (err, res) {
		if (err) throw err;
		var basename = path.basename(tc, '.xml');
		// ignore data files here, handle it separately
		if (basename.indexOf('_data') !== -1) {
			return;
		}
		var dataFile = path.join(path.dirname(tc), basename + '_data.xml');
		if (!fs.existsSync(dataFile)) {
			dataFile = __dirname + '/data.sample.xml';
		}
		var dataContent = fs.readFileSync(dataFile, 'utf8');
		mkdirp.sync(path.join(smoketestPathOut, ts, basename));
		fs.writeFileSync(path.join(smoketestPathOut, ts, basename, 'index.js'), parse(res, basename));
		fs.writeFileSync(path.join(smoketestPathOut, ts, basename, 'data.js'), parse(dataContent, basename));
	});
}

// smoketest
fs.readdir(smoketestPath, function (err, suites) {
	if (err) throw err;
	suites.forEach(testSuite);
});
