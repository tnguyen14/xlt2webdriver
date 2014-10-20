'use strict';

/**
 * parse a test case
 **/

var _ = require('lodash');
var parseAction = require('./action');
var newLine = '\n';
var indent = '\t';
require('string.prototype.repeat');
var useStrict = '\'use strict\';' + newLine;
var timestamp = '/**'
	+ newLine + ' * This file was automatically generated on ' + new Date()
	+ newLine + ' **/';

module.exports = function (testcase) {
	var comments = [];
	var vars = [
		'var webdriver = require(\'webdriver\');',
		'var assert = require(\'chai\').assert;',
		'var _ = require(\'lodash\');',
		'var caseData = require(\'./data\');',
		'var globalData = require(\'globalData\');',
		'var data = _.extend(globalData, caseData);'
	];
	var exportBegin = 'module.exports = function () {' + newLine;
	var exportEnd = newLine + '};' + newLine;
	var nodes = _(testcase).reduce(function (result, node) {
		var text = '';
		switch (node.name) {
			// ignore `tags` node
			case 'description':
				comments.push(node.content);
				break;
			case 'action':
				text += indent.repeat(2) + '// Action - '
					+ node.attributes.name
					+ newLine;
				break;
			case 'module':
			case 'command':
				text = parseAction(node, 2) + newLine;
				break;
		}
		return result + text;
	}, '');
	var comment = comments.join(', ');
	var describeBegin = 'describe(\'' + comment + '\', function () {' + newLine;
	var describeEnd = '});';
	var setup = indent.repeat(2) + 'before(function () {' + newLine
		+ indent.repeat(3) + 'return webdriver.initP().then(function () {' + newLine
		+ indent.repeat(4) + 'return webdriver.urlP(data.shopURL)});' + newLine
		+ indent.repeat(2) + '});' + newLine;
	var teardown = indent.repeat(2) + 'after(function (done){' + newLine
		+ indent.repeat(3) + 'webdriver.localStorageP(\'DELETE\');'
		+ indent.repeat(3) + 'webdriver.end();' + newLine
		+ indent.repeat(3) + 'done();' + newLine
		+ indent.repeat(2) + '});' + newLine;

	return timestamp + newLine.repeat(2)
		+ useStrict
		+ (comment ? '// ' : '') + comment + newLine.repeat(2)
		+ vars.join(newLine) + newLine.repeat(2)
		+ exportBegin
		+ indent + describeBegin
		+ setup
		+ nodes
		+ teardown
		+ indent + describeEnd
		+ exportEnd;
}