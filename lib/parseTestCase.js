'use strict';
var _ = require('lodash');
var requireModule = require('./requireModule');
var newLine = '\n';
var indent = '\t';
require('string.prototype.repeat');

module.exports = function (testcase) {
	var useStrict = '\'use strict\';' + newLine.repeat(2);
	var comments = '';
	var exportBegin = 'module.exports = function () {' + newLine + indent;
	var exportEnd = newLine + '};' + newLine;

	var first = true;
	var nodes = _(testcase).reduce(function (result, node) {
		var wrapped = first ? false : true;
		var text = '';
		switch (node.name) {
			case 'tags':
				comments += '// ' + node.content + newLine;
				break;
			case 'action':
				text += '// Action - '
					+ node.attributes.name
					+ newLine + indent.repeat(2);
				break;
			case 'module':
				text = (first ? '' : '.then(')
					+ requireModule(node, wrapped)
					+ (first ? '' : ')')
					+ newLine + indent.repeat(2);
				first = false;
				break;
		}
		return result + text;
	}, '');
	return useStrict
		+ comments
		+ exportBegin
		+ 'return '
		+ nodes
		+ exportEnd;
}