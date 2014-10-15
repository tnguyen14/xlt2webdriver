'use strict';

/**
 * parse a scriptmodule element
 **/

var _ = require('lodash');
var parseAction = require('./action');
var newLine = '\n';
var indent = '\t';
require('string.prototype.repeat');
var useStrict = '\'use strict\';' + newLine.repeat(2);
var timestamp = '/**'
	+ newLine + ' * This file was automatically generated on ' + new Date()
	+ newLine + ' **/';

module.exports = function (module, name) {
	var comments = '';
	var vars = [
		'var webdriver = require(\'webdriver\');',
		'var data = require(\'globalData\');',
		'var assert = require(\'chai\').assert;'
	];
	var params = [];
	var exportBegin = 'module.exports = function (';
	var exportContinue = ') {' + newLine;
	var exportEnd = newLine + '};' + newLine;

	var describeBegin = 'describe(\'' + name + '\', function () {' + newLine;
	var describeEnd = '});';
	// concat all the nodes
	var nodes = _(module).reduce(function (result, node) {
		var text;
		switch (node.name) {
			// ignore `description` and `parameter` node
			case 'description':
				comments += '/**' + newLine
					+ '* ' + node.content + newLine
					+ '*/' + newLine.repeat(2);
				break;
			case 'parameter':
				params.push(node.attributes.name);
				break;
			case 'module':
			case 'command':
				text = parseAction(node, 2) + newLine;
				break;
		}
		if (!text) {
			return result;
		}
		return result + text;;
	}, '');

	nodes = nodes.trim();
	return timestamp + newLine.repeat(2)
		+ useStrict
		+ comments
		+ vars.join(newLine) + newLine.repeat(2)
		+ exportBegin
		+ params.join(', ')
		+ exportContinue
		+ indent + describeBegin
		+ indent.repeat(2) + nodes + newLine
		+ indent + describeEnd
		+ exportEnd;
}