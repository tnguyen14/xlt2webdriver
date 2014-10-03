'use strict';

var _ = require('lodash');
require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';
var useStrict = '\'use strict\';' + newLine.repeat(2);
var supportedCommands = require('./supportedCommands').webdriver;

module.exports = function (clientPath) {
	var vars = [
		'var client = require(\'' + clientPath + '\');',
		'var Promise = require(\'promise\');'
	];
	var commands = _(supportedCommands).map(function (c, key) {
		return 'exports.' + key
			+ ' = Promise.denodeify('
			+ 'client.' + key
			+ ').bind(client);';
	});
	return useStrict
		+ vars.join(newLine)
		+ newLine.repeat(2)
		+ commands.join(newLine);
};
