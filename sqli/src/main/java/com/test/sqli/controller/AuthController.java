package com.test.sqli.controller;

import com.test.sqli.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AuthController {

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/login")
    public String loginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, Model model) {
        // 필터링 적용
        if ( username.contains("--") || username.contains("or") || username.contains("OR")) {
            model.addAttribute("message", "유효하지 않은 입력입니다.");
            return "login";
        }

        // 비밀번호 해시 후 로그인 시도
        String hashedPassword = userRepository.hashPassword(password);
        boolean success = userRepository.loginVulnerable(username, hashedPassword);
        model.addAttribute("message", success ? "로그인 성공!" : "로그인 실패");
        return "login";
    }


    @GetMapping("/register")
    public String registerForm() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username, @RequestParam String password, Model model) {
        userRepository.register(username, password);
        model.addAttribute("message", "회원가입 성공!");
        return "register";
    }
}


