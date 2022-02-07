package boardWeb.vo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import boardWeb.util.DBManager;

public class ViewFilter {
	
	public int replycnt;
	String sql;
	String sqlCommuapply;
	String listtable;

	public Commuapply commuapply = new Commuapply();
	public Gul gulView = new Gul();
	public ArrayList<Reply> replyList = new ArrayList<>();
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rsMidxOrCommuApply = null;
	
	public ViewFilter(int lidx, int bidx) {
		
		try {
			conn = DBManager.getConnection();
			
			// lidx를 이용하여 boardlist의 listtable을 호출하는 과정
			sql = "SELECT listtable FROM boardlist WHERE lidx = " + lidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				listtable = rs.getString("listtable");
			}
			psmt = null;
			rs = null;
			
			
			// 호출된 테이블의 게시글을 호출하는 과정
			sql = "SELECT midx, bidx, subject, content, writesort, hit, TO_CHAR(writeday, 'YYYY-MM-DD') AS writeday FROM " + listtable + " WHERE bidx = " + bidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				gulView.setMidx(rs.getInt("midx"));
				gulView.setBidx(rs.getInt("bidx"));
				gulView.setHit(rs.getInt("hit"));
				gulView.setWritesort(rs.getString("writesort"));
				gulView.setWriteday(rs.getString("writeday"));
				gulView.setSubject(rs.getString("subject"));
				gulView.setContent(rs.getString("content"));
				
				
				if(listtable.equals("jauboard") && gulView.getWritesort().equals("커뮤신청")){
					
					psmt = null;
					sqlCommuapply = "SELECT * FROM jauboard_commuapply WHERE bidx = " + bidx;
					psmt = conn.prepareStatement(sqlCommuapply);
					rsMidxOrCommuApply = psmt.executeQuery();
					
					if(rsMidxOrCommuApply.next()) {
						commuapply.setCommuTitle(rsMidxOrCommuApply.getString("COMMUTITLE"));
						commuapply.setListIntroduce(rsMidxOrCommuApply.getString("LISTINTRODUCE"));
						commuapply.setWritesortcnt(rsMidxOrCommuApply.getInt("WRITESORTCNT"));
						commuapply.setWritesort1(rsMidxOrCommuApply.getString("WRITESORT1"));
						commuapply.setWritesort2(rsMidxOrCommuApply.getString("WRITESORT2"));
						if(rsMidxOrCommuApply.getString("WRITESORT3") != null) {
							commuapply.setWritesort3(rsMidxOrCommuApply.getString("WRITESORT3"));
						}
						if(rsMidxOrCommuApply.getString("WRITESORT4") != null) {
							commuapply.setWritesort4(rsMidxOrCommuApply.getString("WRITESORT4"));
						}
						if(rsMidxOrCommuApply.getString("WRITESORT5") != null) {
							commuapply.setWritesort5(rsMidxOrCommuApply.getString("WRITESORT5"));
						}
						commuapply.setCommuReason(rsMidxOrCommuApply.getString("COMMUREASON"));
						commuapply.setOkyn(rsMidxOrCommuApply.getString("OKYN"));
					}
					
					rsMidxOrCommuApply = null;
				}else{
					gulView.setContent(rs.getString("content"));
				}
				
				
				psmt = null;
				sql = "SELECT nickname, position FROM assamember WHERE midx = " + rs.getInt("midx");
				psmt = conn.prepareStatement(sql);
				rsMidxOrCommuApply = psmt.executeQuery();
				if(rsMidxOrCommuApply.next()) {
					gulView.setNickname(rsMidxOrCommuApply.getString("nickname"));
					gulView.setPosition(rsMidxOrCommuApply.getString("position"));
				}
			}
			psmt = null;
			rs = null;
			rsMidxOrCommuApply = null;
			
			// 해당 게시글의 댓글들을 호출하는 과정
			sql = "SELECT ridx, midx, rcontent, TO_CHAR(rdate, 'YYYY-MM-DD HH24:MI:SS') as rdate, modifyyn FROM boardreply WHERE lidx = " + lidx + " AND bidx = " + bidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				Reply reply = new Reply();
				
				reply.setRidx(rs.getInt("ridx"));
				reply.setMidx(rs.getInt("midx"));
				reply.setRcontent(rs.getString("rcontent"));
				reply.setRdate(rs.getString("rdate"));
				reply.setModifyyn(rs.getString("modifyyn"));
				psmt = null;
				sql = "SELECT nickname, position FROM assamember WHERE midx = " + rs.getInt("midx");
				psmt = conn.prepareStatement(sql);
				rsMidxOrCommuApply = psmt.executeQuery();
				if(rsMidxOrCommuApply.next()) {
					reply.setNickname(rsMidxOrCommuApply.getString("nickname"));
					reply.setPosition(rsMidxOrCommuApply.getString("position"));
				}
				
				replyList.add(reply);
				replycnt++;
			}
			
			psmt = null;
			rs = null;
			rsMidxOrCommuApply = null;
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs, rsMidxOrCommuApply);
		}
	}
	
	
	public ViewFilter(int lidx, int bidx, String delete) {
		conn = DBManager.getConnection();
		try {
			sql = "SELECT listtable FROM boardlist WHERE lidx = " + lidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				listtable = rs.getString("listtable");
			}
			psmt = null;
			rs = null;
			
			sql = "UPDATE " + listtable + " set delyn='Y' WHERE bidx=" + bidx;
			psmt = conn.prepareStatement(sql);
			psmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs);
		}
	}
}
