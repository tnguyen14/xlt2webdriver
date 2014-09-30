'use strict';

/**
 * parse param for an action - either a module or command
 **/

var chalk = require('chalk');

function target(text) {
	var t = text.match(/(\w+)\s*=\s*(.+)/);
	if (!t) return text;
	return t.slice(1);
}

module.exports = function (param) {
	var text = '';
	switch (param.name) {
		case 'clickElement':
		case 'typeElement':
			var element = target(param.value);
			if (!element) break;
			switch (element[0]) {
				// convert id selector to css selector
				case 'id':
					text = '\'#' + element[1] + '\'';
					break;
				// preserve css selector
				case 'css':
					text = '\'' + element[1] + '\'';
					break;
				default:
					// if it is a placeholder `@{clickElement}`
					console.log(chalk.cyan('%j'), param);
					text = element.replace(/@{(\w+)}/, '$1');
			}
			break;
		case 'xpathElement':
			console.log(chalk.blue('%j'), param);
			break;
		case 'milliseconds':
			text = param.value;
			break;
		case 'element':
			console.log(chalk.magenta('%j'), param.value);
		default:
			console.log(chalk.green('%j'), param);
	}
	return text;
}