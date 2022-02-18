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
	public ArrayList<AdMembers> adMembers = new ArrayList<>();	// 광고를 올린 사람들
	public ArrayList<Integer> midxs = new ArrayList<>();		// 광고를 올린 사람들의 회원번호를 담는 배열
	
	public AdManager() {
		
		try {
			
			conn = DBManager.getConnection();
			
			sql = "SELECT a.midx, a.point, a.filerealname, a.links, b.nickname, TO_CHAR(adate, 'YYYY-MM-DD') as dates ";
			sql +="FROM assaad a, assamember b WHERE a.midx = b.midx ORDER BY a.midx";
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			
			while(rs.next()) {	// 광고내용을 담는 과정
				
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
			
			for(AdMembers a : adMembers) {	// 광고를 등록한 사람만큼 반복문
				for(int i = 0; i < a.getPoint(); i++) {	// 그 사람의 투자한 포인트만큼 반복
					midxs.add(a.getMidx());	// 그 사람의 회원번호를 배열midxs에추가
				}
			}
			
			random = (int)((Math.random() * midxs.size()));	// 배열midxs의 길이만큼 랜덤수를 발생
			
			for(AdMembers a : adMembers){
				if(a.getMidx() == midxs.get(random)){	// 배열midxs의 random번째 인덱스의 값이 등록한 사람의 회원번호가 일치할 때 
					link = a.getLinks();				// 그 사람것의 링크
					filename = a.getFileRealName();		// 그 사람것의 파일
					break;								// 반복문 종료
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
