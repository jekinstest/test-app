package hu.jenkinstest.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("test")
public class TestREST {

    @Value("${test.property}")
    private String property;

    @RequestMapping(value = "/{id}")
    public String test(@PathVariable("id") String id) {
        return "Your ID: "+id;
    }

    @RequestMapping
    public String test2() {
        return "Select an ID 5!";
    }

    @RequestMapping(value = "property")
    public String testProperty() {
        return property;
    }

}
