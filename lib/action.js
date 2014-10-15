'use strict';

/**
 * parse an action, either a module or command
 **/

var requireModule = require('./requireModule');
var requireCommand = require('./requireCommand');

module.exports = function (node, first) {
	var wrapped = first ? false : true;
	var text = '';
	switch (node.name) {
		case 'module':
			text = requireModule(node, wrapped);
			break;
		case 'command':
			text = requireCommand(node, wrapped);
			break;
	}
	return text;
}