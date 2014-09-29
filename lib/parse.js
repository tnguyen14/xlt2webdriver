'use strict';

var xmlParser = require('xml-parser');
var parseModule = require('./parseModule');
var parseTestCase = require('./parseTestCase');

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
	}
	return content;
};

