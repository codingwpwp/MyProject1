package boardWeb.vo;

import java.sql.*;
import java.util.ArrayList;

import boardWeb.util.*;

public class Members {

	String sql;
	int membercnt;
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement psmt = null;
	public ArrayList<Member> memberList = new ArrayList<>();
	
	public Members() {
		try {
			conn = DBManager.getConnection();
			
			sql = "SELECT midx, id, membername, position, TO_CHAR(joinday, 'YYYY-MM-DD') as joinday, delyn FROM assamember WHERE midx > 0";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()){
				
				Member m = new Member();

				m.setId(rs.getString("id"));
				m.setMidx(rs.getInt("midx"));
				m.setDelyn(rs.getString("delyn"));
				m.setName(rs.getString("membername"));
				m.setJoinday(rs.getString("joinday"));
				m.setPosition(rs.getString("position"));
				
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
