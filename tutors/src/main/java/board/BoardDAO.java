package board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO implements BoardService {
	@Autowired private SqlSession sql;
	
	@Override
	public void board_insert(BoardVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<BoardVO> board_list() {
		return sql.selectList("board.mapper.list");
	}

	@Override
	public BoardVO board_view(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void board_read(int id) {
		// TODO Auto-generated method stub

	}

	@Override
	public void board_update(BoardVO vo) {
		// TODO Auto-generated method stub

	}

	@Override
	public void board_delete(int id) {
		// TODO Auto-generated method stub

	}

	@Override
	public BoardPage board_list(BoardPage page) {
		page.setTotalList(sql.selectOne("board.mapper.totalList", page));
		page.setList(sql.selectList("board.mapper.list", page));
		return page;
	}

}
