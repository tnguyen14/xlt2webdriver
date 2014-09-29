var _ = require('lodash');
var parseAction = require('./parseAction');
var newLine = '\n';
var indent = '\t';
require('string.prototype.repeat');

module.exports = function (module) {
	var useStrict = '\'use strict\';' + newLine.repeat(2);
	var vars = [
		'var client = require(\'./client\');',
		'var Promise = require(\'promise\');'
	];

	var exportBegin = 'module.exports = function () {' + newLine + indent;
	var exportEnd = newLine + '};' + newLine;

	// concat all the nodes
	var first = true;
	var nodes = _(module).reduce(function (result, node) {
		var wrapped = first ? false : true;
		var text;
		switch (node.name) {
			// ignore `description` and `parameter` node
			case 'description':
				// just skip
				break;
			case 'parameter':
				// not sure why there's parameter at this level
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
	return useStrict +
		vars.join(newLine) +
		newLine.repeat(2) +
		exportBegin +
		'return ' +
		nodes +
		exportEnd;
}