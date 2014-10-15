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
	var d = text.match(/\${(\w+)}/g);
	if (d) {
		t.type = 'data';
		t.value = '"' + text.replace(/\${(\w+)}/g, function (match, captured) {
			return '" + data.' + captured + ' + "';
		}) + '"';
	}
	// match placeholder
	var p = text.match(/@{(\w+)}/g);

	// match selector css=, id=, name=, link=
	var s = text.match(/^(\w+)\s*=\s*(.+)/);

	if (p) {
		t.type = 'placeholder';
		if (p.length > 1) {
		// for multiple placeholder instances
		// wrap every placeholder instance with double quote
		// wrap the whole value with double quote to escape the first and last quote created by the captured blocks
			t.value = '"' + text.replace(/@{(\w+)}/g, function (match, captured) {
				return '" + ' + captured + ' + "';
			}) + '"';
		} else {
		// for a single placeholder instance, just replace it directly
			t.value = text.replace(/@{(\w+)}/g, '$1');
		}
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

// parse the returned target
function element(e) {
	var text = '';
	switch (e.type) {
		case 'data':
			// text = e.value.map(function (d) {
			// 	return 'data.' + d;
			// }).join(' + ');
			text = e.value;
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

// parse param of type selector
function selector(e) {
	var text = '';

	// parse for placeholder
	var p = e.value.match(/@{(\w+)}/g);
	if (p) {
		// wrap every placeholder instance with double quote
		e.value = e.value.replace(/@{(\w+)}/g, function (match, captured) {
			return '" + ' + captured + ' + "';
		});
	}

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
		case 'link':
			text = '"=' + e.value + '"';
			break;
		case 'xpath':
			// sometimes xpath does not have // in front
			// this has to do with certain XLT command requiring not full xpaths
			if (!e.value.match(/^\/{2}/)) {
				text = '"//' + e.value + '"';
			} else {
				text = '"' + e.value + '"';
			}
			break;
		case 'css':
		default:
			text = '"' + e.value + '"';
	}
	return text;
}

module.exports = function (param) {
	var p;
	if (param === undefined) {
		return;
	}
	if (param.value === '') {
		return '""';
	}
	p = (param.value !== undefined) ? param.value : param;
	return element(target(p));
}