var _ = require('lodash');
require('string.prototype.repeat');

function parseModule(module) {
	return 'require(\'' + module.attributes.name + '\')'
}

function parseCommand(command) {
	return 'client.' + command.attributes.name;
}

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

	var nodes = _(module).map(function (node){
		switch (node.name) {
			case 'description':
				// just skip
				break;
			case 'parameter':
				// not sure why there's parameter at this level
				break;
			case 'module':
				return parseModule(node);
				break;
			case 'command':
				return parseCommand(node);
				break;
		}
	}).compact();

	// concat all the nodes
	var first = true;
	var nodesText = _(nodes).reduce(function (result, node) {
		var text = result +
			(first ? '' : '.then(') +
			node +
			(first ? '()' : '') + //execute the first command
			')' +
			newLine +
			indent.repeat(2);
		first = false;
		return text;
	}, '');

	nodesText = nodesText.trim() + ';';
	return stuff +
		vars.join(newLine) +
		newLine.repeat(2) +
		exportBegin +
		'return ' +
		nodesText +
		exportEnd;
}