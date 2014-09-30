'use strict';

/**
 * parse a native XLT command
 **/

var _ = require('lodash');
var config = require('../config.json');
var chalk = require('chalk');

var SupportedCommands = {
	'click': 'click',
	'clickAndWait': 'click', // treat both clicks as the same for now
	'deleteAllVisibleCookies': 'deleteCookie',
	'doubleClick': 'doubleClick',
	'pause': 'pause',
	'waitForChecked': 'waitForChecked',
	'waitForNotChecked': {
		name: 'waitForChecked',
		reverse: true
	},
	'waitForElementPresent': 'waitForExist',
	'waitForNotElementPresent': {
		name: 'waitForExist',
		reverse: true
	},
	'waitForNotText': {
		name: 'waitForText',
		reverse: true
	},
	'waitForText': 'waitForText'
};

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