package cn.csdb.portal.repository;

import cn.csdb.portal.model.Site;
import cn.csdb.portal.repository.mapper.SiteMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-15 14:47
 **/
@Repository
public class SiteDao {
    @Resource
    private JdbcTemplate jdbcTemplate;

    public Site getSiteByMarker(String siteMarker){
        String sql = "select * from site where SiteMarker=?";
        List<Site> list = jdbcTemplate.query(sql,new SiteMapper());
        if(list.size() == 0){
            return null;
        }
        return list.get(0);
    }
}
