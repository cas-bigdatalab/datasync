package cn.csdb.portal.service;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.model.User;
import cn.csdb.portal.repository.CheckUserDao;
import cn.csdb.portal.repository.GroupDao;
import cn.csdb.portal.repository.UserDao;
import org.apache.commons.lang3.StringUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Arrays;
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

    @Test
    public void testDeleteGroupName(){
        String groups ="test";  //烟叶质量组,烟叶质量组2,系统管理员,烟叶质量组3,
        //String s = StringUtils.remove(groups,"test");
        List<String> list = Arrays.asList(StringUtils.split(groups,","));
        ArrayList<String> result = new ArrayList<String>(list);
        logger.info("\n\n==================================");
        logger.info(String.valueOf(result.size()));

        result.remove("test");
        logger.info(String.valueOf(result.size()));

        logger.info(StringUtils.join(result,","));
    }


    @Test
    public void testFindAllByRole(){
        String role ="普通用户";
        List<User> list = userDao.getAllbyRole(role);
        logger.info("\n\n==================================");
        logger.info(String.valueOf(list.size()));
        for (User user : list ){
            logger.info(user.getUserName() +"--"  +user.getRole() +"--" +user.getGroups());
        }
    }
}
