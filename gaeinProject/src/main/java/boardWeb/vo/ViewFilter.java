package boardWeb.vo;

import java.util.*;
import java.sql.*;

import boardWeb.util.DBManager;

public class ViewFilter {
	
	String sql;
	String sqlCommuapply;
	public int replycnt;
	public int listmastermidx;	// 게시판의 관리자(수정할 때 사용)
	public String listtitle;	// 게시판의 한글이름
	
	// 수정할 때 사용
	public String writesort1;
	public String writesort2;
	public String writesort3;
	public String writesort4;
	public String writesort5;
	
	// 객체들
	public Gul gulView = new Gul();
	public Commuapply commuapply = new Commuapply();
	public ArrayList<Reply> replyList = new ArrayList<>();
	
	// 추천여부
	public int thumbSw;
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rsMidxOrCommuApply = null;
	
	public ViewFilter(int lidx, int bidx, int midx) {	// 세번째 매개값은 추천여부를 조회하기 위한 값이다.
		
		try {
			conn = DBManager.getConnection();
			
			// LIDX를 이용하여 BOARDLIST의 LISTTABLE을 호출하는 과정
			sql = "SELECT * FROM assaboardlist WHERE lidx = " + lidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				listtitle = rs.getString("listtitle");
				listmastermidx = rs.getInt("listmastermidx");
				writesort1 = rs.getString("WRITESORT1");
				writesort2 = rs.getString("WRITESORT2");
				if(rs.getString("WRITESORT3") != null) writesort3 = rs.getString("WRITESORT3");
				if(rs.getString("WRITESORT4") != null) writesort4 = rs.getString("WRITESORT4");
				if(rs.getString("WRITESORT5") != null) writesort5 = rs.getString("WRITESORT5");
			}
			psmt = null;
			rs = null;
			
			// 글을 호출하는 과정
			sql = "SELECT midx, subject, content, writesort, hit, thumb, TO_CHAR(writeday, 'YYYY-MM-DD') AS writeday FROM assaboard WHERE bidx = " + bidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				
				gulView.setHit(rs.getInt("hit"));
				gulView.setMidx(rs.getInt("midx"));
				gulView.setThumb(rs.getInt("thumb"));
				gulView.setContent(rs.getString("content"));
				gulView.setSubject(rs.getString("subject"));
				gulView.setWriteday(rs.getString("writeday"));
				gulView.setWritesort(rs.getString("writesort"));
				
				if(lidx == 1 && gulView.getWritesort().equals("커뮤신청")){
					
					psmt = null;
					sqlCommuapply = "SELECT * FROM ASSABOARD_COMMUAPPLY WHERE bidx = " + bidx;
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
			
			// 해당 글의 댓글들을 호출하는 과정
			sql = "SELECT ridx, midx, rcontent, TO_CHAR(rdate, 'YYYY-MM-DD HH24:MI:SS') as rdate, modifyyn FROM ASSABOARDREPLY WHERE delyn='N' AND lidx = " + lidx + " AND bidx = " + bidx;
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
			
			if(lidx != 1 && lidx != 2){
				
				sql = "SELECT * FROM ASSATHUMBLIST WHERE lidx = " + lidx +" AND bidx = " + bidx + " AND midx = " + midx;
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				if(rs.next()) thumbSw = 1;
				
				psmt = null;
				rs = null;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs, rsMidxOrCommuApply);
		}
	}
	
}
