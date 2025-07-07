package com.whs3.playground.board.entity;

import com.whs3.playground.board.dto.BoardRequestsDto;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@Entity
@NoArgsConstructor
public class Board extends Timestamped{
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO) // db에서 id값 자동 증가
    private Long id;

    @Column(nullable = false) // null값 입력 불가능
    private String title;

    @Column(nullable = false)
    private String contents;

    @Column(nullable = false)
    private String author;

    @Column(nullable = true)
    private String filePath;

    public Board(BoardRequestsDto requestsDto){
        this.title = requestsDto.getTitle();
        this.contents = requestsDto.getContents();
        this.author = requestsDto.getAuthor();
        this.filePath = requestsDto.getFilePath();
    }

    public void update(BoardRequestsDto requestsDto) {
        this.title = requestsDto.getTitle();
        this.contents = requestsDto.getContents();
        this.author = requestsDto.getAuthor();
        this.filePath = requestsDto.getFilePath();
    }
}
