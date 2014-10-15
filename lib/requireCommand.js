'use strict';

var parseCommand = require('./command');
var parseParam = require('./param');
require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

module.exports = function(command, padding) {
	var c = parseCommand(command);
	var params = [];
	var comments = [];
	var assert = {
		command: 'ok',
		values: ['true']
	}
	command.children.forEach(function (child) {
		switch (child.name) {
			case 'comment':
				comments.push(child.content);
				break;
		}
	});
	var comment = comments.join(', ');

	if (c.type === 'action') {
		// if both are set
		if (command.attributes.target && command.attributes.value) {
			params[0] = parseParam(command.attributes.target);
			params[1] = parseParam(command.attributes.value);
		} else {
			params[0] = parseParam(command.attributes.value || command.attributes.target);
		}
		if (c.reverse) {
			// 2nd parameter is time in ms (default to 500)
			// 3rd parameter is reverse
			params.push(500, true);
		}
	} else if (c.type === 'assert') {
		// for assertions, use both target and value
		params[0] = parseParam(command.attributes.target);
		// handle element count
		if (c.count) {
			assert.values[0] = 'res.value.length';
		} else {
			assert.values[0] = 'res';
		}
		assert.command = c.assert;

		if (command.attributes.value !== undefined) {
			assert.values.push(parseParam(command.attributes.value));
		}
	}

	return indent.repeat(padding) + (comment ? '// ' : '') + comment + newLine
		+ indent.repeat(padding) + 'it("' + command.attributes.name + '", function () {' + newLine
		+ indent.repeat(padding + 1) + 'return webdriver.' + c.name
		+ '(' + params.join(', ') + ')'
		+ '.then(function (res) {' + newLine
		+ indent.repeat(padding + 2) + 'assert.' + assert.command
		+ '(' + assert.values.join(', ') + ');' + newLine
		+ indent.repeat(padding + 1) + '});' + newLine
		+ indent.repeat(padding) + '});'
}