'use strict';

var parseParam = require('./param');
require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

module.exports = function (module, padding) {
	var dep = module.attributes.name.split('.').join('/');
	var params;
	var comments = [];
	var params = ['data'];
	module.children.forEach(function (c) {
		switch (c.name) {
			case 'parameter':
				params.push(parseParam(c.attributes));
				break;
			case 'comment':
				comments.push(c.content);
				break;
		}
	});
	var comment = (comments.length > 0 ? '// ': '') + comments.join(', ');
	return indent.repeat(padding) + 'describe(\'' + dep + '\', function (data) {' + newLine
		+ indent.repeat(padding + 1) + 'require(\'' + dep + '\')'
		+ '('
		+ params.join(', ')
		+ ');'
		+ (comment ? indent : '') + comment + newLine
		+ indent.repeat(padding) + '});'
		;
}