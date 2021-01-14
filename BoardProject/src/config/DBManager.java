package config;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DBManager {
	private static DBManager instance = new DBManager();
	private Connection conn;
      
	private DBManager() {
		Context context;
		try {
			context = new InitialContext();
			DataSource source = (DataSource)context.lookup("java:/comp/env/jdbc/myoracle");
			conn = source.getConnection();
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static DBManager getInstance() {
		if(instance == null)
			instance= new DBManager();
		return instance;
	}
	
	public Connection getConn() {
		return conn;
	}
	
	public void close(PreparedStatement pstmt, ResultSet rs) {
		try {
			if(rs != null)
			rs.close();
			if(pstmt != null)
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
