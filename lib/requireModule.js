'use strict';

require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

function target(text) {
	var t = text.match(/(\w+)\s*=\s*(.+)/);
	if (!t) return;
	return t.slice(1);
}

function param(p) {
	var text = '';
	switch (p.name) {
		case 'clickElement':
		case 'typeElement':
			var element = target(p.value);
			if (!element) break;
			switch (element[0]) {
				// convert id selector to css selector
				case 'id':
					text = '\'#' + element[1] + '\'';
					break;
				// preserve css selector
				case 'css':
					text = '\'' + element[1] + '\'';
					break;
				default:
					console.log(element);
			}
			break;
		default:
			console.log(p);
	}
	return text;
}

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
				params.push(param(c.attributes));
				break;
			case 'comment':
				comments += '// ' + c.content;
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
			+ newLine + indent.repeat(3)
			+ comments
			+ newLine + indent.repeat(3)
			+ 'return require(\'' + dep + '\')'
			+ '('
			+ params.join(', ');
			+ ');'
			+ newLine + indent.repeat(2)
			'}';
	}

}