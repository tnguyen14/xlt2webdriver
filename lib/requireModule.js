'use strict';

require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

module.exports = function (module, wrapped) {
	// module dependency is in module.attributes.name with values like this
	// A_common.command.WaitForText
	// var paths = module.attributes.name.split('.');
	// var dep = paths[paths.length -1];
	var dep = module.attributes.name;
	if (wrapped === false) {
		return 'require(\'' + dep + '\')()';
	} else {
		return 'function () {' +
			newLine + indent.repeat(3) +
			'return require(\'' + dep + '\')' +
			'();' +
			newLine + indent.repeat(2) +
			'}';
	}

}