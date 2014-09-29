'use strict';

var fs = require('fs');
var path = require('path');
var parse = require('./lib/parse');
var junk = require('junk');
var mkdirp = require('mkdirp');

// paths
var scriptsPath = 'vendor/ecom-gui-test/scripts/';
var outPath = require('./config.json').dist + '/';
var command = 'A_common/command/';
var smoketest = 'TESTS/SiteGenesis/PUBLIC/smoketest/';
var commandPath = scriptsPath + command;
var commandPathOut = outPath + command;
var smoketestPath = scriptsPath + smoketest;
var smoketestPathOut = outPath + smoketest;

// create out paths
[commandPathOut, smoketestPathOut].forEach(function (p) {
	fs.exists(p, function (exists) {
		if (!exists) {
			mkdirp.sync(p);
		}
	});
});

// common commands
fs.readdir(commandPath, function (err, files) {
	if (err) throw err;
	files.filter(junk.not).forEach(function (file) {
		fs.readFile(commandPath + file, 'utf8', function (err, res) {
			if (err) throw err;
			var fileNameJs = path.basename(file, '.xml') + '.js';
			fs.writeFileSync(commandPathOut + fileNameJs, parse(res));
		});
	});
});

function testSuite(ts) {
	fs.readdir(smoketestPath + ts, function (err, cases) {
		if (err) throw err;
		cases.filter(junk.not).forEach(function (tc) {
			testCase(smoketestPath + ts + '/' + tc);
		});
	});
}

function testCase(tc) {
	fs.readFile(tc, 'utf8', function (err, res) {
		if (err) throw err;
		console.log(tc);
		console.log(parse(res));
	});
}

// smoketest
fs.readdir(smoketestPath, function (err, suites) {
	if (err) throw err;
	suites.forEach(testSuite);
});