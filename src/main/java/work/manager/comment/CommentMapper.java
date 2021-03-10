package work.manager.comment;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("commentMapper")
public interface CommentMapper {
	void add(CommentVO commentVO);
	List<CommentVO> list(int work_num);
	CommentVO getComment(int cm_num);

	void modify(CommentVO commentVO);
	void delete(int cm_num);
}
