'use strict';

var newLine = '\n';
var indent = '\t';
var useStrict = '\'use strict\';' + newLine.repeat(2);
var exportBegin = 'module.exports = {' + newLine + indent;
var exportEnd = newLine + '};' + newLine;

module.exports = function (data) {
	return useStrict
		+ exportBegin
		+ data.map(function (d) {
			return '"' + d.name + '": ' + '"' + d.content + '"';
		}).join(', ' + newLine + indent)
		+ exportEnd;
}