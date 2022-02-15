package boardWeb.vo;

import java.sql.*;
import java.util.*;
import boardWeb.util.DBManager;

public class MainGul {

	int rsSw;
	int maxbidx;
	
	String sql;
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement psmt = null;

	public ArrayList<Gul> jauList = new ArrayList<>();
	public ArrayList<Gul> noticeList = new ArrayList<>();
	public ArrayList<Gul> commuhitList = new ArrayList<>();
	public ArrayList<Gul> commuthumbList = new ArrayList<>();
	
	public MainGul() {
		
		try{
			conn = DBManager.getConnection();
			
			// 필독 공지사항을 호출하기위한 전제조건
			sql = "SELECT max(bidx) as bidx FROM assaboard";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				maxbidx = rs.getInt("bidx");
			}
			
			// 게시글이 1개 이상있을 때(공지사항부터 쓸거니까) 호출하는과정
			if(maxbidx != 0) {
				sql = "SELECT bidx, subject, TO_CHAR(writeday, 'YYYY-MM-DD') as writeday FROM assaboard WHERE bidx < 3 and lidx = 1 ORDER BY bidx DESC";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()){
					Gul notice = new Gul();

					notice.setBidx(rs.getInt("bidx"));
					notice.setSubject(rs.getString("subject"));
					notice.setWriteday(rs.getString("writeday"));
					
					noticeList.add(notice);
				}
			}
			
			// 최신 자유게시판글을 호출하는 과정
			if(maxbidx >= 3) {
				sql = "SELECT ROWNUM, a.* FROM (SELECT subject, hit, bidx FROM assaboard WHERE bidx > 2 AND lidx = 1 AND NOT writesort IN('공지') AND delyn='N' ORDER BY bidx DESC)a WHERE ROWNUM < 6";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()) {
					Gul gul = new Gul();
					
					
					gul.setHit(rs.getInt("hit"));
					gul.setBidx(rs.getInt("bidx"));
					gul.setSubject(rs.getString("subject"));
					
					jauList.add(gul);
				}
			}
			
			// 커뮤니티 글 있나 없나
			sql = "SELECT count(*) FROM assaboard WHERE lidx > 2";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs != null) {	// 커뮤니티 글 있으면 조회수 글, 추천수 글을 호출하는 스위치 온
				rsSw = 1;
			}
			
			if(rsSw == 1) {
				
				// 조회수 TOP5
				psmt = null;
				sql = "SELECT ROWNUM, c.* FROM (SELECT a.subject, a.hit, a.lidx, a.bidx, RTRIM(b.LISTTITLE, '커뮤') AS commutitle FROM assaboard a, assaboardlist b WHERE a.lidx = b.lidx AND a.lidx > 2 AND a.delyn='N' AND b.delyn='N' ORDER BY a.hit DESC, writeday)c WHERE ROWNUM < 6";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()) {
					Gul gul = new Gul();
					
					gul.setHit(rs.getInt("hit"));
					gul.setLidx(rs.getInt("lidx"));
					gul.setBidx(rs.getInt("bidx"));
					gul.setSubject(rs.getString("subject"));
					gul.setListtitle(rs.getString("commutitle"));
					
					commuhitList.add(gul);
				}
				
				// 추천수 TOP5
				psmt = null;
				sql = "SELECT ROWNUM, c.* FROM (SELECT a.subject, a.thumb, a.lidx, a.bidx, RTRIM(b.LISTTITLE, '커뮤') AS commutitle FROM assaboard a, assaboardlist b WHERE a.lidx = b.lidx AND a.lidx > 2 AND a.delyn='N' AND b.delyn='N' ORDER BY a.thumb DESC, writeday)c WHERE ROWNUM < 6";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()) {
					Gul gul = new Gul();
					
					gul.setLidx(rs.getInt("lidx"));
					gul.setBidx(rs.getInt("bidx"));
					gul.setThumb(rs.getInt("thumb"));
					gul.setSubject(rs.getString("subject"));
					gul.setListtitle(rs.getString("commutitle"));
					
					commuthumbList.add(gul);
				}
				
			}
				
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(conn, psmt, rs);
		}
	}
}
