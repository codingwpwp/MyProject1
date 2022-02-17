package boardWeb.util;

import java.sql.*;
import java.util.ArrayList;
import boardWeb.vo.*;

public class AdManager {
	
	int random;
	public int point;
	public int totalpoint;
	public int adSw;
	public String link;
	public String filename;
	public double persent;
	
	String sql;
	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	public ArrayList<AdMembers> adMembers = new ArrayList<>();
	public ArrayList<Integer> midxs = new ArrayList<>();
	
	public AdManager() {
		
		try {
			
			conn = DBManager.getConnection();
			
			sql = "SELECT a.midx, a.point, a.filerealname, a.links, b.nickname, TO_CHAR(adate, 'YYYY-MM-DD') as dates FROM assaad a, assamember b WHERE a.midx = b.midx ORDER BY a.midx";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
				AdMembers adm = new AdMembers();
				
				adm.setMidx(rs.getInt("midx"));
				adm.setPoint(rs.getInt("point"));
				adm.setFileRealName(rs.getString("filerealname"));
				adm.setLinks(rs.getString("links"));
				adm.setNickname(rs.getString("nickname"));
				adm.setDate(rs.getString("dates"));
				
				adMembers.add(adm);
				totalpoint += rs.getInt("point");
			}
			
			for(AdMembers a : adMembers) {
				for(int i = 0; i < a.getPoint(); i++) {
					midxs.add(a.getMidx());
				}
			}
			
			random = (int)((Math.random() * midxs.size()));
			
			for(AdMembers a : adMembers){
				if(a.getMidx() == midxs.get(random)){
					link = a.getLinks();
					filename = a.getFileRealName();
					break;
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs);
		}
	}
	
	public AdManager(int midx){
		
		try {
			
			conn = DBManager.getConnection();
			
			sql = "SELECT * FROM assaad WHERE midx = " + midx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				adSw = 1;
				point = rs.getInt("point");
				link = rs.getString("links");
				filename = rs.getString("filerealname");
			}
			
			if(adSw == 1){
				sql = "SELECT * FROM assaad";
				psmt = conn.prepareStatement(sql);
				rs = psmt.executeQuery();
				while(rs.next()) {
					
					AdMembers adm = new AdMembers();
					
					adm.setPoint(rs.getInt("point"));
					
					adMembers.add(adm);
					
				}
				
				for(AdMembers a : adMembers) {
					totalpoint += a.getPoint();
				}
				
				persent = ((double)point / totalpoint) * 100;
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			DBManager.close(conn, psmt, rs);
		}
	}
	
}
