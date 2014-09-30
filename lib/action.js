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
			text = (first ? '' : '.then(')
					+ requireModule(node, wrapped)
					+ (first ? '' : ')');
				first = false;
			break;
		case 'command':
			text = (first ? '' : '.then(')
					+ requireCommand(node, wrapped)
					+ (first ? '' : ')');
				first = false;
			break;
	}
	return text;
}