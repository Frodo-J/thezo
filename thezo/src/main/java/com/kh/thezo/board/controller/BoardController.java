package com.kh.thezo.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.thezo.board.model.service.BoardService;
import com.kh.thezo.board.model.vo.Board;
import com.kh.thezo.board.model.vo.BoardFile;
import com.kh.thezo.board.model.vo.Reply;
import com.kh.thezo.board.model.vo.Report;
import com.kh.thezo.common.model.vo.PageInfo;
import com.kh.thezo.common.template.Pagination;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bService;
	
	// main
	@ResponseBody
	@RequestMapping(value="mainBoard.bo", produces="application/json; charset=utf-8")
	public String mainBoard() {
		return new Gson().toJson(bService.mainBoard());
	}
	
	
	
	
	
	
	// ------------------------------------
	// 공지사항 리스트 페이지(사용자)
	@RequestMapping("noticeList.bo")
	public String selectNoticeList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = bService.noticeListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		ArrayList<Board> list = bService.selectNoticeList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "board/noticeListView";
	}
	
	
	
	// 공지사항 리스트페이지 검색바 (사용자)
	@RequestMapping("noticeSearch.bo")
	public ModelAndView noticeSearchList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage,
										 String condition, String keyword) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int listCount = bService.noticeSearchListCount(map);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		ArrayList<Board> list = bService.noticeSearchList(pi, map);
		
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("condition", condition)
		  .addObject("keyword", keyword)
		  .setViewName("board/noticeListView");
		
		return mv;
		
	}
	
	// 공지사항 상세조회(사용자)
	@RequestMapping("noticeDetail.bo")
	public ModelAndView noticeDetail(int bno, ModelAndView mv) {
		int result = bService.increaseNoticeCount(bno);
		
		if(result>0) { 
			BoardFile bf = bService.selectNoticeFile(bno);
			Board b = bService.selectNotice(bno); 
			
			mv.addObject("b", b).addObject("bf", bf).setViewName("board/noticeDetailView");
			
		}else {
			mv.addObject("errorMsg", "상세조회 실패").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	
	// 공지사항 작성하기 페이지 포워딩(사용자)
	@RequestMapping("noticeEnrollForm.bo")
	public String noticeEnrollForm() {
		return "board/noticeEnrollForm";
	}
	
	
	// 공지사항 등록하기(사용자)
	@RequestMapping("noticeInsert.bo")
	public String insertNotice(Board b, BoardFile bf, MultipartFile upfile, HttpSession session, Model model) {
	
		if(!upfile.getOriginalFilename().equals("")) {
			
			String changeName = saveFile(session, upfile); 
			bf.setOriginName(upfile.getOriginalFilename());  
			bf.setChangeName("resources/uploadFiles/" + changeName); 
		}
		
		int result = bService.insertNotice(b);
		
		if(result > 0 ) {
			if(bf.getOriginName() != null) {
				bService.insertNoticeFile(bf);
			}
			session.setAttribute("alertMsg", "성공적으로 공지사항이 등록되었습니다.");
			return "redirect:noticeList.bo";
		}else { 
			model.addAttribute("errorMsg", "공지사항 등록 실패");
			return "common/errorPage";
		}
					
	}
	
	
	// 공지사항 삭제하기 (사용자) -> 
	@RequestMapping("noticeDelete.bo")
	public String deleteNotice(int bno, String filePath, Model model, HttpSession session) {
		
		int result = bService.deleteBoard(bno);
		
		if(result > 0) { // 성공 => 리스트 페이지
			
			if(!filePath.equals("")) { // 첨부파일이 있었을 경우 => 파일 삭제
				String removeFilePath = session.getServletContext().getRealPath(filePath);
				new File(removeFilePath).delete();
			}
			
			session.setAttribute("alertMsg", "성공적으로 공지사항이 삭제되었습니다.");
			return "redirect:noticeList.bo";
			
		}else { // 실패
			model.addAttribute("errorPage", "공지사항 삭제 실패");
			return "common/errorPage";
		}
	}
	
	
	// 공지사항 수정하기 페이지 포워딩 (사용자)
	@RequestMapping("noticeUpdateForm.bo")
	public String updateForm(int bno, Model model) {
		model.addAttribute("bf", bService.selectNoticeFile(bno));
		model.addAttribute("b", bService.selectNotice(bno));
		return "board/noticeUpdateForm";
	}
		
	// 공지사항 수정하기 (사용자) 
	@RequestMapping("noticeUpdate.bo")
	public String updateNotice(BoardFile bf, Board b, MultipartFile reupfile, HttpSession session, Model model) {
		
		// 새로 넘어온 첨부파일이 있을 경우
		if(!reupfile.getOriginalFilename().equals("")) {
			// 기본에 첨부파일이 있었을 경우 => 기존의 첨부파일 지우기
			if(bf.getOriginName() != null) {
				new File(session.getServletContext().getRealPath(bf.getChangeName())).delete();
				// 새로 넘어온 첨부파일 서버 업로드 시키기
				String changeName = saveFile(session, reupfile);
				// bf에 새로 넘어온 첨부파일에 대한 정보 담기
				bf.setOriginName(reupfile.getOriginalFilename());
				bf.setChangeName("resources/uploadFiles/" + changeName);
			}else {
				
				// 새로 넘어온 첨부파일 서버 업로드 시키기
				String changeName = saveFile(session, reupfile);
				// bf에 새로 넘어온 첨부파일에 대한 정보 담기
				bf.setOriginName(reupfile.getOriginalFilename());
				bf.setChangeName( "resources/uploadFiles/" + changeName);
				
				bService.insertNoticeRefile(bf);
			}
		}
	
		// update문 실행하러 service 호출  
		int result = bService.updateBoard(b);
		
		if(result > 0) { // 성공
			
			bService.updateBoardFile(bf);
			session.setAttribute("alertMsg", "게시글 수정 성공");
			return "redirect:noticeDetail.bo?bno=" + b.getBoardNo();
		}else { // 실패
			model.addAttribute("errorMsg", "게시글 수정 실패");
			return "common/errorPage";
		}
	}
	
		
	
	// -------------------- 사내게시판 영역 --------------------------
	// 사내게시판 리스트 페이지(사용자)
	@RequestMapping("boardList.bo")
	public String selectBoardList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = bService.boardListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		ArrayList<Board> list = bService.selectBoardList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "board/boardListView";
	}
	
	
	// 사내게시판 리스트페이지 검색바 (사용자)
	@RequestMapping("boardSearch.bo")
	public ModelAndView boardSearchList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage,
										 String condition, String keyword) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int listCount = bService.boardSearchListCount(map);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		ArrayList<Board> list = bService.boardSearchList(pi, map);
		
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("condition", condition)
		  .addObject("keyword", keyword)
		  .setViewName("board/boardListView");
		
		return mv;
		
	}
	
	// 사내게시판 상세조회(사용자)
	@RequestMapping("boardDetail.bo")
	public ModelAndView boardDetail(int bno, ModelAndView mv) {
		int result = bService.increaseBoardCount(bno);
		
		if(result>0) { 
			BoardFile bf = bService.selectBoardFile(bno);
			Board b = bService.selectBoard(bno); 
			mv.addObject("b", b).addObject("bf", bf).setViewName("board/boardDetailView");
			
		}else {
			mv.addObject("errorMsg", "상세조회 실패").setViewName("common/errorPage");
		}
		
		return mv;
	}
	
	
	// 사내게시판 작성하기 페이지(사용자)
	@RequestMapping("boardEnrollForm.bo")
	public String boardEnrollForm() {
		return "board/boardEnrollForm";
	}
	
	
	// 사내게시판 등록하기(사용자)
	@RequestMapping("boardInsert.bo")
	public String insertboard(int memNo, Board b, BoardFile bf, MultipartFile upfile, HttpSession session, Model model) {
	
		if(!upfile.getOriginalFilename().equals("")) {
			
			String changeName = saveFile(session, upfile); 
			bf.setOriginName(upfile.getOriginalFilename());  
			bf.setChangeName("resources/uploadFiles/" + changeName); 
		}
		
		int result = bService.insertBoard(b);
		
		if(result > 0 ) {
			
			if(bf.getOriginName() != null) {
				bService.insertBoardFile(bf);
			}
				
			session.setAttribute("alertMsg", "성공적으로 게시글이 등록되었습니다.");
			return "redirect:boardList.bo";
		}else { 
			model.addAttribute("errorMsg", "게시글 등록 실패");
			return "common/errorPage";
		}
					
	}
	
	// 사내게시판 삭제하기 (사용자) -> filePath가 제대로 지워지는지..>? 
	@RequestMapping("boardDelete.bo")
	public String deleteBoard(int bno, String filePath, Model model, HttpSession session) {
		
		int result = bService.deleteBoard(bno);
		
		if(result > 0) { // 성공 => 리스트 페이지
			
			if(!filePath.equals("")) { // 첨부파일이 있었을 경우 => 파일 삭제
				String removeFilePath = session.getServletContext().getRealPath(filePath);
				new File(removeFilePath).delete();
			}
			
			session.setAttribute("alertMsg", "성공적으로 게시글이 삭제되었습니다.");
			return "redirect:boardList.bo";
			
		}else { // 실패
			model.addAttribute("errorPage", "게시글 삭제 실패");
			return "common/errorPage";
		}
	}
	
	
	
	// 사내게시판 수정하기 페이지 포워딩 (사용자)
	@RequestMapping("boardUpdateForm.bo")
	public String updateBoardForm(int bno, Model model) {
		model.addAttribute("bf", bService.selectBoardFile(bno));
		model.addAttribute("b", bService.selectBoard(bno));
		return "board/boardUpdateForm";
	}
		
	// 사내게시판 수정하기 (사용자) 
	@RequestMapping("boardUpdate.bo")
	public String updateBoard(BoardFile bf, Board b, MultipartFile reupfile, HttpSession session, Model model) {
		
		// 새로 넘어온 첨부파일이 있을 경우
		if(!reupfile.getOriginalFilename().equals("")) {
			// 기본에 첨부파일이 있었을 경우 => 기존의 첨부파일 지우기
			if(bf.getOriginName() != null) {
				new File(session.getServletContext().getRealPath(bf.getChangeName())).delete();
				// 새로 넘어온 첨부파일 서버 업로드 시키기
				String changeName = saveFile(session, reupfile);
				// bf에 새로 넘어온 첨부파일에 대한 정보 담기
				bf.setOriginName(reupfile.getOriginalFilename());
				bf.setChangeName("resources/uploadFiles/" + changeName);
			}else {
				
				// 새로 넘어온 첨부파일 서버 업로드 시키기
				String changeName = saveFile(session, reupfile);
				// bf에 새로 넘어온 첨부파일에 대한 정보 담기
				bf.setOriginName(reupfile.getOriginalFilename());
				bf.setChangeName("resources/uploadFiles/" + changeName);
				
				bService.insertBoardRefile(bf);
			}
		}
	
		// update문 실행하러 service 호출  
		int result = bService.updateBoard(b);
		
		if(result > 0) { // 성공
			
			bService.updateBoardFile(bf);
			session.setAttribute("alertMsg", "게시글 수정 성공");
			return "redirect:boardDetail.bo?bno=" + b.getBoardNo();
		}else { // 실패
			model.addAttribute("errorMsg", "게시글 수정 실패");
			return "common/errorPage";
		}
	}
	
		
	// 게시판 댓글 조회
	@ResponseBody
	@RequestMapping(value="rlist.bo", produces="application/json; charset=utf-8")
	public String selectReplyList(int bno){
		
		ArrayList<Reply> list = bService.selectReplyList(bno);
		//System.out.println(list);
		return new Gson().toJson(list);
		
	}
	
	
	// 게시판 댓글 입력
	@ResponseBody
	@RequestMapping("rinsert.bo")
	public String insertReply(Reply r) {
		
		int result = bService.insertReply(r);
		
		return result>0?"success":"fail";
	}
	
	// 사용자 : 사내게시글 신고하기 
	@RequestMapping("memBoardReport.bo")
	public String boardReport(Report rp, HttpSession session, Model model) {
		
		int result = bService.boardReport(rp);
		
		if(result>0) {
			session.setAttribute("alertMsg", "성공적으로 게시글이 신고되었습니다.");
			return "redirect:boardList.bo";
		}else {
			model.addAttribute("errorMsg", "게시글 신고 실패");
			return "common/errorPage";
		}
	}
	
	// 사용자 : 사내게시글 댓글 신고하기 
	@RequestMapping("boardReplyReport.bo")
	public String BoardReplyReport(Report rp, HttpSession session, Model model) {
			
		int result = bService.boardReport(rp);
			
		if(result>0) {
			session.setAttribute("alertMsg", "성공적으로 댓글이 신고되었습니다.");
			return "redirect:boardList.bo";
		}else {
			model.addAttribute("errorMsg", "댓글 신고 실패");
			return "common/errorPage";
		}
	}
	
	
	// 사용자 : 댓글 삭제
	@RequestMapping("deleteReply.bo")
	public String deleteBoardReply(int replyNo, int bno, Model model, HttpSession session) {
		
		int result = bService.deleteBoardReply(replyNo);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "성공적으로 댓글이 삭제되었습니다.");
			//return "redirect:boardList.bo;";
			return "redirect:boardDetail.bo?bno=" + bno;
			
		}else {
			model.addAttribute("errorPage", "댓글삭제 실패");
			return "common/errorPage";
		}
	}
	
	
	// ----------------------- 관리자 영역 --------------------------------------
	// 게시판 신고관리(관리자)
	@RequestMapping("boardReport.bo")
	public String boardReportList(Model model, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = bService.reportListCount();
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		ArrayList<Report> list = bService.selectReportList(pi);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		return "board/boardReport";
	}
	
	/*
	// 신고관리 리스트페이지 검색바 (관리자)
	@RequestMapping("reportSearch.bo")
	public ModelAndView reportSearchList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage,
										 String condition, String keyword) {
		
		HashMap<String, String> map = new HashMap<>();
		map.put("condition", condition);
		
		int listCount = bService.reportSearchListCount(map);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		ArrayList<Report> list = bService.reportSearchList(pi, map);
		
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("condition", condition)
		  .addObject("keyword", keyword)
		  .setViewName("board/boardReport");
		
		return mv;
		
	}
	*/
	

	// 신고관리 상세보기 페이지 포워딩
	@RequestMapping("adReportDetail.bo")
	public ModelAndView reportDetail(int rpCode, ModelAndView mv) {
		
		Report r = bService.selectReport(rpCode);
		
		if( r != null) {
			mv.addObject("r", r).setViewName("board/reportDetailView");
		}else {
			mv.addObject("errorMsg", "신고글 상세조회 실패");
		}
		return mv;
	}
	
	// 신고관리 처리하기 
	@RequestMapping("reportUpdate.bo")
	public String reportUpdate(Report r , int rpNo, HttpSession session, Model model) {
		
		// 신고글 => 게시판 삭제하기일 경우
		if(r.getRpType() == 1) {
			// 해당 신고게시글 참조 게시글 상태를 N으로 변경
			int result1 = bService.updateBoardStatus(rpNo);
			
			if(result1 > 0) {
				// report의 상태 : N => Y로 변경
				int result2 = bService.reportBoardUpdate(r);
				
				System.out.println(result2);
				
				if(result2 > 0) {
					session.setAttribute("alertMsg", "성공적으로 신고 처리되었습니다.");
					return "redirect:boardReport.bo";
				}else {
					model.addAttribute("errorMsg", "신고처리 실패");
					return "common/erroPage";
				}
				
			}else{
				model.addAttribute("errorMsg", "신고처리 실패");
				return "common/erroPage";
			}
			
		}else { // 신고글 => 댓글 삭제할 경우
			
			// 해당 신고게시글 참조 댓글상태를 N으로 변경
			
			int result1 = bService.updateBoardReplyStatus(rpNo);
			
			if(result1 > 0) {
				// report의 상태 : N => Y로 변경
				int result2 = bService.reportBoardUpdate(r);
				
				System.out.println(result2);
				
				if(result2 > 0) {
					session.setAttribute("alertMsg", "성공적으로 신고 처리되었습니다.");
					return "redirect:boardReport.bo";
				}else {
					model.addAttribute("errorMsg", "신고처리 실패");
					return "common/erroPage";
				}
				
			}else {
				model.addAttribute("errorMsg", "신고처리 실패");
				return "common/erroPage";
			}
			
		}
		
		
		
	}
	

	
	
	
	
	// 서버에 업로드 시키는 것(파일저장)을 메소드로 작성
	public String saveFile(HttpSession session, MultipartFile upfile) {
		// 경로
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
						
		String originName = upfile.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date()); // Date : java.util import
		int ranNum = (int)(Math.random() * 90000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
						
		String changeName = currentTime + ranNum + ext;
						
		try {
			upfile.transferTo(new File(savePath + changeName));   // File : java.io import
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
			
		return changeName;
	}
	
}
