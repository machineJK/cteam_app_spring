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
		sql.insert("board.mapper.insert", vo);
	}

	@Override
	public List<BoardVO> board_list() {
		return sql.selectList("board.mapper.list");
	}

	@Override
	public BoardVO board_view(int id) {
		return sql.selectOne("board.mapper.view", id);
	}

	@Override
	public void board_read(int id) {
		sql.update("board.mapper.read", id);

	}

	@Override
	public int board_update(BoardVO vo) {
		return sql.update("board.mapper.update", vo);
	}

	@Override
	public int board_delete(int board_num) {
		return sql.delete("board.mapper.delete", board_num);
	}

	@Override
	public BoardPage board_list(BoardPage page) {
		page.setTotalList(sql.selectOne("board.mapper.totalList", page));
		page.setList(sql.selectList("board.mapper.list", page));
		return page;
	}

	@Override
	public int board_comment_insert(BoardVO vo) {
		return sql.insert("board.mapper.comment_insert", vo);
	}

	@Override
	public List<BoardVO> board_comment_list(int id) {
		return sql.selectList("board.mapper.comment_list", id);
	}


}
