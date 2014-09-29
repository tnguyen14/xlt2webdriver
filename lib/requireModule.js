'use strict';

require('string.prototype.repeat');
var newLine = '\n';
var indent = '\t';

module.exports = function (module, wrapped) {
	if (wrapped === false) {
		return 'require(\'' + module.attributes.name + '\')';
	} else {
		return 'function () {' +
			newLine + indent.repeat(3) +
			'return require(\'' + module.attributes.name + '\')' +
			'();' +
			newLine + indent.repeat(2) +
			'}';
	}

}