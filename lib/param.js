'use strict';

/**
 * parse param for an action - either a module or command
 **/

var chalk = require('chalk');
var _ = require('lodash');

// @param {string} text the value of the param
function target(text) {
	// possible type: css, id, name, link, xpath, data, placeholder, regexp, nested object
	var t = {
		type: 'string',
		value: text
	}, t2;

	// match xpath
	var x = text.match(/^\/{2}/);
	if (x) {
		t.type = 'xpath';
		t.value = text;
	}
	// match data substitution
	// match globally for multiple substitutions
	var d = text.match(/\${(\w+)}\s*/g);
	if (d) {
		t.type = 'data';
		t.value = d.map(function (t) {
			return t.match(/\${(\w+)}/)[1];
		});;
	}
	// match placeholder
	var p = text.match(/@{(\w+)}/);

	// match selector css=, id=, name=, link=
	var s = text.match(/^(\w+)\s*=\s*(.+)/);

	if (p) {
		t.type = 'placeholder';
		t.value = p[1];
	}
	if (s) {
		t2 = _.clone(t);
		t.type = 'selector';
		t.selector = s[1];
		t.value = s[2];
		if (t2.type === 'regexpi') {
			t.type = 'nested';
			t.value = t2;
		}
	}
	return t;
}
function element(e) {
	var text = '';
	switch (e.type) {
		case 'data':
			text = e.value.map(function (d) {
				return 'data.' + d;
			}).join(' + ');
			break;
		case 'placeholder':
			text = e.value;
			break;
		case 'selector':
			text = selector(e);
			break;
		case 'nested':
			text = element(e.value);
			break;
		case 'string':
		case 'xpath':
			text = '"' + e.value + '"';
			break;
		default:
			text = e.value;
	}
	return text;
}

function selector(e) {
	var text = '';
	switch (e.selector) {
		// convert id selector to css selector
		case 'id':
			text = '"#' + e.value + '"';
			break;
		case 'name':
			// use regex to just get the name attribute value
			// this is to avoid selector such as
			// `name=foo value=bar`
			// the value part will be dropped from the matched RE
			var n = e.value.match(/(\w+)/);
			text = '"[name=\'' + n[1] + '\']"';
			break;
		// preserve css selector
		case 'css':
			text = '"' + e.value + '"';
			break;
		case 'link':
			text = '"=' + e.value + '"';
			break;
	}
	return text;
}

module.exports = function (param) {
	return element(target(param.value));
}