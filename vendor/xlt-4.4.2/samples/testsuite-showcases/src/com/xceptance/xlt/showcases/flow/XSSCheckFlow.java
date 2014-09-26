package com.xceptance.xlt.showcases.flow;

import java.util.LinkedList;
import java.util.List;

import org.junit.Assert;

import com.gargoylesoftware.htmlunit.html.HtmlElement;
import com.gargoylesoftware.htmlunit.html.HtmlForm;
import com.gargoylesoftware.htmlunit.html.HtmlInput;
import com.xceptance.xlt.api.actions.AbstractHtmlPageAction;
import com.xceptance.xlt.api.tests.AbstractTestCase;
import com.xceptance.xlt.showcases.actions.ProcessXSSAttack;

/**
 * Tests the provided page for XSS vulnerabilities. Quite similar to the TXSSCrawler test case. But now it is possible
 * to integrate this flow object into established test case to check forms on protected pages(account pages)
 */
public class XSSCheckFlow extends AbstractTestCase
{
    /**
     * Test the current page for XSS vulnerabilities.
     * 
     * @param previousAction
     *            the xss candidate page
     * @param xssCheckConfig
     *            configuration for the xss check
     */

    public void run(final AbstractHtmlPageAction previousAction, final XSSCheckFlowConfig xssCheckConfig) throws Throwable
    {
        final AbstractHtmlPageAction latestAction = previousAction;

        // this action will perform the tests whether page was vulnerable
        ProcessXSSAttack processAttack;

        // set timeout
        final long timeout = System.currentTimeMillis() + (xssCheckConfig.getRuntime() * 60000);

        // collect all forms on the page
        final List<HtmlForm> pageForms = latestAction.getHtmlPage().getForms();

        // let's check each form
        for (final HtmlForm form : pageForms)
        {
            // stop when we reach timeout
            if (timeout < System.currentTimeMillis())
            {
                break;
            }

            // now we collect all inputs
            final List<HtmlInput> pageInputs = form.getHtmlElementsByTagName("input");

            // collect all clickable elements (submit buttons, inputs)
            final List<HtmlElement> clickableElements = new LinkedList<HtmlElement>();

            clickableElements.addAll((List<HtmlElement>) form.getByXPath(".//*[@type='submit'] | .//*[@type='button']"));

            // clickableElements.addAll((List<HtmlElement>) form
            // .getByXPath(".//*[@type='button']"));

            Assert.assertFalse(clickableElements.isEmpty());

            // loop over the attack strings
            for (final String attackString : xssCheckConfig.getXssAttackStrings())
            {

                // loop for different submit possibilities
                for (final HtmlElement clickableElement : clickableElements)
                {

                    // check each input individual
                    for (final HtmlInput input : pageInputs)
                    {
                        // if we have a submit input continue with next input
                        // if(input.getTypeAttribute().equals("submit"))
                        // {
                        // continue;
                        // }

                        // now we have everything we need
                        // let's start the test with this form, attack string
                        // and input
                        processAttack = new ProcessXSSAttack(latestAction, form, attackString, clickableElement, input);
                        processAttack.run();
                    }

                    // if we have more than one input (inputs of type submit
                    // excluded) we check all inputs of the form at same time
                    // with this attack string - in the best case the attack
                    // string is accepted for all inputs and we see the result
                    // page
                    if (pageInputs.size() - clickableElements.size() > 1)
                    {
                        processAttack = new ProcessXSSAttack(latestAction, form, attackString, clickableElement);
                        processAttack.run();
                    }
                }
            }
        }
    }
}
