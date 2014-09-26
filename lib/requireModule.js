'use strict';

module.exports = function (module) {
	return 'require(\'' + module.attributes.name + '\')';
}