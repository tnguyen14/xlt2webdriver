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

module.exports = function (cases) {
	var exportBegin = 'module.exports = function () {' + newLine + indent;
	var exportEnd = newLine + '};' + newLine;
	var first = true;
	var testCases = _(cases).reduce(function (result, c) {
		var wrapped = first ? false : true;
		var text;
		if (c.indexOf('_data') !== -1) {
			return result + '';
		}
		c = path.basename(c, '.xml');
		if (first) {
			text = 'require(\'./' + c + '\')()';
			first = false;
		} else {
			text = '.then(function () {'
				+ newLine + indent.repeat(3)
				+ 'return require(\'./' + c + '\')();'
				+ newLine + indent.repeat(2) + '})';
		}
		return result + text;
	}, '');
	return timestamp + newLine.repeat(2)
		+ useStrict
		+ exportBegin
		+ 'return '
		+ testCases + ';'
		+ exportEnd;
}