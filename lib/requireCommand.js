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
	command.children.forEach(function (child) {
		switch (child.name) {
			case 'comment':
				comments.push(child.content);
				break;
		}
	});
	var comment = comments.join(', ');

	// sometimes the param is set on the `value` attribute and not `target` attribute
	params[0] = parseParam(command.attributes.value || command.attributes.target);
	if (c.reverse) {
		// 2nd parameter is time in ms (default to 500)
		// 3rd parameter is reverse
		params.push(500, true);
	}

	return indent.repeat(padding) + 'it(\'' + comment + '\', function () {' + newLine
		+ indent.repeat(padding + 1) + 'return webdriver.' + c.name
		+ '(' + params.join(', ') + ')'
		+ '.then(function (res) {' + newLine
		+ indent.repeat(padding + 2) + 'assert.ok(true);' + newLine
		+ indent.repeat(padding + 1) + '});' + newLine
		+ indent.repeat(padding) + '});'
}