package boardWeb.vo;

import java.util.*;
import java.sql.*;

import boardWeb.util.DBManager;

public class MainGul {

	int maxbidx;
	int rsSw;
	
	String sql;
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rscommu = null;
	ResultSet rs = null;
	
	public ArrayList<IndexNotice> noticeList = new ArrayList<>();
	public ArrayList<IndexGul> jauList = new ArrayList<>();
	public ArrayList<IndexGul> commuhitList = new ArrayList<>();
	public ArrayList<IndexGul> commuthumbList = new ArrayList<>();
	
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
					IndexNotice notice = new IndexNotice();
					
					notice.setSubject(rs.getString("subject"));
					notice.setWriteday(rs.getString("writeday"));
					notice.setBidx(rs.getInt("bidx"));
					
					noticeList.add(notice);
				}
			}
			
			// 최신 자유게시판글을 호출하는 과정
			if(maxbidx >= 3) {
				sql = "SELECT ROWNUM, a.* FROM (SELECT subject, hit, bidx FROM assaboard WHERE bidx > 2 AND lidx = 1 AND NOT writesort IN('공지') AND delyn='N' ORDER BY bidx DESC)a WHERE ROWNUM < 6";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()) {
					IndexGul gul = new IndexGul();
					
					
					gul.setHit(rs.getInt("hit"));
					gul.setBidx(rs.getInt("bidx"));
					gul.setSubject(rs.getString("subject"));
					
					jauList.add(gul);
				}
			}
			
			// 커뮤니티 글 있나 없나
			sql = "SELECT count(*) FROM assaboard WHERE lidx > 2";
			psmt = conn.prepareStatement(sql);
			rscommu = psmt.executeQuery();
			if(rscommu != null) {	// 커뮤니티 글 있으면 조회수 글, 추천수 글을 호출(각각 최대 5개)
				
				// 조회수 TOP5
				psmt = null;
				sql = "SELECT ROWNUM, c.* FROM (SELECT a.subject, a.hit, a.lidx, a.bidx, RTRIM(b.LISTTITLE, '커뮤') AS commutitle FROM assaboard a, assaboardlist b WHERE a.lidx = b.lidx AND a.lidx > 2 AND a.delyn='N'ORDER BY a.hit DESC, writeday)c WHERE ROWNUM < 6";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()) {
					IndexGul gul = new IndexGul();
					
					gul.setHit(rs.getInt("hit"));
					gul.setLidx(rs.getInt("lidx"));
					gul.setBidx(rs.getInt("bidx"));
					gul.setSubject(rs.getString("subject"));
					gul.setCommutitle(rs.getString("commutitle"));
					
					commuhitList.add(gul);
				}
				
				// 추천수 TOP5
				psmt = null;
				sql = "SELECT ROWNUM, c.* FROM (SELECT a.subject, a.thumb, a.lidx, a.bidx, RTRIM(b.LISTTITLE, '커뮤') AS commutitle FROM assaboard a, assaboardlist b WHERE a.lidx = b.lidx AND a.lidx > 2 AND a.delyn='N'ORDER BY a.thumb DESC, writeday)c WHERE ROWNUM < 6";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()) {
					IndexGul gul = new IndexGul();
					
					gul.setLidx(rs.getInt("lidx"));
					gul.setBidx(rs.getInt("bidx"));
					gul.setThumb(rs.getInt("thumb"));
					gul.setSubject(rs.getString("subject"));
					gul.setCommutitle(rs.getString("commutitle"));
					
					commuthumbList.add(gul);
				}
				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(conn, psmt, rs, rscommu);
		}
	}
}
