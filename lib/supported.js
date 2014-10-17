'use strict';

exports.webdriver = {
	'check': 'check',
	'uncheck': {
		name: 'check',
		reverse: 'true'
	},
	'click': 'click',
	'clickAndWait': 'click', // treat both clicks as the same for now
	'deleteAllVisibleCookies': 'deleteCookie',
	'doubleClick': 'doubleClick',
	'mouseOver': 'moveToObject',
	'open': 'url',
	'pause': 'pause',
	'store': 'store',
	'storeEval': 'storeEval',
	'storeText': 'storeText',
	'storeXpathCount': 'storeXpathCount',
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
	'waitForText': 'waitForText',
	'waitForVisible': 'waitForVisible',
	'waitForNotVisible': {
		name: 'waitForVisible',
		reverse: true
	}
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
	'assertTitle': {
		name: 'getTitle',
		assert: 'equal'
	},
	'assertVisible': {
		name: 'isVisible',
		assert: 'ok'
	},
	'assertNotVisible': {
		name: 'isVisible',
		assert: 'notOk'
	},
	'assertXpathCount': {
		name: 'elements',
		assert: 'equal',
		count: true
	}
}