package cn.csdb.portal.service;

import cn.csdb.portal.model.Site;
import cn.csdb.portal.repository.SiteDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-15 14:54
 **/
@Service
public class SiteService {

    @Autowired
    private SiteDao siteDao;

    public Site getSiteByMarker(String siteMarker){
        return siteDao.getSiteByMarker(siteMarker);
    }
}
