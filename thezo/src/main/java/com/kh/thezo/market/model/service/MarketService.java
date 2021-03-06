package com.kh.thezo.market.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.thezo.board.model.vo.Reply;
import com.kh.thezo.board.model.vo.Report;
import com.kh.thezo.common.model.vo.PageInfo;
import com.kh.thezo.market.model.vo.Market;
import com.kh.thezo.market.model.vo.PLike;

public interface MarketService {
	
	// 1. 사용자 : 벼룩시장 리스트 페이지 조회용
	int marketListCount();
	ArrayList<Market> selectMarketList(PageInfo pi);
			
	// 2. 사용자 : 벼룩시장 검색바 리스트 페이지 조회용
	public int marketSearchListCount(HashMap<String, String> map);
	public ArrayList<Market> marketSearchList(PageInfo pi, HashMap<String, String> map);
			
	// * 사용자 : 찜하기 목록
	int likeListCount(String memId);
	ArrayList<Market> selectLiketList(PageInfo pi, String memId);
			
	
	// 3. 사용자 : 벼룩시장 상세조회용
	int increaseMarketCount(int marketNo);
	Market selectMarket(int marketNo);
	PLike selectPLike(int marketNo);
	
	// 4. 사용자 : 벼룩시장 등록용
	int insertMarket(Market mk);
	
	// 5. 사용자 : 벼룩시장 삭제
	int deleteMarket(int marketNo);
	
	// 6. 사용자 : 벼룩시장 수정
	int updateMarket(Market mk);
	
	// 7. 사용자 : 벼룩시장 댓글 조회용
	ArrayList<Reply> marketReplyList(int marketNo);
			
	// 8. 사용자 : 벼룩시장 댓글 작성용
	int insertMarketReply(Reply r);
	
	// 9. 사용자 : 벼룩시장 게시글, 댓글 신고용
	int marketReport(Report rp);
	
	// 10. 사용자 : 벼룩시장 댓글 삭제 
	int deleteMarketReply(int replyNo);
			
	// 11. 사용자 : 벼룩시장 찜하기 
	public void insertMarketLike(PLike p);
	public void deleteMarketLike(PLike p);
	public int selectMarketLike(HashMap<String,String> likeCheck);
}
