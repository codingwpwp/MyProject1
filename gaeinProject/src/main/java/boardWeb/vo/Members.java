package boardWeb.vo;

import java.sql.*;
import java.util.ArrayList;

import boardWeb.util.*;

public class Members {
	
	
	int membercnt;
	String sql;
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	public ArrayList<Member> memberList = new ArrayList<>();
	
	public Members() {
		try {
			conn = DBManager.getConnection();
			
			sql = "SELECT midx, id, membername, position, TO_CHAR(joinday, 'YYYY-MM-DD') as joinday, delyn FROM assamember WHERE midx > 0";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				
				Member m = new Member();
				
				m.setMidx(rs.getInt("midx"));
				m.setId(rs.getString("id"));
				m.setName(rs.getString("membername"));
				m.setPosition(rs.getString("position"));
				m.setJoinday(rs.getString("joinday"));
				m.setDelyn(rs.getString("delyn"));
				
				memberList.add(m);
				membercnt++;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(conn, psmt, rs);
		}
	}
}
