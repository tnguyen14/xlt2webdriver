var _ = require('lodash');
var requireModule = require('./requireModule');
var requireCommand = require('./requireCommand');
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
		var fn;
		switch (node.name) {
			case 'description':
				// just skip
				break;
			case 'parameter':
				// not sure why there's parameter at this level
				break;
			case 'module':
				fn = (first ? '' : '.then(') +
					requireModule(node, wrapped);
					(first ? '' : ')');
				first = false;
				break;
			case 'command':
				fn = (first ? '' : '.then(') +
					requireCommand(node, wrapped);
					(first ? '' : ')');
				first = false;
				break;
		}
		if (!fn) {
			return '';
		}
		return result +
			fn +
			newLine + indent.repeat(2);
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