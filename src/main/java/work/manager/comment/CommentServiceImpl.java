package work.manager.comment;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
@Service("commentService")
public class CommentServiceImpl implements CommentService{


	@Resource(name="commentMapper")
	private CommentMapper commentMapper;
	@Override
	public void add(CommentVO commentVO) {
		// TODO Auto-generated method stub
		commentMapper.add(commentVO);
	}
	@Override
	public List<CommentVO> list(int work_num) {
		// TODO Auto-generated method stub
		return commentMapper.list(work_num);
	}
	@Override
	public CommentVO getComment(int cm_num) {
		// TODO Auto-generated method stub
		return commentMapper.getComment(cm_num);
	}
	@Override
	public void modify(CommentVO commentVO) {
		// TODO Auto-generated method stub
		commentMapper.modify(commentVO);
		
	}
	@Override
	public void delete(int cm_num) {
		// TODO Auto-generated method stub
		commentMapper.delete(cm_num);
		
	}

}
