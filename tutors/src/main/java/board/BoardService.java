package board;

import java.util.List;

public interface BoardService {
	void board_insert(BoardVO vo); //신규글 저장
	List<BoardVO> board_list(); //글목록조회
	BoardVO board_view(int id); //글 상세보기
	void board_read(int id); //글 조회수 증가 처리
	int board_update(BoardVO vo); //글 변경저장
	int board_delete(int board_num); //글 삭제
	BoardPage board_list(BoardPage page);
}
