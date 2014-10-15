'use strict';

/**
 * parse a native XLT command
 **/

var _ = require('lodash');
var chalk = require('chalk');
var Supported = require('./supported');
var SupportedCommands = Supported.webdriver;
var SupportedAsserts = Supported.asserts;

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
		c.type = 'action';
	} else {
		var sa = _(SupportedAsserts).find(function (assert, key) {
			return command.attributes.name === key;
		});
		if (sa) {
			c = sa;
			c.type = 'assert';
		} else {
			console.log(chalk.red('Error: Command \'%s\' is not supported'), command.attributes.name);
			c.name = command.attributes.name;
		}
	}
	return c;
}