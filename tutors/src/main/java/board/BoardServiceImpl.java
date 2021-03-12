package board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired private BoardDAO dao;
	
	@Override
	public void board_insert(BoardVO vo) {
		dao.board_insert(vo);
	}

	@Override
	public List<BoardVO> board_list() {
		return dao.board_list();
	}

	@Override
	public BoardVO board_view(int id) {
		return dao.board_view(id);
	}

	@Override
	public void board_read(int id) {
		dao.board_read(id);

	}

	@Override
	public int board_update(BoardVO vo) {
		return dao.board_update(vo);
	}

	@Override
	public int board_delete(int board_num) {
		return dao.board_delete(board_num);

	}

	@Override
	public BoardPage board_list(BoardPage page) {
		return dao.board_list(page);
	}

}
