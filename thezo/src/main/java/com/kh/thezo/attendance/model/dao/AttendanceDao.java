package com.kh.thezo.attendance.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.thezo.attendance.model.vo.Attendance;
import com.kh.thezo.member.model.vo.Member;

@Repository
public class AttendanceDao {
	
	// 사용자:출근 입력
	public int insertAtt(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.insert("attendanceMapper.insertAtt", memNo);
	}

	// 사용자:퇴근 입력
	public int insertfAtt(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.update("attendanceMapper.insertfAtt", memNo);
	}
	
	// 출퇴근 조회용
	public Attendance attendanceData(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.selectOne("attendanceMapper.selectAttendance", memNo);
	}
	
	public Attendance attendanceData2(SqlSessionTemplate sqlSession, Member m) {
		return sqlSession.selectOne("attendanceMapper.selectAttendance", m);
	}
}