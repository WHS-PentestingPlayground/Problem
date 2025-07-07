package com.whs3.playground.board.controller;

import com.whs3.playground.board.dto.BoardRequestsDto;
import com.whs3.playground.board.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import jakarta.servlet.ServletContext;

@Controller
@RequestMapping("/board")
@RequiredArgsConstructor
public class BoardViewController {

    private final BoardService boardService;
    @Autowired
    private ServletContext servletContext;

    @GetMapping("/posts")
    public String showPosts(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        // posts 라는 이름으로 getPosts()로 얻은 이 게시글 목록 데이터를 JSP 뷰로 전달한다.
        // JSP 파일에선 ${posts}를 통해 이를 출력하는 것.
        model.addAttribute("posts", boardService.getPosts());
        model.addAttribute("username", userDetails.getUsername());
        return "posts";
    }

    @GetMapping("/post")
    public String showCreatePost() {
        return "createPost";
    }

    @PostMapping("/post")
    public String createPost(@ModelAttribute BoardRequestsDto boardRequestsDto,
                             @RequestParam(value = "file", required = false) MultipartFile file,
                             @AuthenticationPrincipal UserDetails userDetails, Model model) throws IOException {
        String username = userDetails.getUsername();
        boardRequestsDto.setAuthor(username);

        // 파일 업로드 처리 (이미지 파일만 허용)
        if (file != null && !file.isEmpty()) {
            if (file.getContentType() == null || !file.getContentType().startsWith("image/")) {
                model.addAttribute("error", "이미지 파일만 업로드할 수 있습니다.");
                return "createPost";
            }
            String uploadDir = servletContext.getRealPath("/uploads/");
            java.io.File dir = new java.io.File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            String fileName = file.getOriginalFilename();
            java.io.File dest = new java.io.File(dir, fileName);
            file.transferTo(dest);
            boardRequestsDto.setFilePath("/uploads/" + fileName);
        }

        boardService.createPost(boardRequestsDto);
        return "redirect:/board/posts";
    }

    @GetMapping("/post/{id}")
    public String getPost(Model model, @PathVariable Long id, @AuthenticationPrincipal UserDetails userDetails){ // URL입력에서 id=1이라고 안해도 id값으로 넣어줌
        model.addAttribute("post", boardService.getPost(id));
        model.addAttribute("username", userDetails.getUsername());
        return "post";
    }

    @GetMapping("/edit/post/{id}")
    public String editPost(Model model,  @PathVariable Long id, @AuthenticationPrincipal UserDetails userDetails) {
        model.addAttribute("post", boardService.getPost(id));
        model.addAttribute("username", userDetails.getUsername());
        return "editPost";
    }

    @PutMapping("/post/{id}")
    public String updatePost(Model model, @PathVariable Long id, @ModelAttribute BoardRequestsDto requestsDto) throws Exception{
        model.addAttribute("post", boardService.updatePost(id, requestsDto));
        return "redirect:/board/posts";
    }

    @DeleteMapping("/post/{id}")
    public String deletePost(Model model, @PathVariable Long id, @ModelAttribute BoardRequestsDto requestsDto) throws Exception{
        model.addAttribute("post", boardService.deletePost(id, requestsDto));
        return "redirect:/board/posts";
    }
}