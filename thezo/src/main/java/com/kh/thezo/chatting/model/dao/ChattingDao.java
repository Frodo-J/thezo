package com.kh.thezo.chatting.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.thezo.chatting.model.vo.ChatConnect;
import com.kh.thezo.chatting.model.vo.ChatDailyBasic;
import com.kh.thezo.chatting.model.vo.ChatLog;
import com.kh.thezo.chatting.model.vo.ChatRoom;
import com.kh.thezo.chatting.model.vo.Colleague;

//@author Jaewon.s
@Repository 
public class ChattingDao {
	
	/** 채팅 나의 동료 리스트 가져오는 DAO
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public ArrayList<Colleague> ajaxSelectColleagueList(SqlSessionTemplate sqlSession, int memNo) {
		return (ArrayList)sqlSession.selectList("chattingMapper.ajaxSelectColleagueList", memNo);
	}

	/** 이미 동료로 추가되어있는지 확인하는 DAO 
	 * @param sqlSession
	 * @param colleague
	 * @return
	 */
	public int ajaxCheckColleague(SqlSessionTemplate sqlSession, Colleague colleague) {
		return sqlSession.selectOne("chattingMapper.ajaxCheckColleague", colleague);
	}
	
	/** 친구 추가하는 DAO
	 * @param sqlSession
	 * @param colleague
	 * @return
	 */
	public int ajaxAddColleague(SqlSessionTemplate sqlSession, Colleague colleague) {
		return sqlSession.insert("chattingMapper.ajaxAddColleague", colleague);
	}

	/** 동료창에서 동료 더블클릭시에 이미 채팅방이 존재하는지 확인하는 DAO 
	 * @param sqlSession
	 * @param colleague
	 * @return
	 */
	public int ajaxCheckExistRoom(SqlSessionTemplate sqlSession, Colleague colleague) {
		String nullCheckRoomNo = sqlSession.selectOne("chattingMapper.ajaxCheckExistRoom", colleague); 
		if(nullCheckRoomNo == null) {
			return 0;
		}else {
			return Integer.parseInt(nullCheckRoomNo);
		}
	}

	/** 채팅방 만드는 DAO
	 * @param sqlSession
	 * @param colleague
	 * @return
	 */
	public int ajaxMakeRoom(SqlSessionTemplate sqlSession, Colleague colleague) {
		return sqlSession.insert("chattingMapper.ajaxMakeRoom", colleague);
	}

	/** 채팅방 만들어서 roomNo이 반환되면 이를 가지고 chat_connect만드는 DAO
	 * @param sqlSession
	 * @param colleague
	 * @return
	 */
	public int ajaxMakeChatConnect(SqlSessionTemplate sqlSession, Colleague colleague) {
		System.out.println(colleague);
		return sqlSession.insert("chattingMapper.ajaxMakeChatConnect", colleague);
	}

	/** 단체 채팅방에서 참여하지 않는 동료 목록 가져오는 DAO
	 * @param sqlSession
	 * @param colleague
	 * @return
	 */
	public ArrayList<Colleague> ajaxSelectExtraColleague(SqlSessionTemplate sqlSession, Colleague colleague) {
		return (ArrayList)sqlSession.selectList("chattingMapper.ajaxSelectExtraColleague", colleague);
	}

	/** 단체채팅방 이름 가져오는 DAO
	 * @param sqlSession
	 * @param roomNo
	 * @return
	 */
	public String ajaxSelectGroupName(SqlSessionTemplate sqlSession, int roomNo) {
		return sqlSession.selectOne("chattingMapper.ajaxSelectGroupName", roomNo);
	}

	/** 단체 채팅방 이름 수정하는 DAO
	 * @param sqlSession
	 * @param chatroom
	 * @return
	 */
	public int ajaxModifyGroupName(SqlSessionTemplate sqlSession, ChatRoom chatroom) {
		return sqlSession.update("chattingMapper.ajaxModifyGroupName", chatroom);
	}

	/** 단체 채팅방을 chatroom을 만드는 DAO
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxMakeGroupRoom(SqlSessionTemplate sqlSession, HashMap<Object, Object> hm) {
		return sqlSession.insert("chattingMapper.ajaxMakeGroupRoom", hm);
	}

	/** 단채채팅방 ChatRoom이 만들어지고 나면 !! 후에 chat_connect에 해당 방에 초대된 사람들의 번로를 기준으로 insert시키는 DAO
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxMakeGroupChatConnect(SqlSessionTemplate sqlSession, HashMap<Object, Object> hm) {
		return sqlSession.update("chattingMapper.ajaxMakeGroupChatConnect", hm);
	}

	/** 단체 채팅방에서 동료를 추가하는 DAO
	 * @param sqlSession
	 * @param hm
	 * @return
	 */
	public int ajaxAddGroupChat(SqlSessionTemplate sqlSession, HashMap<Object, Object> hm) {
		return sqlSession.update("chattingMapper.ajaxAddGroupChat", hm);
	}

	
	/** 채팅방 리스틑 조회해오는 DAO로다가 sql문에서 collection사용함 
	 * @param sqlSession
	 * @param myMemNo
	 * @return
	 */
	public ArrayList<ChatRoom> ajaxSelectMyChatList(SqlSessionTemplate sqlSession, int myMemNo) {
		return (ArrayList)sqlSession.selectList("chattingMapper.ajaxSelectMyChatList", myMemNo);
	}

	/**  채팅방 머리부 정보 가져오는 dao
	 * @param sqlSession
	 * @param memAndRoomNo
	 * @return
	 */
	public ArrayList<ChatRoom> ajaxBringRoomHeaderList(SqlSessionTemplate sqlSession, ChatLog memAndRoomNo) {
		return (ArrayList)sqlSession.selectList("chattingMapper.ajaxBringRoomHeaderList", memAndRoomNo);
	}

	/** 채팅 목록들을 일단위로 has many형태로 가져오는 dao
	 * @param sqlSession
	 * @param roomNo
	 * @return
	 */
	public ArrayList<ChatDailyBasic> ajaxbringChatInfoList(SqlSessionTemplate sqlSession, int roomNo) {
		return (ArrayList)sqlSession.selectList("chattingMapper.ajaxbringChatInfoList", roomNo);
	}
	
	//-----------------------------------------------------------------------------------------
	// ----------------------------본게임 시작이다 ! ! ----------------------------------------------
	public int InsertChatContent(SqlSessionTemplate sqlSession, ChatLog chatlog) {
		if(sqlSession.insert("chattingMapper.InsertChatContent", chatlog) >0) {
			return chatlog.getChatlogNo();
		}else {
			return 0;
		}
	}

	/** 마지막으로 읽은 채팅 바꾸는 DAO (채팅번호와 unread_count 0으로 만드는)
	 * @param sqlSession
	 * @param chatlog
	 * @return
	 */
	public int updateConnLastChat(SqlSessionTemplate sqlSession, ChatLog chatlog) {
		return sqlSession.update("chattingMapper.updateConnLastChat", chatlog);
	}

	/** 읽지않은 채팅갯수 조회해와서 unread_count에 update 하는 dao
	 * @param sqlSession
	 * @param count
	 * @return
	 */
	public int updateUnreadCount(SqlSessionTemplate sqlSession, ChatLog chatlog) {
		return sqlSession.update("chattingMapper.updateUnreadCount", chatlog);
	}

	/** 읽지않은 채팅 총갯수 가져오는 DAO
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public int totalUnreadCount(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.selectOne("chattingMapper.totalUnreadCount", memNo);
	}

	/** 읽지않은 쪽지 채팅 총갯수 가져오는 
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public int checkUnreadMsgAndChat(SqlSessionTemplate sqlSession, int memNo) {
		return sqlSession.selectOne("chattingMapper.checkUnreadMsgAndChat", memNo);
	}

	/** 내가 들어가있는 모든 채팅방 번호를 배열에 담아오는 DAO
	 * @param sqlSession
	 * @param memNo
	 * @return
	 */
	public int selectAllMyChatRoom(SqlSessionTemplate sqlSession, int memNo) {
	    ArrayList<String> roomlist = (ArrayList)sqlSession.selectList("chattingMapper.selectAllMyChatRoom", memNo);
		//System.out.println(roomlist);
		HashMap<Object, Object> hm = new HashMap<Object, Object>();
		hm.put("memNo", memNo);
		hm.put("roomlist",roomlist);
		//System.out.println(hm);
		return sqlSession.update("chattingMapper.selectAllMyChatRoom", memNo);
	}
	
	/** 로그인시에 읽지 않은 채팅 갯수 update하는 DAO 얘 또한 unread_count update하는 DAO
	 * @param sqlSession
	 * @param memNo
	 */
	//public void updateMyUnreadChatCount(SqlSessionTemplate sqlSession,HashMap<Object, Object> hm) {
	//	sqlSession.update("chattingMapper.updateMyUnreadChatCount", hm);
	//}
	
}
