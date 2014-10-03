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
			case 'parameter':
				params.push(parseParam(c.attributes));
				break;
		}
	})
	if (wrapped === false) {
		return 'client.' + c.name
			+ '('
			+ params.join(', ')
			+')'
			+ (comments ? indent : '') + comments;
	} else {
		return 'function () {'
			+ (comments ? newLine + indent.repeat(3) : '') + comments
			+ newLine + indent.repeat(3) + 'return client.'
			+ c.name
			+ '('
			+ params.join(', ')
			+ '); '
			+ newLine + indent.repeat(2)
			+ '}';
	}
}