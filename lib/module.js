'use strict';

/**
 * parse a scriptmodule element
 **/

var _ = require('lodash');
var parseAction = require('./action');
var newLine = '\n';
var indent = '\t';
require('string.prototype.repeat');

module.exports = function (module) {
	var useStrict = '\'use strict\';' + newLine.repeat(2);
	var comments = '';
	var vars = [
		'var client = require(\'./client\');',
		'var Promise = require(\'promise\');'
	];
	var params = [];
	var exportBegin = 'module.exports = function (';
	var exportContinue = ') {' + newLine + indent;
	var exportEnd = newLine + '};' + newLine;

	// concat all the nodes
	var first = true;
	var nodes = _(module).reduce(function (result, node) {
		var wrapped = first ? false : true;
		var text;
		switch (node.name) {
			// ignore `description` and `parameter` node
			case 'description':
				comments += '/**' + newLine
					+ '* ' + node.content + newLine
					+ '*/' + newLine.repeat(2);
				break;
			case 'parameter':
				params.push(node.attributes.name);
				break;
			case 'module':
			case 'command':
				text = parseAction(node, first);
				first = false;
				break;
		}
		if (!text) {
			return '';
		}
		return result
			+ text
			+ newLine + indent.repeat(2);
	}, '');

	nodes = nodes.trim() + ';';
	return useStrict
		+ comments
		+ vars.join(newLine)
		+ newLine.repeat(2)
		+ exportBegin
		+ params.join(', ')
		+ exportContinue
		+ 'return '
		+ nodes
		+ exportEnd;
}