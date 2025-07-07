package com.whs3.playground.board.repository;

import com.whs3.playground.board.entity.Board;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface BoardRepository extends JpaRepository<Board, Long> {
    // JPA를 사용해서 DB에 테이블 정보를 생성,저장,조회할 것이므로 JpaRepository 상속받는다. 제네릭스 타입은 <엔티티로 쓰는 클래스, id타입> 이다.

    List<Board> findAllByOrderByModifiedAtDesc();
}
