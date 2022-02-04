package boardWeb.vo;

import java.util.*;
import java.sql.*;
import boardWeb.util.*;
import boardWeb.vo.*;

public class ListFilter {
	
	public ArrayList<List> gulList = new ArrayList<>();
	public PagingUtil paging;
	int cnt;
	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rs2 = null;
	
	public ListFilter(String boardname, String writesort, int nowPage, String searchType, String searchValue){
		
		if(writesort.equals("notice")){
			writesort = "공지";
		}else if(writesort.equals("normal")){
			writesort = "일반";
		}else if(writesort.equals("qna")){
			writesort = "질문";
		}else if(writesort.equals("commuapply")){
			writesort = "커뮤신청";
		}
		
		try{
			conn = DBManager.getConnection();
			
			String sql = "SELECT * FROM " + boardname + " WHERE delyn = 'N' ";
			if(writesort != null && !writesort.equals("all")) {
				sql +=  "AND writesort = '" + writesort + "' ";;
			}
			if(!searchValue.equals("") && !searchValue.equals("null")){
				if(searchType.equals("subject")){
					sql += "AND subject LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("writer")){
					sql += "AND writer = '" + searchValue + "' ";
				}else if(searchType.equals("content")){
					sql += "AND content LIKE '%" + searchValue +  "%' ";
				}
			}
			sql += "ORDER BY bidx DESC";
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				cnt++;
			}
			
			psmt = null;
			rs = null;
			paging = new PagingUtil(cnt, nowPage, 10);
			
			sql = "SELECT b.* FROM ";
			sql += "(SELECT ROWNUM r, a.* FROM ";
			sql += "(SELECT bidx, midx, writesort, subject, hit, TO_CHAR(writeday, 'YYYY-MM-DD') AS writeday FROM jauboard WHERE delyn = 'N' ";
			if(writesort != null && !writesort.equals("all")) {
				sql +=  "AND writesort = '" + writesort + "' ";;
			}
			if(!searchValue.equals("") && !searchValue.equals("null")){
				if(searchType.equals("subject")){
					sql += "AND subject LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("writer")){
					sql += "AND writer = '" + searchValue + "' ";
				}else if(searchType.equals("content")){
					sql += "AND content LIKE '%" + searchValue +  "%' ";
				}
			}
			sql += "ORDER BY bidx DESC)a )b WHERE r BETWEEN " + paging.getStart() + " AND " + paging.getEnd();
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				cnt++;
				
				List jauList = new List();
				
				jauList.setBidx(rs.getInt("bidx"));
				jauList.setCategory(rs.getString("writesort"));
				jauList.setSubject(rs.getString("subject"));
				
				psmt = null;
				sql = "SELECT nickname, position FROM assamember WHERE midx = " + rs.getInt("midx");
				psmt = conn.prepareStatement(sql);
				rs2 = psmt.executeQuery();
				if(rs2.next()) {
					jauList.setNickname(rs2.getString("nickname"));
					jauList.setPosition(rs2.getString("position"));
				}
				
				jauList.setWriteday(rs.getString("writeday"));
				jauList.setHit(rs.getInt("hit"));
				
				gulList.add(jauList);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs, rs2);
		}
		
	}
	
}
