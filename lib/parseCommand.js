'use strict';
var _ = require('lodash');
var config = require('../config.json');

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
		console.log('Command \'' + command.attributes.name + '\' is not supported');
		c.name = command.attributes.name;
	}
	return c;
}