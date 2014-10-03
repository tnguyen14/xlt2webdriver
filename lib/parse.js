'use strict';

var xmlParser = require('xml-parser');
var parseModule = require('./module');
var parseTestCase = require('./testCase');
var parseData = require('./data');

module.exports = function (xml) {
	var file = xmlParser(xml).root;
	var content;
	switch (file.name) {
		case 'scriptmodule':
			content = parseModule(file.children);
			break;
		case 'testcase':
			content = parseTestCase(file.children);
			break;
		case 'data':
			content = parseData(file.children);
			break;
	}
	return content;
};

