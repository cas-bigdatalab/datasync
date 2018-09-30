package cn.csdb.portal.controller;


import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.SubjectMgmtService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/projectLibMgmt")
public class SubjectMgmtController {
    private SubjectMgmtService subjectService;
    private static final Logger logger = LogManager.getLogger(SubjectMgmtController.class);

    @Autowired
    public void setProjectLibService(SubjectMgmtService subjectService)
    {
        this.subjectService = subjectService;
    }

    /**
     * 添加专题库
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
            addedNotice = "增加专题库成功";
        }
        else
        {
            addedNotice = "增加专题库失败";
        }

        ModelAndView mv = new ModelAndView("subjectMgmt");
        mv.addObject("addedNotice", addedNotice);

        return mv;
    }

    /**
     * 删除专题库
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
     * 修改专题库
     * @param request
     * @param subject
     * @return
     */
    @RequestMapping(value = "/modifyProjectLib")
    public String modifySubject(HttpServletRequest request, Subject subject)
    {
        logger.info("enterring projectLibMgmtController-modifySubject");
        return "modifySubject";
    }

    /**
     * 查询目前已经有的专题库
     * @param request
     * @param currentPage
     * @return
     */
    @RequestMapping(value = "/querySubject")
    public String querySubject(HttpServletRequest request, @RequestParam(required=false) int currentPage)
    {
        logger.info("enterring projectLibMgmtController-querySubject");
        return "subjectMgmt";
    }

    /**
     * 数据库测试接口
     */
    @RequestMapping(value = "/dbConnectable")
    public ModelAndView dbConnectable(HttpServletRequest request)
    {
        logger.info("enterring subjectMgmtController-dbConnectable");
        String connectableMsg = subjectService.dbConnectable();

        ModelAndView mv = new ModelAndView("dbConnectable");
        mv.addObject("dbConnectableNotice", connectableMsg);
        return mv;
    }

}
