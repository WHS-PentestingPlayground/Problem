package com.whs3.playground.board.service;

import com.whs3.playground.board.dto.BoardRequestsDto;
import com.whs3.playground.board.dto.BoardResponseDto;
import com.whs3.playground.board.dto.SuccessResponseDto;
import com.whs3.playground.board.entity.Board;
import com.whs3.playground.board.repository.BoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor // boardRepository에 대해 생성자를 자동 생성(즉, 자동 의존성 주입)
public class BoardService {
    // Service 에서는 실제 사용할 메서드의 로직을 구현하는데, 데이터를 저장하거나 조회하려면 실제 데이터에 접근해야함으로 Repository 객체 선언
    private final BoardRepository boardRepository;

    @Transactional(readOnly = true)
    public List<BoardResponseDto> getPosts(){
        // BoardRepository에서 수정일시 기준 내림차순으로 모든 데이터를 가져온다. JPA가 기본적으로 findall을 제공해주는데, 이건 BoardRepository에서 따로 선언해 줘야함
        // BoardResponseDto에서 Board 엔티티를 넣으면 BoardResponseDto로 객체를 생성해주는 생성자를 만들었기 때문에 map(BoardResponseDt0::new)를 통해 편하게 dto로 바꿀 수 있다.
        return boardRepository.findAllByOrderByModifiedAtDesc().stream().map(BoardResponseDto::new).toList(); // 마지막엔 toList로 바꿔 리턴
    }

    @Transactional
    public BoardResponseDto createPost(BoardRequestsDto requestsDto){
        Board board = new Board(requestsDto);
        boardRepository.save(board);
        return new BoardResponseDto(board);
    }

    @Transactional
    public BoardResponseDto getPost(Long id){
        return boardRepository.findById(id).map(BoardResponseDto::new).orElseThrow(
                () -> new IllegalArgumentException("아이디가 존재하지 않습니다.")
        );
    }

    @PreAuthorize("@boardService.isAuthor(#id, principal.username)")
    @Transactional
    public BoardResponseDto updatePost(Long id, BoardRequestsDto requestsDto) throws Exception {
        Board board = boardRepository.findById(id).orElseThrow(
                () -> new IllegalArgumentException("아이디가 존재하지 않습니다.")
        );

        board.update(requestsDto);
        return new BoardResponseDto(board);
    }

    @PreAuthorize("@boardService.isAuthor(#id, principal.username) or hasRole('ADMIN')")
    @Transactional
    public SuccessResponseDto deletePost(Long id, BoardRequestsDto requestsDto) throws Exception {
        Board board = boardRepository.findById(id).orElseThrow(
                () -> new IllegalArgumentException("아이디가 존재하지 않습니다.")
        );

        boardRepository.deleteById(id);
        return new SuccessResponseDto(true);
    }

    public boolean isAuthor(Long postId, String username) {
        return boardRepository.findById(postId)
                .map(board -> board.getAuthor().equals(username))
                .orElse(false);
    }

}
