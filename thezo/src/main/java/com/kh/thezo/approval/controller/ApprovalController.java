package com.kh.thezo.approval.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.thezo.approval.model.service.ApprovalService;
import com.kh.thezo.mail.model.vo.Attachment;
import com.kh.thezo.member.model.vo.Member;

//@author YI


@Controller
public class ApprovalController {
	
	
	@Autowired
	private ApprovalService aService;
	

	@RequestMapping("main.appr")
	public String selectApprovalMain(HttpServletRequest request) {
		System.out.println(request.getSession().getAttribute("loginUser"));
		Member m = (Member)request.getSession().getAttribute("loginUser");
		String memId= m.getUserId();
		
		return "approval/approvalMain";
	}
	
	@RequestMapping("new.appr")
	public String newApproval() {
		return "approval/approvalNew";
	}
	
	@RequestMapping("enrollForm.appr")
	public String enrollApproval() {
		 return "approval/approvalEnrollForm";
	}
	
	@RequestMapping("leaveEnrollForm.appr")
	public String leaveEnrollApproval() {
		return "approval/approvalLeaveForm";
	}
	
	public String saveFile(HttpSession session, MultipartFile upfile) {
		
		String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/mail/");
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
	
	
	@ResponseBody
	@RequestMapping("insertDocu.appr")
	public ModelAndView insertApprovalDocument(String summernote,HttpSession session,MultipartFile[] upfile, ModelAndView mv ) {
		System.out.println(summernote);
		if (!upfile[0].getOriginalFilename().equals("")) {
			ArrayList<Attachment> list = new ArrayList<>();

			for (int i = 0; i < upfile.length; i++) {
				Attachment at = new Attachment();
				String changeName = saveFile(session, upfile[i]); // "2021070217013023152.jpg"
				at.setOriginName(upfile[i].getOriginalFilename());
				at.setChangeName("resources/uploadFiles/mail/" + changeName);
				list.add(at);
			}
		}
		String whatthe="asdasdㅁㄴㅇㅁㄴㅇㅁㄴㅇㅁㄴㅇasdasdas<br><br>";
		mv.addObject("whatthe", whatthe);
		
		mv.addObject("summernote", summernote)
		  .setViewName("approval/approvalTemp");
		return mv;
	}
	
	@RequestMapping("reportDocu.appr")
	public String reportApproval() {
		return "approval/apprReportDocu";
	}
	
	@RequestMapping("reportFinDocu.appr")
	public String reportFinApproval() {
		return "approval/apprReportFinDocu";
	}
	
	
	@RequestMapping("tempDocu.appr")
	public String tempApproval() {
		return "approval/apprTempDocu";
	}

	
	@RequestMapping("waiting.appr")
	public String waitingApproval() {
		return "approval/apprWaiting";
	}
	
	@RequestMapping("approved.appr")
	public String approvedApproval() {
		return "approval/apprApproved";
	}
	
	@RequestMapping("reference.appr")
	public String referenceApproval() {
		return "approval/apprReference";
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
