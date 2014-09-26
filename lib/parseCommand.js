'use strict';

module.exports = function (command) {
	var c = {};
	var sc = _(SupportedCommands).find(function (comm, key) {
		return command.attributes.name === key;
	});
	if (sc) {
		if (_(sc).isObject()) {
			c = sc;
		} else {
			c.name = sc;
		}
	} else {
		console.log('Command \'' + command.attributes.name + '\' is not supported');
		c.name = command.attributes.name;
	}
	return c;
}