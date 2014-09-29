var _ = require('lodash');
var requireModule = require('./requireModule');
var requireCommand = require('./requireCommand');
require('string.prototype.repeat');

module.exports = function (module) {
	var newLine = '\n';
	var indent = '\t';
	var stuff = '\'use strict\';' + newLine.repeat(2);

	var vars = [
		'var client = require(\'./client\');',
		'var Promise = require(\'promise\');'
	]

	var exportBegin = 'module.exports = function () {' + newLine + indent;
	var exportEnd = newLine + '};' + newLine;

	// concat all the nodes
	var first = true;
	var nodes = _(module).reduce(function (result, node) {
		var wrapped = true;
		var fn;
		if (first) {
			wrapped = false;
		}
		switch (node.name) {
			case 'description':
				// just skip
				break;
			case 'parameter':
				// not sure why there's parameter at this level
				break;
			case 'module':
				fn = requireModule(node, wrapped);
				break;
			case 'command':
				fn = requireCommand(node, wrapped);
				break;
		}
		if (!fn) {
			return '';
		}
		var text = result +
			(first ? '' : '.then(') +
			fn +
			(first ? '()' : '') + //execute the first command
			(first ? '' : ')') +
			newLine +
			indent.repeat(2);
		first = false;
		return text;
	}, '');

	nodes = nodes.trim() + ';';
	return stuff +
		vars.join(newLine) +
		newLine.repeat(2) +
		exportBegin +
		'return ' +
		nodes +
		exportEnd;
}