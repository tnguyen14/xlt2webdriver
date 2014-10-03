'use strict';

var fs = require('fs');
var path = require('path');
var parse = require('./lib/parse');
var junk = require('junk');
var mkdirp = require('mkdirp');
var readdirp = require('readdirp');
var es = require('event-stream');

// paths
var scriptsPath = 'vendor/ecom-gui-test/scripts/';
var outPath = require('./config.json').dist;
var command = 'A_common/command/';
var smoketest = 'TESTS/SiteGenesis/PUBLIC/smoketest';
var appmodules = 'app/SiteGenesis/';
var commandPath = path.join(scriptsPath, command);
var commandPathOut = path.join(outPath, command);
var smoketestPath = path.join(scriptsPath, smoketest);
var smoketestPathOut = path.join(outPath, smoketest);
var appmodulesPath = path.join(scriptsPath, appmodules);
var appmodulesPathOut = path.join(outPath, appmodules);

// common commands
fs.readdir(commandPath, function (err, files) {
	if (err) throw err;
	mkdirp.sync(commandPathOut);
	files.filter(junk.not).forEach(function (file) {
		fs.readFile(path.join(commandPath, file), 'utf8', function (err, res) {
			if (err) throw err;
			var fileNameJs = path.basename(file, '.xml') + '.js';
			fs.writeFileSync(path.join(commandPathOut, fileNameJs), parse(res));
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
			var basename = path.basename(m.path, '.xml') + '.js';
			var dirname = path.dirname(m.path);
			mkdirp.sync(path.join(appmodulesPathOut, dirname));
			fs.writeFileSync(path.join(appmodulesPathOut, dirname, basename), parse(res));
		});
	}))
	.pipe(es.stringify())
	.pipe(process.stdout);


function testSuite(ts) {
	mkdirp.sync(path.join(smoketestPathOut, ts));
	fs.readdir(path.join(smoketestPath, ts), function (err, cases) {
		if (err) throw err;
		cases.filter(junk.not).forEach(function (tc) {
			testCase(path.join(smoketestPath, ts, tc), ts);
		});
		// testCase(smoketestPath + ts + '/' + cases[cases.length - 2], ts);
	});
}

function testCase(tc, ts) {
	fs.readFile(tc, 'utf8', function (err, res) {
		if (err) throw err;
		var basename = path.basename(tc, '.xml');
		var filename = 'index.js';
		if (basename.indexOf('_data') !== -1) {
			filename = 'data.js';
			basename = basename.slice(0, basename.indexOf('_data'));
		}
		mkdirp.sync(path.join(smoketestPathOut, ts, basename));
		fs.writeFileSync(path.join(smoketestPathOut, ts, basename, filename), parse(res));
	});
}

// smoketest
fs.readdir(smoketestPath, function (err, suites) {
	if (err) throw err;
	suites.forEach(testSuite);
	// testSuite(suites[suites.length - 1]);
});