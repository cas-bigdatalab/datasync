package cn.csdb.portal.controller;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.SubjectMgmtService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/subjectMgmt")
public class SubjectMgmtController {
    private SubjectMgmtService subjectService;
    private static final Logger logger = LogManager.getLogger(SubjectMgmtController.class);

    @Autowired
    public void setProjectLibService(SubjectMgmtService subjectService)
    {
        this.subjectService = subjectService;
    }

    @RequestMapping(value = "/addSubject", method = RequestMethod.POST)
    public String addSubject(HttpServletRequest request, Subject subject)
    {
        System.out.println("enterring subjectMgmt-addSubject.");
        System.out.println(subject);

        String addSubjectNotice = subjectService.addSubject(subject);

        int totalPages = subjectService.getTotalPages();
        String redirectStr = "redirect:/subjectMgmt/querySubject?currentPage=" + totalPages;

        return redirectStr;
    }

    @RequestMapping(value = "/deleteSubject")
    public String deleteSubject(HttpServletRequest request, @RequestParam(required=true) int id, @RequestParam(required = true) int currentPage)
    {
        System.out.println("SubjectMgmtController-deleteSubject, id = " + id + ", currentPage = " + currentPage);

        String deleteSubjectNotice = subjectService.deleteSubject(id);
        System.out.println("SubjectMgmtController-deleteSubject，deleteSubjectNotice = " + deleteSubjectNotice);

/*
        String redirectStr = "redirect:/subjectMgmt/querySubject?currentPage=" + currentPage;
*/
        String redirectStr = "redirect:/subjectMgmt/querySubject?currentPage=1";

        return redirectStr;
    }

    @RequestMapping(value = "/updateSubject")
    public String updateSubject(HttpServletRequest request, Subject subject)
    {
        System.out.println("SubjectMgmtController-updateSubject");
        System.out.println("SubjectMgmtController-updateSubject -" + subject);
        String modifySubjectNotice = subjectService.modifySubject(subject);

        String redirectUrl = "redirect:/subjectMgmt/querySubject?currentPage=1";

        return redirectUrl;
    }

    @RequestMapping(value = "/querySubject")
    public ModelAndView querySubject(HttpServletRequest request, @RequestParam(required=true) int currentPage)
    {
        System.out.println("enterring SubjectMgmtController-querySubject");

        int totalPages = 0;
        totalPages = subjectService.getTotalPages();

        List<Subject> subjectsOfThisPage = subjectService.querySubject(currentPage);

        ModelAndView mv = new ModelAndView("subjectMgmt");
        mv.addObject("totalPages", totalPages);
        mv.addObject("subjectsOfThisPage", subjectsOfThisPage);


        return mv;
    }

    @RequestMapping(value = "/querySubjectById")
    @ResponseBody
    public JSONObject querySubjectById(HttpServletRequest request, @RequestParam(required=true) int id)
    {
        System.out.println("enterring SubjectMgmtController-querySubjectById");
        Subject subject = subjectService.findSubjectById(id);
        System.out.println("querySubjectById - " + subject);

        return (JSONObject)JSON.toJSON(subject);
    }
}
