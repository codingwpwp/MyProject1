package boardWeb.vo;

import java.util.*;
import java.sql.*;
import boardWeb.util.*;

public class ListFilter {
	
	public ArrayList<Gul> gulList = new ArrayList<>();
	public PagingUtil paging;
	
	public int listmastermidx;
	public String listintroduce;
	public int writesortcnt;
	public String writesort1;
	public String writesort2;
	public String writesort3;
	public String writesort4;
	public String writesort5;
	
	String writersql;	// 검색 종류 : 작성자 일때
	public ArrayList<Integer> midxs = new ArrayList<>();	// '작성자'에 대한 값들(MIDX)을 배열화
	
	int cnt;	// 글 갯수
	
	String sql;
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rsMidx = null;
	
	public ListFilter(int lidx, int writesortnum, int nowPage, String searchType, String searchValue){
		
		try{
			conn = DBManager.getConnection();
			
			// LIDX로 게시판의 기본 정보를 호출하는 과정
			sql = "SELECT * FROM assaboardlist WHERE lidx = " + lidx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()) {
				
				listmastermidx = rs.getInt("LISTMASTERMIDX");
				listintroduce = rs.getString("LISTINTRODUCE");
				writesortcnt = rs.getInt("WRITESORTCNT");
				writesort1 = rs.getString("WRITESORT1");
				writesort2 = rs.getString("WRITESORT2");
				if(rs.getString("WRITESORT3") != null) writesort3 = rs.getString("WRITESORT3");
				if(rs.getString("WRITESORT4") != null) writesort4 = rs.getString("WRITESORT4");
				if(rs.getString("WRITESORT5") != null) writesort5 = rs.getString("WRITESORT5");
				
			}
			psmt = null;
			
			// 게시판의 글 갯수를 구하는 과정 ( (카테고리(말머리)) || (검색종류 && 검색값) )
			sql = "SELECT * FROM ASSABOARD WHERE lidx = " + lidx + " ";
			
			switch(writesortnum) {
			case 1 : sql += "AND writesort = " + writesort1 + " "; break;
			case 2 : sql += "AND writesort = " + writesort2 + " "; break;
			case 3 : sql += "AND writesort = " + writesort3 + " "; break;
			case 4 : sql += "AND writesort = " + writesort4 + " "; break;
			case 5 : sql += "AND writesort = " + writesort5 + " ";
			}
			
			if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
				
				if(searchType.equals("subject")){
					sql += "AND subject LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("nickname")){
					
					writersql = "SELECT midx FROM assamember WHERE nickname LIKE '%" + searchValue + "%'";
					psmt = conn.prepareStatement(writersql);
					rs = psmt.executeQuery();
					while(rs.next()){
						midxs.add(rs.getInt("midx"));
					}
					psmt = null;
					
					if(midxs.size() == 0){
						sql += "AND midx = -1 ";
					}else if(midxs.size() == 1){
						sql += "AND midx = " + midxs.get(0) + " ";
					}else{
						sql += "AND (";
						for(int i = 0; i < midxs.size() - 1; i++) {
							sql += "midx = " + midxs.get(i) + " OR ";
						}
						sql += "midx = " + midxs.get(midxs.size() - 1) + ") ";
					}
					
				}else if(searchType.equals("content")){
					sql += "AND content LIKE '%" + searchValue +  "%' ";
				}
			}
			
			sql += "ORDER BY bidx DESC";
			System.out.println(sql);
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) cnt++;
			psmt = null;
			
			// 게시판의 페이징처리
			paging = new PagingUtil(cnt, nowPage, 7);
			
			// 글을 출력하는 과정 ( (카테고리(말머리)) || (검색종류 && 검색값) )
			sql = "SELECT b.* FROM ";
			sql += " (SELECT ROWNUM r, a.* FROM ";
			sql += "  (SELECT bidx, midx, writesort, subject, hit, thumb, TO_CHAR(writeday, 'YYYY-MM-DD')";
			sql += "   AS writeday FROM assaboard WHERE lidx = " + lidx + " AND delyn = 'N' ";
			
			switch(writesortnum) {
			case 1 : sql += "AND writesort = " + writesort1 + " "; break;
			case 2 : sql += "AND writesort = " + writesort2 + " "; break;
			case 3 : sql += "AND writesort = " + writesort3 + " "; break;
			case 4 : sql += "AND writesort = " + writesort4 + " "; break;
			case 5 : sql += "AND writesort = " + writesort5 + " ";
			}
			
			if(searchValue != null && !searchValue.equals("") && !searchValue.equals("null")){
				if(searchType.equals("subject")){
					sql += "AND subject LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("nickname")){
					
					if(midxs.size() == 0){
						sql += "AND midx = -1 ";
					}else if(midxs.size() == 1){
						sql += "AND midx = " + midxs.get(0) + " ";
					}else{
						sql += "AND (";
						for(int i = 0; i < midxs.size() - 1; i++) {
							sql += "midx = " + midxs.get(i) + " OR ";
						}
							sql += "midx = " + midxs.get(midxs.size() - 1);
						sql += ") ";
					}
					
				}else if(searchType.equals("content")){
					sql += "AND content LIKE '%" + searchValue +  "%' ";
				}
			}
			sql += "   ORDER BY bidx DESC)a ";
			sql += " )b WHERE r BETWEEN " + paging.getStart() + " AND " + paging.getEnd();
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				Gul jauList = new Gul();
				
				jauList.setNum(cnt);
				jauList.setBidx(rs.getInt("bidx"));
				jauList.setWritesort(rs.getString("writesort"));
				jauList.setSubject(rs.getString("subject"));
				
				
				psmt = null;
				sql = "SELECT nickname, position FROM assamember WHERE midx = " + rs.getInt("midx");
				psmt = conn.prepareStatement(sql);
				rsMidx = psmt.executeQuery();
				if(rsMidx.next()) {
					jauList.setNickname(rsMidx.getString("nickname"));
					jauList.setPosition(rsMidx.getString("position"));
				}
				
				
				jauList.setWriteday(rs.getString("writeday"));
				jauList.setHit(rs.getInt("hit"));
				
				gulList.add(jauList);
				cnt--;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs, rsMidx);
		}
		
	}
	
}
