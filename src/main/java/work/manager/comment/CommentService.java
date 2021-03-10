package work.manager.comment;

import java.util.List;

public interface CommentService {

	void add(CommentVO commentVO);

	List<CommentVO> list(int work_num);

	CommentVO getComment(int cm_num);

	void modify(CommentVO commentVO);

	void delete(int cm_num);

}
