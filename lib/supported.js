'use strict';

exports.webdriver = {
	'check': 'checkP',
	'uncheck': {
		name: 'checkP',
		reverse: 'true'
	},
	'click': 'clickP',
	'clickAndWait': 'clickP', // treat both clicks as the same for now
	'deleteAllVisibleCookies': 'deleteCookieP',
	'doubleClick': 'doubleClickP',
	'mouseOver': 'moveToObjectP',
	'open': 'urlP',
	'pause': 'pauseP',
	'store': {
		name: 'storeP',
		data: true
	},
	'storeEval': {
		name: 'storeEvalP',
		data: true
	},
	'storeText': {
		name: 'storeTextP',
		data: true
	},
	'storeXpathCount': {
		name: 'storeXpathCountP',
		data: true
	},
	'type': 'setValueP',
	'waitForChecked': 'waitForCheckedP',
	'waitForNotChecked': {
		name: 'waitForCheckedP',
		reverse: true
	},
	'waitForElementPresent': 'waitForExistP',
	'waitForNotElementPresent': {
		name: 'waitForExistP',
		reverse: true
	},
	'waitForNotText': {
		name: 'waitForTextP',
		reverse: true
	},
	'waitForText': 'waitForTextP',
	'waitForVisible': 'waitForVisibleP',
	'waitForNotVisible': {
		name: 'waitForVisibleP',
		reverse: true
	}
}

exports.asserts = {
	'assertChecked': {
		name: 'isSelectedP',
		assert: 'ok'
	},
	'assertNotChecked': {
		name: 'isSelectedP',
		assert: 'notOk'
	},
	'assertElementPresent': {
		name: 'isExistingP',
		assert: 'ok'
	},
	'assertNotElementPresent': {
		name: 'isExistingP',
		assert: 'notOk'
	},
	'assertText': {
		name: 'getTextP',
		assert: 'equal'
	},
	'assertValue': {
		name: 'getValueP',
		assert: 'equal'
	},
	'assertTitle': {
		name: 'getTitleP',
		assert: 'equal'
	},
	'assertVisible': {
		name: 'isVisibleP',
		assert: 'ok'
	},
	'assertNotVisible': {
		name: 'isVisibleP',
		assert: 'notOk'
	},
	'assertXpathCount': {
		name: 'elementsP',
		assert: 'equal',
		count: true
	}
}