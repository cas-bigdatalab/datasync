package cn.csdb.portal.controller;


import cn.csdb.portal.model.ProjectLib;
import cn.csdb.portal.service.ProjectLibMgmtService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.net.PortUnreachableException;

@Controller
@RequestMapping("/projectLibMgmt")
public class ProjectLibMgmtController {
    private ProjectLibMgmtService projectService;
    private static final Logger logger = LogManager.getLogger(ProjectLibMgmtController.class);

    @Autowired
    public void setProjectService(ProjectLibMgmtService projectService)
    {
        this.projectService = projectService;
    }

    /**
     * 添加专题库
     * @param request
     * @param projectLib
     * @return
     */
    @RequestMapping(value = "/addProjectLib")
    public String addProjectLib(HttpServletRequest request, @RequestParam(required=true) ProjectLib projectLib)
    {
        logger.info("enterring projectLibMgmtController-addProjectLib");
        return "addProjectLib";
    }

    /**
     * 删除专题库
     * @param request
     * @param projectLibId
     * @return
     */
    @RequestMapping(value = "/deleteProjectLib")
    public String deleteProjectLib(HttpServletRequest request, @RequestParam(required=true) int projectLibId)
    {
        logger.info("enterring projectLibMgmtController-deleteProjectLib");
        return "deleteProjectLib";
    }

    /**
     * 修改专题库
     * @param request
     * @param projectLibId
     * @return
     */
    @RequestMapping(value = "/modifyProjectLib")
    public String projectLibMgmt(HttpServletRequest request, @RequestParam(required=true) int projectLibId)
    {
        logger.info("enterring projectLibMgmtController-modifyProjectLib");
        return "modifyProjectLib";
    }

    /**
     * 查询目前已经有的专题库
     * @param request
     * @param currentPage
     * @return
     */
    @RequestMapping(value = "/queryProjectLib")
    public String queryProjectLib(HttpServletRequest request, @RequestParam(required=false) int currentPage)
    {
        logger.info("enterring projectLibMgmtController-queryProjectLib");
        return "queryProjectLib";
    }
}
