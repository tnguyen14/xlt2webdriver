'use strict';

/**
 * parse an action, either a module or command
 **/

var requireModule = require('./requireModule');
var requireCommand = require('./requireCommand');

module.exports = function (node, padding) {
	var text = '';
	switch (node.name) {
		case 'module':
			text = requireModule(node, padding);
			break;
		case 'command':
			text = requireCommand(node, padding);
			break;
	}
	return text;
}