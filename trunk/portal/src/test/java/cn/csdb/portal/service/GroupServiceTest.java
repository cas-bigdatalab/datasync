package cn.csdb.portal.service;

import cn.csdb.portal.repository.GroupDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;

/**
 * @program: DataSync
 * @description: group Service Test
 * @author: xiajl
 * @create: 2018-11-17 10:45
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:spring-mvc.xml"})
public class GroupServiceTest {
    private Logger logger = LoggerFactory.getLogger(PersonServiceTest.class);

    @Resource
    private GroupDao groupDao;

    @Test
    public void test(){
        String groupName = "烟叶质量组55";
        logger.info("\n\n" +String.valueOf(groupDao.exist(groupName)));
    }
}
