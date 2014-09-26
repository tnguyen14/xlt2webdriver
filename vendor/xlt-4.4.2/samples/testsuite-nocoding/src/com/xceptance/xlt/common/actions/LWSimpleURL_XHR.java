/*
 * File: LWSimpleURL_XHR.java
 * Created on: Jul 18, 2014
 * 
 * Copyright 2014
 * Xceptance Software Technologies GmbH, Germany.
 */
package com.xceptance.xlt.common.actions;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.List;

import com.gargoylesoftware.htmlunit.HttpMethod;
import com.gargoylesoftware.htmlunit.WebRequest;
import com.gargoylesoftware.htmlunit.util.NameValuePair;
import com.xceptance.xlt.api.actions.AbstractLightWeightPageAction;
import com.xceptance.xlt.common.tests.AbstractURLTestCase;
import com.xceptance.xlt.common.util.CSVBasedURLAction;

/**
 * Performs an AJAX request.
 * 
 * @author Hartmut Arlt (Xceptance Software Technologies GmbH)
 */
public class LWSimpleURL_XHR extends LWSimpleURL
{
    /**
     * Constructor.
     * 
     * @param testCase
     * @param prevAction
     * @param action
     */
    public LWSimpleURL_XHR(final AbstractURLTestCase testCase, final AbstractLightWeightPageAction prevAction,
        final CSVBasedURLAction action)
    {
        super(testCase, prevAction, action);
    }

    /**
     * Constructor.
     * 
     * @param previousAction
     * @param timerName
     */
    public LWSimpleURL_XHR(final AbstractURLTestCase testCase, final CSVBasedURLAction action, final String login,
        final String password)
    {
        super(testCase, action, login, password);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected WebRequest createWebRequestSettings(final URL url, final HttpMethod method,
                                                  final List<NameValuePair> requestParameters)
        throws MalformedURLException
    {
        final WebRequest request = super.createWebRequestSettings(url, method, requestParameters);
        request.setAdditionalHeader("X-Requested-With", "XMLHttpRequest");
        request.setAdditionalHeader("Referer", getPreviousAction().getURL().toExternalForm());
        request.setXHR();

        return request;

    }
}
