'use strict';

var _ = require('lodash');
var path = require('path');
var newLine = '\n';
var indent = '\t';
require('string.prototype.repeat');
var useStrict = '\'use strict\';' + newLine;
var timestamp = '/**'
	+ newLine + ' * This file was automatically generated on ' + new Date()
	+ newLine + ' **/';

module.exports = function (cases, suite) {
	var vars = [
		'var webdriver = require(\'webdriver\');',
		'var data = require(\'globalData\');',
		'var assert = require(\'chai\').assert;'
	];
	var suiteBegin = 'describe(\''
		+ suite
		+ '\', function () {'
		+ newLine + indent;
	var suiteEnd = newLine + '});' + newLine;
	var first = true;
	var testCases = _(cases).reduce(function (result, c) {
		if (c.indexOf('_data') !== -1) {
			return result;
		}
		c = path.basename(c, '.xml');
		return result + 'require(\'./' + c + '\')();' + newLine + indent;
	}, '');
	return timestamp + newLine.repeat(2)
		+ useStrict + newLine
		+ suiteBegin
		+ testCases.trim()
		+ suiteEnd;
}