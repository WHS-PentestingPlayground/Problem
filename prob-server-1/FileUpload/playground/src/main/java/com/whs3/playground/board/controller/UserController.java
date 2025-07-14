package com.whs3.playground.board.controller;

import com.whs3.playground.board.entity.User;
import com.whs3.playground.board.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping({"", "/"})
    public String index() {
        return "redirect:/board/posts";
    }

    @GetMapping("/loginForm")
    public String loginForm() {
        return "loginForm";
    }

    @GetMapping("/joinForm")
    public String joinForm() {
        return "joinForm";
    }

    @PostMapping("/join")
    public String join(User user, Model model) {
        if (userService.isUsernameDuplicate(user.getUsername())) {
            model.addAttribute("error", "이미 사용 중인 사용자 이름입니다.");
            return "joinForm";
        }

        userService.register(user);
        return "redirect:/loginForm";
    }
}
