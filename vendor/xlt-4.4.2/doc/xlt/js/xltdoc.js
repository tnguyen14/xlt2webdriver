(function($){

    $(document).ready(function()
    {
        $('pre code').each(function()
        {
            var $this = $(this);
            $this.replaceWith($this.contents());
        });

        $('pre.java').each(function(){$(this).attr('class', 'brush: java')});
        $('pre.ruby').each(function(){$(this).attr('class', 'brush: ruby')});
        $('pre.java-nolines').each(function(){$(this).attr('class', 'brush: java; gutter: false')});
        $('pre.shell').each(function(){$(this).attr('class', 'brush: bash; gutter: false')});
        $('pre.javascript').each(function(){$(this).attr('class', 'brush: js')});
        $('pre.plain').each(function(){$(this).attr('class', 'brush: plain; gutter: false')});
        $('pre.xml').each(function(){$(this).attr('class', 'brush: xml; gutter: false')});
        $('pre.css').each(function(){$(this).attr('class', 'brush: css')});

        SyntaxHighlighter.defaults['toolbar'] = false;
        SyntaxHighlighter.all();

        // build the TOC
        $('#toc.numbered').toc(
        {
            exclude: 'h1, h5, h6',
        });

        // build the TOC
        $('#toc.unnumbered').toc(
        {
            exclude: 'h1, h5, h6',
            numerate: false
        });

        // apply the lightbox effect
        $('p.illustration a').lightbox();

        // strip our tables
        $("table tr:even").addClass("even");
        $("table tr:odd").addClass("odd");

		// setup scrolling magic for navigation and summary tables
		$('a').click(
			function() {
				var target = $(this).attr('href');
				$.scrollTo(target, 250, {easing:'swing', offset: {top: -35}});
			}
		);
    });

})(jQuery);
