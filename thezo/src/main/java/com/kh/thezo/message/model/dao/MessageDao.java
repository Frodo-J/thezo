package com.kh.thezo.message.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.thezo.common.model.vo.PageInfo;
import com.kh.thezo.member.model.vo.Member;
import com.kh.thezo.message.model.vo.Message;
import com.kh.thezo.message.model.vo.MsgReport;

//@author Jaewon.s
/**
 * @author Jaewon.Shin
 *
 */
@Repository //DB와 접근하는 클래스이다! 
public class MessageDao {

	/** 받은 쪽지 list 조회해오는 dao
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public ArrayList<Message> ajaxSelectReceiveMsgList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("messageMapper.ajaxSelectReceiveMsgList", memNo);
	}
	
	/** 보낸 쪽지 list 조회해오는 service	
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public ArrayList<Message> ajaxSelectSentMsgList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("messageMapper.ajaxSelectSentMsgList", memNo);	
	}

	/** 휴지통으로 이동시키는 dao
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxMoveToRB(SqlSessionTemplate sqlSession, HashMap<Object, Object> hm) {
		return sqlSession.update("messageMapper.ajaxMoveToRB", hm);
	}

	/** 휴지통으로 이동시킨 (받은) 쪽지리스트 조회해오는 dao
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public ArrayList<Message> ajaxSelectRcRbList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("messageMapper.ajaxSelectRcRbList", memNo);
	}

	/** 휴지통으로 이동시킨 (보낸) 쪽지리스트 조회해오는 dao
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public ArrayList<Message> ajaxSelectStRbList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("messageMapper.ajaxSelectStRbList", memNo);
	}

	/** 읽지 않은 쪽지 갯수 가져오는 dao
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public int ajaxCountUnreadedMsg(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.selectOne("messageMapper.ajaxCountUnreadedMsg", memNo);
	}

	/** 메세지 상세보기 정보 뽑아오는 DAO들 ! 총 4개임 (로직처리를 동적sql로 뽑아서  받은쪽지, 보낸쪽지, 휴지통에있는 받은 쪽지, 휴지통에 있는 보낸쪽지)를 가져온다
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public Message ajaxSelectDetailMsg(SqlSessionTemplate sqlSession, HashMap<String, Object> hm) {
		return sqlSession.selectOne("messageMapper.ajaxSelectDetailMsg", hm);
	}

	/** 휴지통에서 받은 쪽지를 복구하는 dao
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxRestoreToRc(SqlSessionTemplate sqlSession, HashMap<Object, Object> hm) {
		return sqlSession.update("messageMapper.ajaxRestoreToRc", hm);
	}

	/** 휴지통에서 보낸 쪽지를 복구하는 dao
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxRestoreToSt(SqlSessionTemplate sqlSession, HashMap<Object, Object> hm) {
		return sqlSession.update("messageMapper.ajaxRestoreToSt", hm);
	}

	/** 휴지통에서 받은 쪽지 영구 삭제 처리 (status 변경으로 )하는 dao
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxDeleteRcMsg(SqlSessionTemplate sqlSession, HashMap<Object, Object> hm) {
		return sqlSession.update("messageMapper.ajaxDeleteRcMsg", hm);
	}

	/** 휴지통에서 보낸 쪽지 영구 삭제 처리 (status 변경으로 )하는 dao
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxDeleteStMsg(SqlSessionTemplate sqlSession, HashMap<Object, Object> hm) {
		return sqlSession.update("messageMapper.ajaxDeleteStMsg", hm);
	}

	/** 받은 쪽지에서 오직 상세보기시만 read_status update하는 dao
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxUpdateReadStatusMsg(SqlSessionTemplate sqlSession, HashMap<String, Object> hm) {
		return sqlSession.update("messageMapper.ajaxUpdateReadStatusMsg", hm);
	}

	/** 이름에 따른 전체 검색 결과 갯수 가져오는 dao
	 * @param sqlSession
	 * @return
	 */
	public int selectListCount(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectOne("messageMapper.selectListCount", keyword);
	}
	
	/** 팝업창 이름(키워드)로  맴버 목록 검색 해오는 서비스 
	 * @param sqlSession
	 * @param keyword
	 * @return
	 */
	public ArrayList<Member> searchMemListByName(SqlSessionTemplate sqlSession, String keyword, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("messageMapper.searchMemListByName", keyword, rowBounds);
	}

	/** 부서에 따른 전체 검색 결과 갯수 가져오는 dao
	 * @param sqlSession
	 * @param keyword
	 * @return
	 */
	public int selectListCountByDept(SqlSessionTemplate sqlSession, String keyword) {
		return sqlSession.selectOne("messageMapper.selectListCountByDept", keyword);
	}

	/** 팝업창 이름(부서)로  맴버 목록 검색 해오는 서비스 
	 * @param sqlSession
	 * @param keyword
	 * @param pi
	 * @return
	 */
	public ArrayList<Member> searchMemListByDept(SqlSessionTemplate sqlSession, String keyword, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("messageMapper.searchMemListByDept", keyword, rowBounds);
	}

	/** 직급에 따른 전체 검색 결과 갯수 가져오는 dao
	 * @param sqlSession
	 * @param mapForCount
	 * @return
	 */
	public int selectListCountByRank(SqlSessionTemplate sqlSession, HashMap<Object, Object> mapForCount) {
		return sqlSession.selectOne("messageMapper.selectListCountByRank", mapForCount);
	}

	/** 팝업창 이름(직급)로  맴버 목록 검색 해오는 서비스 
	 * @param sqlSession
	 * @param mapForCount
	 * @param pi
	 * @return
	 */
	public ArrayList<Member> searchMemListByRank(SqlSessionTemplate sqlSession, HashMap<Object, Object> mapForCount, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("messageMapper.searchMemListByRank", mapForCount, rowBounds);
	}

	/** 쪽지 보내는 Dao
	 * @param sqlSession
	 * @param msgInfo
	 * @return
	 */
	public int insertMsg(SqlSessionTemplate sqlSession, HashMap<Object, Object> msgInfo) {
		return sqlSession.insert("messageMapper.insertMsg", msgInfo);
	}

	public HashMap<Object, Object> bringMemInfoByMsgNo(SqlSessionTemplate sqlSession, int msgNo) {
		return sqlSession.selectOne("messageMapper.bringMemInfoByMsgNo", msgNo);
	}
	
	//--------------------------------------------------------------------------------------
	//-------------------------- 쪽지 신고 관련 -------------------------------------------------	
	/** 쪽지 신고 접수 Dao 
	 * @param sqlSession
	 * @param mr
	 * @return
	 */
	public int insertMsgReport(SqlSessionTemplate sqlSession, MsgReport mr) {
		return sqlSession.insert("messageMapper.insertMsgReport", mr);
	}

	/** 내가 신고한 쪽지 목록 조회하는 Dao
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public ArrayList<MsgReport> ajaxselectReportList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("messageMapper.ajaxselectReportList", memNo);
	}

	/** msgReportNo을 가지고 신고 상세조회하는 Dao
	 * @param sqlSession
	 * @param msgReportNo
	 * @return
	 */
	public MsgReport ajaxSelectReport(SqlSessionTemplate sqlSession, int msgReportNo) {
		return sqlSession.selectOne("messageMapper.ajaxSelectReport", msgReportNo);
	}

	/** 쪽지 신고철회하는 Dao
	 * @param sqlSession
	 * @param msgReportNo
	 * @return
	 */
	public int ajaxWithdrawalReport(SqlSessionTemplate sqlSession, int msgReportNo) {
		return sqlSession.delete("messageMapper.ajaxWithdrawalReport", msgReportNo);
	}

	//-------------------------------------------------------------------------------------
	//--------------------------- Admin 쪽지 신고 처리 시작 --------------------------------------
	/** 미해결 된 신고 내용 갯수 구해오는 dao
	 * @param sqlSession
	 * @return
	 */
	public int unHandleReportCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("messageMapper.unHandleReportCount");
	}

	/** 해결 된 신고 내용 갯수 구해오는 dao
	 * @param sqlSession
	 * @return
	 */
	public int handleReportCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("messageMapper.handleReportCount");
	}

	/** 미해결 된 신고  쪽지 list 가져오는 Dao
	 * @param sqlSession
	 * @param pi
	 * @return
	 */
	public ArrayList<MsgReport> ajaxUnhandledReportList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("messageMapper.ajaxUnhandledReportList","", rowBounds);
	}

	/** 해결 된 신고  쪽지 list 가져오는 Dao
	 * @param sqlSession
	 * @param pi
	 * @return
	 */
	public ArrayList<MsgReport> ajaxHandledReportList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage()-1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		return (ArrayList)sqlSession.selectList("messageMapper.ajaxHandledReportList","", rowBounds);
	}

	/** 관리자 페이지 쪽지 신고 상세 내역 조회해오는 Dao
	 * @param sqlSession
	 * @param msgReportNo
	 * @return
	 */
	public MsgReport ajaxSelectAdminReportDetail(SqlSessionTemplate sqlSession, int msgReportNo) {
		return sqlSession.selectOne("messageMapper.ajaxSelectAdminReportDetail", msgReportNo);
	}

	/** 관리자 페이지에서 일단 신고처리를 하는 Dao
	 * @param sqlSession
	 * @param mr
	 * @return
	 */
	public int ajaxHandleReport(SqlSessionTemplate sqlSession, MsgReport mr) {
		return sqlSession.update("messageMapper.ajaxHandleReport", mr);
	}

	/** 신고처리 전에 조건검사로 기존에 만약 이미 한번 신고 당해서 쪽지기능 제한 일자가 걸려있는 경우 msgRestrict값 조회해오는 Dao
	 * @param sqlSession
	 * @param mr
	 * @return
	 */
	public String beforeHandleReportCheck(SqlSessionTemplate sqlSession, MsgReport mr) {
		return sqlSession.selectOne("messageMapper.beforeHandleReportCheck", mr);
	}
	
	/** 신고처리후에 성공했다면  3일짜리냐 혹은 영구냐에 따라서 쪽지 기능 제한 시키는 Dao
	 * @param sqlSession
	 * @param mr
	 * @return
	 */
	public int restrictMsgFunc(SqlSessionTemplate sqlSession, MsgReport mr) {
		return sqlSession.update("messageMapper.restrictMsgFunc", mr);
	}



}
