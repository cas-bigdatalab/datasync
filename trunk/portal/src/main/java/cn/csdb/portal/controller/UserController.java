package cn.csdb.portal.controller;

import cn.csdb.portal.model.User;
import cn.csdb.portal.service.UserService;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping(value="/user")
public class UserController {
    private Logger logger= LoggerFactory.getLogger(UserController.class);

    @Resource
    private UserService userService;

    @ResponseBody
    @RequestMapping(value="/queryUser")
    public JSONObject queryUser(HttpServletRequest request, HttpServletResponse response,
                                @RequestParam(value="loginId", required = false, defaultValue = "") String loginId,
                                @RequestParam(value="userName", required = false, defaultValue = "") String userName,
                                @RequestParam(value="groups", required = false, defaultValue = "") String groups,
                                @RequestParam(value="curUserPageNum", required = false, defaultValue = "1") int curUserPageNum,
                                @RequestParam(value = "pageSize",required = false, defaultValue = "10") int pageSize)
    {
        logger.info("enter queryUser - parameters[loginId = " + loginId + ", userName = " + userName + ", groups = " + groups + "]");
        logger.info("enter queryUser - parameters[curUserPageNum = " + curUserPageNum + ", pageSize = " + pageSize + "]");

        List<User> users = userService.queryUser(loginId, userName, groups, curUserPageNum, pageSize);

        logger.info("query user result - users = " + users);

        // prepare date to retrieve
        JSONObject userQueryResult = new JSONObject();
        userQueryResult.put("list", users);
        userQueryResult.put("curUserPageNum", curUserPageNum);
        userQueryResult.put("pageSize", 10);

        long totalUsers = userService.getTotalUsers();

        userQueryResult.put("totalUsers", totalUsers);
        userQueryResult.put("totalUserPages", (totalUsers / pageSize + (totalUsers % pageSize == 0 ? 0 : 1)));

        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");

        return userQueryResult;
    }

    @RequestMapping(value="/addUser")
    public String addUser(HttpServletRequest request, User user)
    {
        logger.info("enter addUser - parameters[user = " + user + "]");
        SimpleDateFormat sdf =new SimpleDateFormat("yyyy-mm-dd  HH:mm:ss");
        user.setCreateTime(sdf.format(new Date()));
        user.setStat(1);
        int addedUserCnt = userService.addUser(user);
        logger.info("after addUser - addedUserCnt = " + addedUserCnt);

        return "redirect:/user/queryUser";
    }

    @RequestMapping(value="/updateGroup")
    public String updateGroups(HttpServletRequest request, @RequestParam(value = "loginId") String loginId, @RequestParam(value = "group") String group)
    {
        logger.info("enter updateGroups - parameters[loginId = " + loginId + ", group = " + group);
        int updatedUserCnt = userService.updateGroups(loginId, group);
        logger.info("after updateGroups - updatedUserCnt = " + updatedUserCnt);

        return "redirect:/user/queryUser";
    }

}
