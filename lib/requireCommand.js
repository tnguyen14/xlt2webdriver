'use strict';

var parseCommand = require('./parseCommand');

module.exports = function(command) {
	var c = parseCommand(command);
	return 'client.' + command.name;
}