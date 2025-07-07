package com.whs3.playground.board.service;

import com.whs3.playground.board.entity.User;
import com.whs3.playground.board.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public void register(User user) {
        // 사용자 이름이 "admin"이면 ROLE_ADMIN, 아니면 ROLE_USER
        if ("admin".equals(user.getUsername())) {
            user.setRole("ROLE_ADMIN");
        } else {
            user.setRole("ROLE_USER");
        }

        // 비밀번호 암호화
        String rawPassword = user.getPassword();
        String encPassword = bCryptPasswordEncoder.encode(rawPassword);
        user.setPassword(encPassword);

        // 사용자 저장
        userRepository.save(user);
    }

    public boolean isUsernameDuplicate(String username) {
        return userRepository.existsByUsername(username);
    }
}
