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
		var fn = '';
		var wrapped = first ? false : true;
		var text;
		switch (node.name) {
			case 'tags':
				comments += '// ' + node.content + newLine;
				break;
			case 'action':
				fn += newLine + indent.repeat(2)
					+ '// Action - '
					+ node.attributes.name
					+ newLine;
				break;
			case 'module':
				fn = (first ? '' : indent.repeat(2) + '.then(') +
					requireModule(node, wrapped) +
					(first ? '' : ')');
				first = false;
				break;
		}
		return result
			+ fn
			// + newLine + indent.repeat(2);
	}, '');
	return useStrict
		+ comments
		+ exportBegin
		+ 'return '
		+ nodes
		+ exportEnd;
}