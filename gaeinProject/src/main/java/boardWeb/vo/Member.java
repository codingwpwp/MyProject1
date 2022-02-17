package boardWeb.vo;

import java.util.*;
import java.sql.*;

import boardWeb.util.DBManager;

public class Member {
	
	private int midx;
	private int point;
	private String id;
	private String pw;
	private String name;
	private String email;
	private String delyn;
	private String gender;
	private String joinday;
	private String nickname;
	private String position;
	
	public int getMidx() {
		return midx;
	}
	public void setMidx(int midx) {
		this.midx = midx;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDelyn() {
		return delyn;
	}
	public void setDelyn(String delyn) {
		this.delyn = delyn;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getJoinday() {
		return joinday;
	}
	public void setJoinday(String joinday) {
		this.joinday = joinday;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	
	String sql;
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement psmt = null;
	
	public Member() {}
	public Member(int midx){
		
		try {
			conn = DBManager.getConnection();
			
			sql = "SELECT position,midx,id,pw,membername,nickname,gender,email,TO_CHAR(joinday, 'YYYY-MM-DD') AS joinday, delyn, point FROM assamember WHERE midx = " + midx;
			psmt = conn.prepareStatement(sql);
			rs = psmt.executeQuery();
			if(rs.next()){
				
				this.setMidx(rs.getInt("midx"));
				this.setId(rs.getString("id"));
				this.setPw(rs.getString("pw"));
				this.setPoint(rs.getInt("point"));
				this.setName(rs.getString("membername"));
				this.setNickname(rs.getString("nickname"));
				if(rs.getString("gender") != null) {
					this.setGender(rs.getString("gender"));
				}
				if(rs.getString("email") != null) {
					this.setEmail(rs.getString("email"));
				}
				this.setJoinday(rs.getString("joinday"));
				this.setPosition(rs.getString("position"));
				this.setDelyn(rs.getString("delyn"));
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			DBManager.close(conn, psmt, rs);
		}
		
	}
	
}
