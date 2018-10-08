package cn.csdb.portal.controller;


import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.SubjectMgmtService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

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

    /**
     * add Subject
     * @param request
     * @param subject
     * @return
     */
    @RequestMapping(value = "/addSubject")
    public ModelAndView addSubject(HttpServletRequest request, @RequestParam(required=true) Subject subject)
    {
        logger.info("enterring subjectMgmtController-addSubject");

        int addItemNum = subjectService.addSubject(subject);
        String addedNotice = "";
        if (addItemNum > 0)
        {
            addedNotice = "success to add subject ";
        }
        else
        {
            addedNotice = "failed to add subject";
        }

        ModelAndView mv = new ModelAndView("subjectMgmt");
        mv.addObject("addedNotice", addedNotice);

        return mv;
    }

    /**
     * delete subject
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "/deleteSubject")
    public String deleteSubject(HttpServletRequest request, @RequestParam(required=true) int id)
    {
        logger.info("enterring SubjectMgmtController-deleteSubject");
        return "deleteSubject";
    }

    /**
     * modifySubject
     * @param request
     * @param subject
     * @return
     */
    @RequestMapping(value = "/modifySubject")
    public String modifySubject(HttpServletRequest request, Subject subject)
    {
        logger.info("enterring SubjectMgmtController-modifySubject");
        return "modifySubject";
    }

    /**
     * querySubject
     * @param request
     * @param currentPage
     * @return
     */
    @RequestMapping(value = "/querySubject")
    public String querySubject(HttpServletRequest request, @RequestParam(required=false) int currentPage)
    {
        logger.info("enterring SubjectMgmtController-querySubject");
        return "subjectMgmt";
    }

    /**
     * test db connectivity
     */
    @RequestMapping(value = "/dbConnectable")
    public ModelAndView dbConnectable(HttpServletRequest request)
    {
        logger.info("enterring subjectMgmtController-dbConnectable");
        String connectableMsg = subjectService.dbConnectable();

        ModelAndView mv = new ModelAndView("subjectMgmt");
        mv.addObject("dbConnectableNotice", connectableMsg);
        return mv;
    }

}
