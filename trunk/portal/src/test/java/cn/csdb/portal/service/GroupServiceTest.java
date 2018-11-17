package cn.csdb.portal.service;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.model.User;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.repository.GroupDao;
import cn.csdb.portal.repository.UserDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;
import java.util.List;

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
    @Resource
    private UserDao userDao;

    @Resource
    private CheckUserDao checkUserDao;

    @Resource
    private GroupService groupService;

    @Test
    public void test(){
        String groupName = "烟叶质量组55";
        logger.info("\n\n" +String.valueOf(groupDao.exist(groupName)));
    }

    @Test
    public void testQueryUserByGroupName(){
        String groupName = "烟叶质量组";
        List<User> list = userDao.queryByGroupName(groupName);
        logger.info("\n\n============================" );
        for (User user : list){
            logger.info(user.getUserName() + ":" + user.getGroups());
        }
    }


    @Test
    public void testUpdateUserGroupName(){
        String groupName = "烟叶质量组55";
        User user = userDao.getUserById("5bed1284c2257c2b4b1a4661");
        logger.info("\n\n==================================" );
        logger.info(user.getUserName() + ": " +user.getGroups());
        groupService.updateUserGroupName(user,"烟叶质量组");
        logger.info(user.getUserName() + ": " +user.getGroups());

    }


    @Test
    public void testGetSubjectByCode(){
        String subjectCode ="sdc001";
        Subject subject = checkUserDao.getSubjectByCode(subjectCode);
        logger.info("\n\n===================================");
        if (subject != null)
            logger.info(subject.getSubjectName() + ":" + subject.getSubjectCode());
    }
}
