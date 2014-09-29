'use strict';

var parseCommand = require('./parseCommand');
require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

module.exports = function(command) {
	var c = parseCommand(command);
	return 'function () {' + newLine + indent.repeat(3) + 'return client.' + c.name + '(); ' + newLine + indent.repeat(2) + '}';
}