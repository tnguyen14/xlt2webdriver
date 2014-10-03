'use strict';

exports.webdriver = {
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
}