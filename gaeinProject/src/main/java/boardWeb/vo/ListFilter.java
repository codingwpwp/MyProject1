package boardWeb.vo;

import java.util.*;
import java.sql.*;
import boardWeb.util.*;

public class ListFilter {
	
	public Member m;
	
	public PagingUtil paging;
	
	public String delyn;
	public String listday;
	public String listtitle;
	public String listtable;
	public String writesort1;
	public String writesort2;
	public String writesort3;
	public String writesort4;
	public String writesort5;
	public String listintroduce;
	
	public int writesortcnt;
	public int listmastermidx;
	
	public int cnt;	// 글 총 갯수
	public int onePagingcnt;	// 한페이지에 뿌려질 글 번호
	public int replycnt; 		// 해당 글의 댓글 갯수
	
	public ArrayList<Gul> gulList = new ArrayList<>();
	
	String sql;
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rsreply = null;
	
	public ListFilter(int lidx, int writesortnum, int nowPage, String searchType, String searchValue){
		
		try{
			conn = DBManager.getConnection();
			
			// LIDX로 게시판의 기본 정보를 호출하는 과정
			sql = "SELECT * FROM assaboardlist WHERE lidx = " + lidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				
				listtitle = rs.getString("listtitle");
				writesort1 = rs.getString("writesort1");
				writesort2 = rs.getString("writesort2");
				writesortcnt = rs.getInt("writesortcnt");
				listmastermidx = rs.getInt("listmastermidx");
				listintroduce = rs.getString("listintroduce");
				if(rs.getString("writesort3") != null) writesort3 = rs.getString("writesort3");
				if(rs.getString("writesort4") != null) writesort4 = rs.getString("writesort4");
				if(rs.getString("writesort5") != null) writesort5 = rs.getString("writesort5");
				
			}
			
			// 글의 갯수를 구하는 과정 ( 카테고리 || (검색종류 && 검색값) )
			sql = "SELECT count(*) as count FROM assaboard a, assamember b WHERE a.midx = b.midx AND a.delyn = 'N' AND lidx = " + lidx + " ";
			
			switch(writesortnum) {	// 카테고리
			case 1 : sql += "AND writesort = '" + writesort1 + "' "; break;
			case 2 : sql += "AND writesort = '" + writesort2 + "' "; break;
			case 3 : sql += "AND writesort = '" + writesort3 + "' "; break;
			case 4 : sql += "AND writesort = '" + writesort4 + "' "; break;
			case 5 : sql += "AND writesort = '" + writesort5 + "' ";
			}
			
			if(searchValue != null && !searchValue.equals("null") && !searchValue.equals("")){	// 검색종류 && 검색값
				
				if(searchType.equals("subject")){
					sql += "AND subject LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("nickname")){
					sql += "AND nickname LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("content")){
					sql += "AND content LIKE '%" + searchValue +  "%' ";
				}
			}
			
			sql += "ORDER BY bidx DESC";	// 정렬
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				onePagingcnt = cnt = rs.getInt("count");
			}
			
			// 게시판의 페이징처리
			paging = new PagingUtil(cnt, nowPage, 10);
			onePagingcnt = cnt - (paging.getPerPage() * (nowPage - 1));
			
			
			// 글을 출력하는 과정 ( (카테고리) || (검색종류 && 검색값) )
			sql = "SELECT d.* FROM ";
			sql += "(SELECT ROWNUM r, c.* FROM ";
			sql += "(SELECT hit, bidx, thumb, subject, TO_CHAR(writeday, 'YYYY-MM-DD') AS writeday, nickname, position, writesort FROM assaboard a, assamember b WHERE a.midx = b.midx AND lidx = " + lidx + " AND a.delyn = 'N' ";
			
			switch(writesortnum) {	// 카테고리
			case 1 : sql += "AND writesort = '" + writesort1 + "' "; break;
			case 2 : sql += "AND writesort = '" + writesort2 + "' "; break;
			case 3 : sql += "AND writesort = '" + writesort3 + "' "; break;
			case 4 : sql += "AND writesort = '" + writesort4 + "' "; break;
			case 5 : sql += "AND writesort = '" + writesort5 + "' ";
			}
			
			if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){	// 검색종류 && 검색값
				if(searchType.equals("subject")){
					sql += "AND subject LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("nickname")){
					sql += "AND nickname LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("content")){
					sql += "AND content LIKE '%" + searchValue +  "%' ";
				}
			}
			sql += "ORDER BY bidx DESC)c ";
			sql += ")d WHERE r BETWEEN " + paging.getStart() + " AND " + paging.getEnd();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
				Gul jauList = new Gul();

				jauList.setNum(onePagingcnt);
				jauList.setHit(rs.getInt("hit"));
				jauList.setBidx(rs.getInt("bidx"));
				jauList.setSubject(rs.getString("subject"));
				jauList.setWriteday(rs.getString("writeday"));
				jauList.setNickname(rs.getString("nickname"));
				jauList.setPosition(rs.getString("position"));
				jauList.setWritesort(rs.getString("writesort"));
				if(lidx > 2) jauList.setThumb(rs.getInt("thumb"));
				
				sql = "SELECT COUNT(*) AS count FROM assaboardreply WHERE lidx = " + lidx + " AND bidx = " + jauList.getBidx() + " AND delyn='N'";
				psmt = conn.prepareStatement(sql);
				rsreply = psmt.executeQuery();
				if(rsreply.next()) replycnt = rsreply.getInt("count");
				jauList.setRelycnt(replycnt);
				
				gulList.add(jauList);
				onePagingcnt--;
				
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs, rsreply);
		}
		
	}
	
	
	
	public ListFilter(int midx) {	// 마이페이지에서 불러오는 생성자
		try {
			
			conn = DBManager.getConnection();
			
			sql = "SELECT a.lidx, RTRIM(b.listtitle, '게시판' || '커뮤') AS listtitle, a.bidx, a.writesort, a.subject, TO_CHAR(a.WRITEDAY, 'YYYY-MM-DD') AS writeday ";
			sql +="FROM assaboard a, assaboardlist b WHERE a.lidx = b.lidx AND a.midx = " + midx + " AND a.delyn='N'";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				Gul usergulList = new Gul();
				
				usergulList.setLidx(rs.getInt("lidx"));
				usergulList.setBidx(rs.getInt("bidx"));
				usergulList.setSubject(rs.getString("subject"));
				usergulList.setWriteday(rs.getString("writeday"));
				usergulList.setListtitle(rs.getString("listtitle"));
				usergulList.setWritesort(rs.getString("writesort"));
				
				gulList.add(usergulList);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(conn, psmt, rs);
		}
	}
	
	public ListFilter(int lidx, String sort) {
		if(sort.equals("manager")) {
		
			try {
				
				conn = DBManager.getConnection();
				sql = "SELECT listmastermidx, listtitle, listintroduce, writesort1, writesort2, writesort3, writesort4, writesort5, ";
				sql +="TO_CHAR(listday, 'YYYY-MM-DD') as listday FROM assaboardlist a, assamember b WHERE a.listmastermidx = b.midx AND a.lidx = " + lidx;
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				if(rs.next()){
					
					listmastermidx = rs.getInt("listmastermidx");
					listtitle = rs.getString("listtitle");
					listintroduce = rs.getString("listintroduce");
					writesort1 = rs.getString("writesort1");
					writesort2 = rs.getString("writesort2");
					if(rs.getString("writesort3") != null) writesort3 = rs.getString("writesort3");
					if(rs.getString("writesort4") != null) writesort4 = rs.getString("writesort4");
					if(rs.getString("writesort5") != null) writesort5 = rs.getString("writesort5");
					listday = rs.getString("listday");
				}
				
				sql = "SELECT a.bidx, a.writesort, a.SUBJECT, b.NICKNAME, TO_CHAR(a.WRITEDAY, 'YYYY-MM-DD') AS writeday FROM ASSABOARD a, ASSAMEMBER b WHERE lidx = " + lidx + " AND a.midx = b.midx AND a.delyn='Y' ORDER BY writeday DESC";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				
				while(rs.next()){
					Gul delgulList = new Gul();
					
					delgulList.setBidx(rs.getInt("bidx"));
					delgulList.setWritesort(rs.getString("writesort"));
					delgulList.setSubject(rs.getString("subject"));
					delgulList.setNickname(rs.getString("nickname"));
					delgulList.setWriteday(rs.getString("writeday"));
					
					gulList.add(delgulList);
				}
				
				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				DBManager.close(conn, psmt, rs);
			}
			
		}else if(sort.equals("info")) {
			
			try {
							
				conn = DBManager.getConnection();
				
				sql = "SELECT COUNT(*) as count "
					+ "FROM   ASSABOARDLIST a, "
					+ "       ASSAMEMBER b, "
					+ "       ASSABOARD c "
					+ "WHERE  a.LISTMASTERMIDX                                                                 = b.midx "
					+ "AND    a.lidx                                                                           = c.lidx "
					+ "AND    a.lidx                                                                           = " + lidx
					+ "AND    TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD')) - TO_DATE(TO_CHAR(c.writeday, 'YYYYMMDD')) < 1";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				if(rs.next()) {
					cnt = rs.getInt("count");
				}
				
				
				sql = "SELECT a.delyn, listmastermidx, listtitle, writesort1, writesort2, writesort3, writesort4, writesort5, TO_CHAR(listday, 'YYYY-MM-DD HH24:MI:SS') AS listday, nickname FROM ASSABOARDLIST a, assamember b WHERE a.LISTMASTERMIDX = b.midx AND a.lidx = " + lidx;
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				if(rs.next()){
					
					delyn = rs.getString("delyn");
					listday = rs.getString("listday");
					listtitle = rs.getString("listtitle");
					writesort1 = rs.getString("WRITESORT1");
					writesort2 = rs.getString("WRITESORT2");
					listmastermidx = rs.getInt("listmastermidx");
					if(rs.getString("WRITESORT3") != null) writesort3 = rs.getString("WRITESORT3");
					if(rs.getString("WRITESORT4") != null) writesort4 = rs.getString("WRITESORT4");
					if(rs.getString("WRITESORT5") != null) writesort5 = rs.getString("WRITESORT5");
					
					m = new Member();
					m.setNickname(rs.getString("nickname"));
					
				}
				
				
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				DBManager.close(conn, psmt, rs);
			}
		}
		
	}
	
}