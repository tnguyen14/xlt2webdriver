'use strict';

var fs = require('fs');
var path = require('path');
var parse = require('./lib/parse');
var junk = require('junk');
var mkdirp = require('mkdirp');

var scriptsPath = 'vendor/ecom-gui-test/scripts/';
var outPath = require('./config.json').dist + '/';
var command = 'A_common/command/';

fs.exists(outPath + command, function (exists) {
	if (!exists) {
		mkdirp.sync(outPath + command);
	}
});

fs.readdir(scriptsPath + command, function (err, files) {
	if (err) throw err;
	files.filter(junk.not).forEach(function (file) {
		fs.readFile(scriptsPath + command + file, 'utf8', function (err, res) {
			if (err) throw err;
			var fileNameJs = path.basename(file, '.xml') + '.js';
			fs.writeFileSync(outPath + command + fileNameJs, parse(res));
		});
	});
});