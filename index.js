'use strict';

var fs = require('fs');
var path = require('path');
var parse = require('./lib/parse');
var junk = require('junk');

var commandPath = 'vendor/ecom-gui-test/scripts/A_common/command/';
var outPath = require('./config.json').dist + '/';

fs.exists(outPath, function (exists) {
	if (!exists) {
		fs.mkdirSync(outPath);
	}
});

fs.readdir(commandPath, function (err, files) {
	if (err) throw err;
	files.filter(junk.not).forEach(function (file) {
		fs.readFile(commandPath + file, 'utf8', function (err, res) {
			if (err) throw err;
			var fileNameJs = path.basename(file, '.xml') + '.js';
			fs.writeFileSync(outPath + fileNameJs, parse(res));
		});
	});
});