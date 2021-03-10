package work.manager.work;

public class FileVO {
	
	private int file_num;
	private int file_wnum;
	private String file_name;
	private long file_size;
	private String file_original_name;
	private int file_using;
	public FileVO() {
		// TODO Auto-generated constructor stub
	}
	public FileVO(int file_wnum,String file_original_name,String file_name,long file_size) {
		// TODO Auto-generated constructor stub
		this.file_wnum = file_wnum;
		this.file_original_name = file_original_name;
		this.file_name = file_name;
		this.file_size = file_size;
	}
	public String getFile_original_name() {
		return file_original_name;
	}
	public long getFile_size() {
		return file_size;
	}
	public String getFile_name() {
		return file_name;
	}
	@Override
	public String toString() {
		return "FileVO [file_num=" + file_num + ", file_wnum=" + file_wnum + ", file_name=" + file_name + ", file_size=" + file_size + ", file_original_name=" + file_original_name + ", file_using=" + file_using + "]";
	}
	
	
}
