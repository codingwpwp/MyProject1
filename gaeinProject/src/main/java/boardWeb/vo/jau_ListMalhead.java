package boardWeb.vo;

import java.util.*;
import java.sql.*;
import boardWeb.util.*;
import boardWeb.vo.*;

public class jau_ListMalhead {
	
	public ArrayList<List> jList = new ArrayList<>();
	public PagingUtil paging;
	int cnt;
	
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	public jau_ListMalhead(String boardname, String malhead, int nowPage, String searchType, String searchValue){
		
		if(malhead.equals("notice")){
			malhead = "공지";
		}else if(malhead.equals("normal")){
			malhead = "일반";
		}else if(malhead.equals("qna")){
			malhead = "질문";
		}else if(malhead.equals("commuapply")){
			malhead = "커뮤신청";
		}
		
		try{
			conn = DBManager.getConnection();
			
			String sql = "SELECT * FROM " + boardname + " WHERE delyn = 'N' ";
			if(malhead != null && !malhead.equals("all")) {
				sql +=  "AND writesort = '" + malhead + "' ";;
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
			paging = new PagingUtil(cnt, nowPage, 2);
			
			sql = "SELECT b.* FROM ";
			sql += "(SELECT ROWNUM r, a.* FROM ";
			sql += "(SELECT bidx, writesort, subject, nickname, hit, TO_CHAR(writeday, 'YYYY-MM-DD') AS writeday FROM jauboard WHERE delyn = 'N' ";
			if(malhead != null && !malhead.equals("all")) {
				sql +=  "AND writesort = '" + malhead + "' ";;
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
				jauList.setNickname(rs.getString("nickname"));
				jauList.setWriteday(rs.getString("writeday"));
				jauList.setHit(rs.getInt("hit"));
				
				jList.add(jauList);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs);
		}
		
	}
	
}
