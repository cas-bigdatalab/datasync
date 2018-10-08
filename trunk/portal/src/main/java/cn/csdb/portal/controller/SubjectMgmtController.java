package cn.csdb.portal.controller;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.SubjectMgmtService;
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

    @RequestMapping(value = "/addSubject")
    public ModelAndView addSubject(HttpServletRequest request, @RequestParam(required=true) Subject subject)
    {
        logger.info("SubjectMgmtController-addSubject");

        String addSubjectNotice = subjectService.addSubject(subject);

        ModelAndView mv = new ModelAndView("subjectMgmt");
        mv.addObject("addSubjectNotice", addSubjectNotice);

        return mv;
    }

    @RequestMapping(value = "/deleteSubject")
    public ModelAndView deleteSubject(HttpServletRequest request, @RequestParam(required=true) int id)
    {
        logger.info("SubjectMgmtController-deleteSubject");

        String deleteSubjectNotice = subjectService.deleteSubject(id);

        ModelAndView mv = new ModelAndView("subjectMgmt");
        mv.addObject("deleteSubjectNotice", deleteSubjectNotice);

        return mv;
    }

    @RequestMapping(value = "/modifySubject")
    public ModelAndView modifySubject(HttpServletRequest request, @RequestParam(required=true)Subject subject)
    {
        logger.info("SubjectMgmtController-modifySubject");

        String modifySubjectNotice = subjectService.modifySubject(subject);

        ModelAndView mv = new ModelAndView("subjectMgmt");
        mv.addObject("modifySubjectNotice", modifySubjectNotice);

        return mv;
    }

    @RequestMapping(value = "/querySubject")
    public ModelAndView querySubject(HttpServletRequest request, @RequestParam(required=true) int currentPage)
    {
        logger.info("enterring SubjectMgmtController-querySubject");

        List<Subject> subjectsOfThisPage = subjectService.querySubject(currentPage);

        ModelAndView mv = new ModelAndView("subjectMgmt");
        mv.addObject("subjectsOfThisPage", subjectsOfThisPage);

        return mv;
    }
}
