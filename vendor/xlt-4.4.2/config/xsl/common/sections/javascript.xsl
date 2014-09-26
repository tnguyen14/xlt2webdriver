<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template name="javascript">
        <xsl:text disable-output-escaping="yes"><![CDATA[
<script type="text/javascript">
    function navigate(target) {
        // does it contain a #
        var pos = target.lastIndexOf("#");

        if (pos >= 0)
        {   
            // is it the current document?
            var targetDocument = target.slice(0, pos);
            var targetHashText = target.slice(pos);

            var path = window.location.pathname.split( '/' );
            var currentDocument = path[path.length - 1];

            if (targetDocument == currentDocument || targetDocument == "")
            {
                // before we run it, check that this exists 
                if (targetHashText.length > 0) {
                    // quote any "." in the hash, otherwise JQuery interprets the following chars as class 
                    targetHashText = targetHashText.replace(/\./g, "\\.");
                    $.scrollTo(targetHashText, 250, {easing:'swing', offset: {top: -35}}); 
                    return false;
                }
            }
        }

        return true;
    }

    function scrollTo() {
        navigate(window.location.hash);
    }
</script>

<script type="text/javascript">
        // start with on document ready and prep the functionality
        $(document).ready( function () {
            // setup menu
            $('#superfish').superfish({delay:0, autoArrows:false, speed:'fast'}); 

            // setup scrolling magic for navigation and summary tables
            $('#navigation a, table a').click( function() {
                    navigate($(this).attr('href'))
            });

            // setup click handler to scroll to the top of the page when clicking the navigation bar
            $('#navigation').click( function(event) {
                // handle direct click events only, but not events that bubbled up 
                if (event.target.id == this.id) {
                    $.scrollTo(0, 250, {easing:'swing'});
                }
            });

            // setup the tables
            Table.auto();

            // get the tabs set up
            try {
                $('.tabs').tabs();
            }
            catch (e) {
                // in case we so not have tabs
            }

            // lazy load the chart images to speed up the site
            $('div.charts div.chart-group').each( function() {
                var chartGroup = this;

                $('ul', this).each( function() {
                    var counter = 0;

                    $('a', this).each( function() {
                        // get the href
                        var id = $(this).attr('href');

                        // get the original image img
                        var img = $(id + '> div.chart > img', chartGroup);

                        if (counter != 0) {
                            $(this).click( function() {
                                    img.attr('src', img.attr('alt'));
                            });
                        } else {
                            // first tab, show immediately
                            img.attr('src', img.attr('alt'));
                        }

                        counter++;
                    });
                });

                // set click handler of back links in order to scroll to right position in document
                $('a.backlink', this).click( function() {
                    var timerId  = $(this).attr('href').substring(7),
                        selector = '.content a[data-timer-id=' + timerId + ']:visible',
                        target   = $(selector).get(0);

                    $.scrollTo(target, 250, {easing:'swing', offset: {top: -35}}); 
                });
            });

            // the tool tips
            // #request-summary .section > div .content > div .data > table #TABLE_1 .table-autosort:0 table-autostripe table-stripeclass:odd > tbody > tr . > td .key > a
            $('#request-summary table td.key a.cluetip').cluetip( {
                    hoverIntent: {
                        sensitivity:  1,
                        interval:     250,
                        timeout:      250
                    },
                    mouseOutClose: true,
                    closeText: 'x',
                    closePosition: 'title',
                    sticky: true,
                    local: true,
                    showTitle: false,
                    dropShadow: false,
                    positionBy: 'mouse',
                    clickThrough: true,
                    attribute: 'data-rel'
            });

            // the tool tips
            $('table th.cluetip').cluetip( {
                hoverIntent: {
                    sensitivity:  1,
                    interval:     250,
                    timeout:      250
                },
                mouseOutClose: true,
                closeText: 'x',
                closePosition: 'title',
                sticky: true,
                local: true,
                hideLocal: true,
                showTitle: false,
                dropShadow: false,
                positionBy: 'mouse',
                titleAttribute: '',
                attribute: 'data-rel'
            } );

            // the collapsible stack traces
            $(".collapsible").each( function() {
                // the first child is the expand/collapse trigger 
                $(this).children(":first").addClass("collapsible-collapsed").click( function() {
                    // restyle the trigger element
                    $(this).toggleClass("collapsible-collapsed");
                    $(this).toggleClass("collapsible-expanded");

                    // the next sibling is the element to show/hide 
                    $(this).next().toggle();
                });
            });

            // add double-click handler to tab headers which switches all tabs at once
            $(".charts div.tabs ul li").each( function() {
                // find the index of the current tab in the current tab pane
                var i = $("li", $(this).parent()).index(this) + 1;

                // add a handler that switches all tabs with the same index
                $("a", $(this)).dblclick(function() 
                {
                    // activate all tabs with the same index by simulating a single click
                    $(".charts div.tabs ul li:nth-child(" + i + ") a").click(); 
                });
            });

            // transform URLs in event messages to anchors
            $('#event-summary #TABLE_3 tbody tr td.text').each(function(){ 
                var $this = $(this);
                $this.html( $this.html().replace(/(https?:\/\/[^\s]+)/gi, "<a href='$1' target='_blank'>$1</a>") )
            });

            // see if we jumped and now have to scroll
            scrollTo();
        });  
</script>

    ]]></xsl:text>
    </xsl:template>

</xsl:stylesheet>
