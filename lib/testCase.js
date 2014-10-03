'use strict';

/**
 * parse a test case
 **/

var _ = require('lodash');
var parseAction = require('./action');
var newLine = '\n';
var indent = '\t';
require('string.prototype.repeat');

module.exports = function (testcase) {
	var useStrict = '\'use strict\';' + newLine;
	var comments = '';
	var vars = [
		'var data = require(\'./data\')'
	];
	var exportBegin = 'module.exports = function () {' + newLine + indent;
	var exportEnd = newLine + '};' + newLine;

	var first = true;
	var nodes = _(testcase).reduce(function (result, node) {
		var wrapped = first ? false : true;
		var text = '';
		switch (node.name) {
			// ignore `tags` node
			case 'description':
				comments += '// ' + node.content + newLine.repeat(2);
				break;
			case 'action':
				text += '// Action - '
					+ node.attributes.name
					+ newLine + indent.repeat(2);
				break;
			case 'module':
			case 'command':
				text = parseAction(node, first)
					+ newLine + indent.repeat(2);
				first = false;
				break;
		}
		return result + text;
	}, '');
	return useStrict
		+ comments
		+ vars.join(newLine)
		+ newLine.repeat(2)
		+ exportBegin
		+ 'return '
		+ nodes + ';'
		+ exportEnd;
}