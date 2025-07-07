package com.whs3.playground.board.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardRequestsDto {
    private String title;
    private String contents;
    private String author;
    private String password;
    private String filePath;
}