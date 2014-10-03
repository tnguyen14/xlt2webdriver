'use strict';

/**
 * parse a native XLT command
 **/

var _ = require('lodash');
var config = require('../config.json');
var chalk = require('chalk');
var SupportedCommands = require('./supportedCommands').webdriver;

module.exports = function (command) {
	var c = {};
	var sc = _(SupportedCommands).find(function (comm, key) {
		return command.attributes.name === key;
	});
	if (sc) {
		if (_(sc).isObject()) {
			c = sc;
		} else {
			c.name = sc;
		}
	} else {
		console.log(chalk.red('Error: Command \'%s\' is not supported'), command.attributes.name);
		c.name = command.attributes.name;
	}
	return c;
}