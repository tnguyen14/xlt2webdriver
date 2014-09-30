'use strict';

var parseParam = require('./param');
require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

module.exports = function (module, wrapped) {
	// module dependency is in module.attributes.name with values like this
	// A_common.command.WaitForText
	// var paths = module.attributes.name.split('.');
	// var dep = paths[paths.length -1];
	var dep = module.attributes.name;
	var params;
	var comments = '';
	var params = [];
	module.children.forEach(function (c) {
		switch (c.name) {
			case 'parameter':
				params.push(parseParam(c.attributes));
				break;
			case 'comment':
				comments += newLine + indent.repeat(3) +'// ' + c.content;
				break;
		}
	});
	if (wrapped === false) {
		return comments
			+ 'require(\'' + dep + '\')'
			+ '('
			+ params.join(', ')
			+ ')';
	} else {
		return 'function () {'
			+ comments
			+ newLine + indent.repeat(3)
			+ 'return require(\'' + dep + '\')'
			+ '('
			+ params.join(', ');
			+ ');'
			+ newLine + indent.repeat(2)
			+ '}';
	}

}