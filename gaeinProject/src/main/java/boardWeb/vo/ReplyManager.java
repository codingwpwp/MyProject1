package boardWeb.vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import boardWeb.util.DBManager;

public class ReplyManager {
	public Reply reply = new Reply();
	String sql;
	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rsMidx = null;
	
	public ReplyManager(int lidx, int bidx, int midx, String rcontent) {	// 댓글 작성
		try {
			conn = DBManager.getConnection();
			
			// 댓글을 등록하는 과정
			sql = "INSERT INTO boardreply(ridx, lidx, bidx, midx, rcontent) VALUES(b_ridx_seq.nextval,?,?,?,?)";
			psmt = conn.prepareStatement(sql);
			psmt.setInt(1, lidx);
			psmt.setInt(2, bidx);
			psmt.setInt(3, midx);
			psmt.setString(4, rcontent);
			psmt.executeUpdate();
			
			// DB에 추가한 댓글의 번호를 불러오는 과정
			psmt = null;
			sql = "SELECT max(ridx) AS ridx FROM boardreply";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				reply.setRidx(rs.getInt("ridx"));
			}
			rs = null;
			
			// 올린 댓글을 조회하는 과정
			sql = "SELECT midx, rcontent, TO_CHAR(rdate, 'YYYY-MM-DD HH24:MI:SS') as rdate FROM boardreply WHERE ridx = " + reply.getRidx();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				reply.setMidx(rs.getInt("midx"));
				reply.setRcontent(rs.getString("rcontent"));
				reply.setRdate(rs.getString("rdate"));
				
				psmt = null;
				sql = "SELECT nickname, position FROM assamember WHERE midx = " + rs.getInt("midx");
				psmt = conn.prepareStatement(sql);
				rsMidx = psmt.executeQuery();
				if(rsMidx.next()) {
					reply.setNickname(rsMidx.getString("nickname"));
					reply.setPosition(rsMidx.getString("position"));
				}
				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs, rsMidx);
		}
	}
	
	public ReplyManager(int ridx, String rcontent) {	// 댓글 수정
		try {
			
			conn = DBManager.getConnection();
			sql = "UPDATE boardreply SET rcontent=?,MODIFYYN='Y' WHERE ridx = ?" ;
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, rcontent);
			psmt.setInt(2, ridx);
			psmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs);
		}
	}
	
	public ReplyManager(int ridx) {		// 댓글 삭제
		try {
			conn = DBManager.getConnection();
			sql = "UPDATE boardreply SET delyn = 'N' WHERE ridx = " + ridx;
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt);
		}
	}
}
