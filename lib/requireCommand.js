'use strict';

var parseCommand = require('./parseCommand');
require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

module.exports = function(command, wrapped) {
	var c = parseCommand(command);
	if (wrapped === false) {
		return 'client.' + c.name;
	} else {
		return 'function () {' +
			newLine + indent.repeat(3) +
			'return client.' +
			c.name +
			'(); ' +
			newLine + indent.repeat(2) +
			'}';
	}
}