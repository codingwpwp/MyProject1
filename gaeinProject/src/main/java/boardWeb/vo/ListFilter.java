package boardWeb.vo;

import java.util.*;
import java.sql.*;
import boardWeb.util.*;

public class ListFilter {
	
	public ArrayList<Gul> gulList = new ArrayList<>();
	public PagingUtil paging;
	
	String sql;
	int cnt;
	
	String writersql;
	public ArrayList<Integer> midxs = new ArrayList<>();
	
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	ResultSet rsMidx = null;
	
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
			// 게시글의 갯수를 호출하는 과정
			sql = "SELECT * FROM " + boardname + " WHERE delyn = 'N' ";
			if(!writesort.equals("all")){
				sql +=  "AND writesort = '" + writesort + "' ";;
			}
			
			if(!searchValue.equals("") && !searchValue.equals("null")){
				
				if(searchType.equals("subject")){
					sql += "AND subject LIKE '%" + searchValue + "%' ";
					
				}else if(searchType.equals("nickname")){
					writersql = "SELECT midx FROM assamember WHERE nickname LIKE '%" + searchValue + "%'";
					psmt = conn.prepareStatement(writersql);
					rs = psmt.executeQuery();
					
					while(rs.next()){
						midxs.add(rs.getInt("midx"));
					}
					
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
			//System.out.println(sql);
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
			sql += "(SELECT bidx, midx, writesort, subject, hit, TO_CHAR(writeday, 'YYYY-MM-DD') AS writeday FROM " + boardname + " WHERE delyn = 'N' ";
			if(writesort != null && !writesort.equals("all")) {
				sql +=  "AND writesort = '" + writesort + "' ";;
			}
			if(!searchValue.equals("") && !searchValue.equals("null")){
				if(searchType.equals("subject")){
					sql += "AND subject LIKE '%" + searchValue + "%' ";
				}else if(searchType.equals("writer")){
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
			sql += "ORDER BY bidx DESC)a )b WHERE r BETWEEN " + paging.getStart() + " AND " + paging.getEnd();
			
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				Gul jauList = new Gul();
				
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
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs, rsMidx);
		}
		
	}
	
}
