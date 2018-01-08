package hu.jenkinstest;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.internal.util.reflection.Whitebox;
import org.mockito.runners.MockitoJUnitRunner;

import hu.jenkinstest.controller.TestREST;

@RunWith(MockitoJUnitRunner.class)
public class TestRESTTest {

    private TestREST target;

    private String prop = "AAA";

    @Before
    public void init() {
        target = new TestREST();
        Whitebox.setInternalState(target, "property", prop);
    }

    @Test
    public void testCreateSzemAdatFromErtesites() {
        String result = target.testProperty();
        Assert.assertEquals(prop, result);
    }

}
