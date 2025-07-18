package com.whs.playground.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
  @GetMapping("/")
  public String index() {
    return "login";
  }

  @RequestMapping(value = "/login", method = {RequestMethod.GET, RequestMethod.POST})
  public String login(Dummy dummy) {
      return "login"; // 내부적으로 바인딩 하는 객체 필요
  }
  
  // 임시 객체
  public static class Dummy {
      private String test;
      public void setTest(String test) { this.test = test; }
      public String getTest() { return test; }
  }
}