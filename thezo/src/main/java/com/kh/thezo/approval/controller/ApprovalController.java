package com.kh.thezo.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.thezo.approval.model.service.ApprovalService;
import com.kh.thezo.approval.model.vo.Approval;
import com.kh.thezo.approval.model.vo.ApprovalAccept;
import com.kh.thezo.common.model.vo.PageInfo;
import com.kh.thezo.common.template.Pagination;
import com.kh.thezo.mail.model.vo.Attachment;
//@author YI
import com.kh.thezo.member.model.vo.Member;


@Controller
public class ApprovalController {
	
	
	@Autowired
	private ApprovalService aService;
	
	

	//전자결재 메인페이지로 관련있는 결재리스트 불러오기
	@RequestMapping("main.appr")
	public ModelAndView selectApprovalMain(ModelAndView mv, @RequestParam(value="apprFolder", defaultValue="main") String apprFolder, HttpSession session, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		Member m = (Member) session.getAttribute("loginUser");
//		System.out.println(apprFolder);
		// 페이징 확인
		Approval a = new Approval();
		a.setStatus("");
		a.setMemNo(m.getMemNo());
		a.setApprFolder(apprFolder);
		int listCount = aService.selectListCount(a);
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		ArrayList<Approval> list = aService.selectApprovalMain(a, pi);
//		System.out.println(list);
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .addObject("apprFolder", apprFolder)
		  .setViewName("approval/approvalMain");
//		System.out.println(pi);
		return mv;
	}
	
	
	// 문서양식 리스트 불러오기
	@RequestMapping("new.appr")
	public ModelAndView newApprList(ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		int listCount = aService.newApprListCount();
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, 10, 5);
		ArrayList<Approval> list = aService.newApprList(pi);
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .setViewName("approval/approvalNew");
		return mv;
	}
	
	// 문서 작성하는 페이지 
	@RequestMapping("enrollForm.appr")
	public ModelAndView enrollApproval(ModelAndView mv, HttpSession session, int ano) {
		Approval aTemp = new Approval();
		Member m = (Member) session.getAttribute("loginUser");
		aTemp.setMemNo(m.getMemNo()); 
		aTemp.setDeptNo(m.getDepNo()); 
		aTemp.setFormNo(ano);
		Approval a = aService.enrollApproval(aTemp);
		ArrayList<Member> empList = aService.employeeList();
		ArrayList<ApprovalAccept> cLine = aService.selectformLineList(aTemp);
		System.out.println(cLine);
		Member leaveCount = aService.selectLeave(aTemp.getMemNo());
//		System.out.println("A는"+a);
//		System.out.println("cLine는"+cLine);
		
		mv.addObject("a", a) // 문서 포맷
			.addObject("empList", empList) // 전사원 리스트 
			.addObject("cLine", cLine);  // 해당 양식의 결재선
		
		//연차신청인 경우 다른 페이지로 이동
		if(a.getFormNo()==5) {
			mv.addObject("leaveCount", leaveCount) // 연차 잔여갯수 
			.setViewName("approval/approvalLeaveForm");
		} else {
			mv.setViewName("approval/approvalEnrollForm");
		}
		
		return mv;
	}
	
	// 첨부파일 저장을 위한 메소드 모듈화
	public String saveFile(HttpSession session, MultipartFile upfile) {
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/approval/");
		String originName = upfile.getOriginalFilename();
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		int ranNum = (int)(Math.random() * 90000 + 10000);
		String ext = originName.substring(originName.lastIndexOf("."));
		String changeName = currentTime + ranNum + ext;
		
		try {
			upfile.transferTo(new File(savePath + changeName));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return changeName;
	}
	

	
	// 임시저장 입력하기
//	public ModelAndView tempApproval(Approval a,HttpSession session, ModelAndView mv) {
//		Member m = (Member) session.getAttribute("loginUser");
//		a.setMemNo(m.getMemNo());
//		a.setStatus("임시");
//		System.out.println(a);
//		
//		
//		//임시파일 데이터를 db에 저장
//		int result = aService.tempApproval(a);
//		
//		if(result > 0) { // 저장이 성공했다면
//			
//			// 방금 성공한 임시 저장파일의 문서번호를 가져오기 
//			int docNo= aService.selectRecentTemp(m.getMemNo());
//			
//			Approval b = aService.detailApproval(docNo);
//			ArrayList<Member> empList = aService.employeeList();
//			ArrayList<ApprovalAccept> aLine = aService.detailApprovalLine(docNo);
//			System.out.println("임시b"+b);
//			System.out.println("임시aLine"+aLine);
//			mv.addObject("a", b) 
//				.addObject("aLine", aLine) 
//				.addObject("empList", empList) // 전사원 리스트 
//				.addObject("aLine", aLine);  // 해당 양식에 저장된 결재선
//			session.setAttribute("alertMsg", "성공적으로 저장 되었습니다.");
//			mv.setViewName("approval/approvalEnrollForm");
//		}else {
//			mv.addObject("errorMsg", "저장에 실패했습니다");
//			mv.setViewName("common/errorPage");
//		}
//		return mv;
//		
//	}
	
	
	// 문서작성후 기안하기 매핑
	@RequestMapping("insertDocu.appr")
	public ModelAndView insertApprovalDocument(String tempStatus, Approval a,HttpSession session, MultipartFile[] upfile, ModelAndView mv) {
		Member m = (Member) session.getAttribute("loginUser");
		System.out.println("tempStatus"+tempStatus);
		a.setMemNo(m.getMemNo());
//		System.out.println("insertDocu"+a);
//		if(tempStatus!=null&&tempStatus.equals("임시")) {
//			System.out.println("임시로간다");
//			ModelAndView mvTemp= tempApproval(a,session,upfile,mv);
//			return mvTemp;
//		} else {
			a.setStatus("대기");
			System.out.println(a);
			if (!upfile[0].getOriginalFilename().equals("")) {
				ArrayList<Attachment> list = new ArrayList<>();
	
				for (int i = 0; i < upfile.length; i++) {
					Attachment at = new Attachment();
					String changeName = saveFile(session, upfile[i]); 
					at.setOriginName(upfile[i].getOriginalFilename());
					at.setFileUrl("resources/uploadFiles/approval/" + changeName);
					at.setFileLevel(i+1);
					list.add(at);
				}
				a.setAt(list);
			}
			int result = aService.insertApprovalDocument(a);
			if(result > 0) { // 성공
				session.setAttribute("alertMsg", "성공적으로 등록 되었습니다.");
				mv.setViewName("redirect:main.appr");
			}else {
				mv.addObject("errorMsg", "작성에 실패했습니다");
				mv.setViewName("common/errorPage");
			}
			return mv;
//		}
		
	}
	
	// 결재문서 상세조회 (회수/승인/반려는 여기서 진행)
	@RequestMapping("detailDocu.appr")
	public ModelAndView detailApproval(int docNo, ModelAndView mv) {
		Approval a = aService.detailApproval(docNo);
		ArrayList<ApprovalAccept> aLine = aService.detailApprovalLine(docNo);
		mv.addObject("a", a) 
		.addObject("aLine", aLine) 
		.setViewName("approval/apprDetailDocu");
		System.out.println(a);
		return mv;
	}
	
	// 승인반려 선택시 진행되는 매핑
	@RequestMapping("approveDocu.appr")
	public ModelAndView approveDocu(int lastApprover, HttpSession session, ApprovalAccept a, String apprStatus, ModelAndView mv) {
		Member m = (Member) session.getAttribute("loginUser");
		a.setStatus(apprStatus); //모델앤뷰 변수와 충돌되어서 별도로 뺐음
		if(m.getMemNo()==a.getMemNo() || m.getStatus().equals("A")) {
			System.out.println("여기 뭐가 있는지 알게 뭐람"+a);
			int result = aService.approveDocu(lastApprover,a);
			if(result > 0) { // 성공
				session.setAttribute("alertMsg", "성공적으로 등록 되었습니다.");
				mv.setViewName("redirect:detailDocu.appr?docNo="+a.getDocNo());
			}else {
				mv.addObject("errorMsg", "작성에 실패했습니다");
				mv.setViewName("common/errorPage");
			}
		}else {
			mv.addObject("errorMsg", "잘못된 경로로 접근하셨습니다. 로그인을 확인 해 주세요");
			mv.setViewName("common/errorPage");
		}
		return mv;	
	}
	
	// 반려 선택시 진행되는 매핑
		@RequestMapping("denyDocu.appr")
		public ModelAndView denyDocu(HttpSession session, ApprovalAccept a, String apprStatus, ModelAndView mv) {
			Member m = (Member) session.getAttribute("loginUser");
			a.setStatus(apprStatus); //모델앤뷰 변수와 충돌되어서 별도로 뺐음
			if(m.getMemNo()==a.getMemNo() || m.getStatus().equals("A")) {
				
				int result = aService.approveDocu(-1,a);
				if(result > 0) { // 성공
					session.setAttribute("alertMsg", "성공적으로 등록 되었습니다.");
					mv.setViewName("redirect:detailDocu.appr?docNo="+a.getDocNo());
				}else {
					mv.addObject("errorMsg", "작성에 실패했습니다");
					mv.setViewName("common/errorPage");
				}
			}else {
				mv.addObject("errorMsg", "잘못된 경로로 접근하셨습니다. 로그인을 확인 해 주세요");
				mv.setViewName("common/errorPage");
			}
			return mv;	
		}
		
	
	@RequestMapping("adminMain.appr") //관리자 페이지 메인
	public String adminMainApproval() {
		return "approval/apprAdmin";
	}
	
	@RequestMapping("editForm.appr")  //관리자 페이지에서 양식 수정 매핑
	public String adminEditFormApproval() {
		return "approval/apprAdminEditForm";
	}
	
	
}
