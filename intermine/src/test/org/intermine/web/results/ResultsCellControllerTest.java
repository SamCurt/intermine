package org.intermine.web.results;

/*
 * Copyright (C) 2002-2004 FlyMine
 *
 * This code may be freely distributed and modified under the
 * terms of the GNU Lesser General Public Licence.  This should
 * be distributed with the code.  See the LICENSE file for more
 * information or http://www.gnu.org/copyleft/lesser.html.
 *
 */

import java.util.List;

import servletunit.struts.MockStrutsTestCase;
import org.apache.struts.tiles.ComponentContext;

import org.intermine.metadata.Model;

import org.intermine.model.InterMineObject;
import org.intermine.model.testmodel.*;

public class ResultsCellControllerTest extends MockStrutsTestCase
{
    public ResultsCellControllerTest(String arg1) {
        super(arg1);
    }

    public void testBusinessObject() throws Exception {
        ComponentContext context = new ComponentContext();
        ComponentContext.setContext(context, getRequest());
        setRequestPathInfo("/initResultsCell");

        getRequest().setAttribute("object", new Department());
        actionPerform();

        Model model = Model.getInstanceByName("testmodel");
        assertNotNull(context.getAttribute("leafClds"));
        assertTrue(((List) context.getAttribute("leafClds")).contains(model.getClassDescriptorByName(Department.class.getName())));
        assertFalse(((List) context.getAttribute("leafClds")).contains(model.getClassDescriptorByName(RandomInterface.class.getName())));
        assertFalse(((List) context.getAttribute("leafClds")).contains(model.getClassDescriptorByName(InterMineObject.class.getName())));
    }

    public void testNonBusinessObject() throws Exception {
        ComponentContext context = new ComponentContext();
        ComponentContext.setContext(context, getRequest());
        setRequestPathInfo("/initResultsCell");

        getRequest().setAttribute("object", "test string");
        actionPerform();

        assertEquals(null, context.getAttribute("leafClds"));
    }
}
