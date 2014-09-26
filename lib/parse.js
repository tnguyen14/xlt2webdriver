'use strict';

var xmlParser = require('xml-parser');
var parseModule = require('./parseModule');

module.exports = function (xml) {
	var file = xmlParser(xml).root;
	var content;
	switch (file.name) {
		case 'scriptmodule':
			content = parseModule(file.children);
			break;
		case 'testcase':
			break;
	}
	return content;
};

