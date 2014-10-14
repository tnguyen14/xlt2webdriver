'use strict';

var parseCommand = require('./command');
var parseParam = require('./param');
require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

module.exports = function(command, wrapped) {
	var c = parseCommand(command);
	var params = [];
	var comments = '';
	command.children.forEach(function (c) {
		switch (c.name) {
			case 'comment':
				comments += '// ' + c.content;
				break;
		}
	});
	// sometimes the param is set on the `value` attribute and not `target` attribute
	params[0] = parseParam(command.attributes.value || command.attributes.target);
	if (c.reverse) {
		// 2nd parameter is time in ms (default to 500)
		// 3rd parameter is reverse
		params.push(500, true);
	}
	if (wrapped === false) {
		return 'webdriver.' + c.name
			+ '('
			+ params.join(', ')
			+')'
			+ (comments ? indent : '') + comments;
	} else {
		return 'function () {'
			+ (comments ? newLine + indent.repeat(3) : '') + comments
			+ newLine + indent.repeat(3) + 'return webdriver.'
			+ c.name
			+ '('
			+ params.join(', ')
			+ '); '
			+ newLine + indent.repeat(2)
			+ '}';
	}
}