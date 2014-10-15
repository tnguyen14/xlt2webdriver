'use strict';

exports.webdriver = {
	'click': 'click',
	'clickAndWait': 'click', // treat both clicks as the same for now
	'deleteAllVisibleCookies': 'deleteCookie',
	'doubleClick': 'doubleClick',
	'open': 'url',
	'pause': 'pause',
	'type': 'setValue',
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

exports.asserts = {
	'assertChecked': {
		name: 'isSelected',
		assert: 'ok'
	},
	'assertNotChecked': {
		name: 'isSelected',
		assert: 'notOk'
	},
	'assertElementPresent': {
		name: 'isExisting',
		assert: 'ok'
	},
	'assertNotElementPresent': {
		name: 'isExisting',
		assert: 'notOk'
	},
	'assertText': {
		name: 'getText',
		assert: 'equal'
	},
	'assertValue': {
		name: 'getValue',
		assert: 'equal'
	},
	'assertVisible': {
		name: 'isVisible',
		assert: 'ok'
	},
	'assertNotVisible': {
		name: 'isVisible',
		assert: 'notOk'
	}
}