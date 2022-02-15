package boardWeb.vo;

import java.sql.*;
import java.util.*;
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
	
	// 객체
	public Gul gulView = new Gul();
	public Commuapply commuapply = new Commuapply();
	public ArrayList<Reply> replyList = new ArrayList<>();
	
	// 추천여부
	public int thumbSw;
	
	// DB기본세팅
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rsCommuapply = null;
	
	public ViewFilter(int lidx, int bidx, int midx) {	// 세번째 매개값은 추천여부를 조회하기 위한 값이다.
		
		try {
			conn = DBManager.getConnection();
			
			// LIDX를 이용하여 BOARDLIST의 LISTTABLE을 호출하는 과정
			sql = "SELECT * FROM assaboardlist WHERE lidx = " + lidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				listtitle = rs.getString("listtitle");
				writesort1 = rs.getString("writesort1");
				writesort2 = rs.getString("writesort2");
				listmastermidx = rs.getInt("listmastermidx");
				if(rs.getString("writesort3") != null) writesort3 = rs.getString("writesort3");
				if(rs.getString("writesort4") != null) writesort4 = rs.getString("writesort4");
				if(rs.getString("writesort5") != null) writesort5 = rs.getString("writesort5");
			}
			
			// 글을 호출하는 과정
			sql = "SELECT a.midx, subject, content, writesort, hit, thumb, TO_CHAR(writeday, 'YYYY-MM-DD') AS writeday, nickname, position FROM assaboard a, assamember b WHERE a.midx = b.midx AND bidx = " + bidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				
				gulView.setHit(rs.getInt("hit"));
				gulView.setMidx(rs.getInt("midx"));
				gulView.setContent(rs.getString("content"));
				gulView.setSubject(rs.getString("subject"));
				gulView.setWriteday(rs.getString("writeday"));
				gulView.setNickname(rs.getString("nickname"));
				gulView.setPosition(rs.getString("position"));
				gulView.setWritesort(rs.getString("writesort"));
				if(lidx > 2) gulView.setThumb(rs.getInt("thumb"));
				
				
				if(lidx == 1 && gulView.getWritesort().equals("커뮤신청")){	// 자유게시판안의 카테고리가 커뮤신청인 경우
					
					sqlCommuapply = "SELECT * FROM assaboard_commuapply WHERE bidx = " + bidx;
					psmt = conn.prepareStatement(sqlCommuapply);
					rsCommuapply = psmt.executeQuery();
					
					if(rsCommuapply.next()) {

						commuapply.setOkyn(rsCommuapply.getString("okyn"));
						commuapply.setCommuTitle(rsCommuapply.getString("commutitle"));
						commuapply.setWritesort1(rsCommuapply.getString("writesort1"));
						commuapply.setWritesort2(rsCommuapply.getString("writesort2"));
						commuapply.setWritesortcnt(rsCommuapply.getInt("writesortcnt"));
						commuapply.setCommuReason(rsCommuapply.getString("commureason"));
						commuapply.setListIntroduce(rsCommuapply.getString("listintroduce"));
						if(rsCommuapply.getString("writesort3") != null) commuapply.setWritesort3(rsCommuapply.getString("writesort3"));
						if(rsCommuapply.getString("writesort4") != null) commuapply.setWritesort4(rsCommuapply.getString("writesort4"));
						if(rsCommuapply.getString("writesort5") != null) commuapply.setWritesort5(rsCommuapply.getString("writesort5"));
					}
					
				}else{ gulView.setContent(rs.getString("content")); }		// 아닌경우
				
				
			}
			
			// 댓글을 호출하는 과정
			sql = "SELECT ridx, a.midx, TO_CHAR(rdate, 'YYYY-MM-DD HH24:MI:SS') as rdate, rcontent, modifyyn, nickname, position FROM assaboardreply a, assamember b ";
			sql +="WHERE a.midx = b.midx AND a.delyn='N' AND lidx = " + lidx + " AND bidx = " + bidx + " ORDER BY rdate";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				Reply reply = new Reply();

				reply.setRidx(rs.getInt("ridx"));
				reply.setMidx(rs.getInt("midx"));
				reply.setRdate(rs.getString("rdate"));
				reply.setRcontent(rs.getString("rcontent"));
				reply.setModifyyn(rs.getString("modifyyn"));
				reply.setNickname(rs.getString("nickname"));
				reply.setPosition(rs.getString("position"));
				
				replyList.add(reply);
				replycnt++;
			}
			
			if(lidx > 2){	// 유저가 글(커뮤니티)의 추천여부를 호출하는 과정
				
				sql = "SELECT * FROM assathumblist WHERE bidx = " + bidx + " AND midx = " + midx;
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				if(rs.next()) thumbSw = 1;
				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs, rsCommuapply);
		}
	}
	
}
