package cn.csdb.portal.service;

import cn.csdb.portal.repository.ProjectLibMgmtDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProjectLibMgmtService {
    private ProjectLibMgmtDao projectLibMgmtDao;

    @Autowired
    public void setProjectLibMgmtDao(ProjectLibMgmtDao projectLibMgmtDao)
    {
        this.projectLibMgmtDao = projectLibMgmtDao;
    }
}
