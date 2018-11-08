package cn.csdb.portal.controller;

import cn.csdb.portal.model.User;
import cn.csdb.portal.service.CheckUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by shiba on 2018/11/6.
 */
@Controller
public class CheckUserController {
    @Resource
    private CheckUserService checkUserService;

    @RequestMapping("/login")
        public String login(User user, HttpServletRequest request) {

            //获取当前用户
            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(user.getUserName(), user.getPassword());
            try {
                //为当前用户进行认证，授权
                subject.login(token);
                User u = checkUserService.getByUserName(user.getUserName());
                if(user.getSubjectCode()!=null) {
                    cn.csdb.portal.model.Subject sub = checkUserService.getSubjectByCode(u.getSubjectCode());
                    request.getSession().setAttribute("userName", u.getUserName());
                    request.getSession().setAttribute("LoginId", u.getLoginId());
                    request.getSession().setAttribute("DbName", sub.getDbName());
                    request.getSession().setAttribute("SubjectName", sub.getSubjectName());
                    request.getSession().setAttribute("SubjectCode", sub.getSubjectCode());
                }
                return "redirect:/loginSuccess";

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("user", user);
                if(user.getUserName()==null&&user.getPassword()==null){
                    request.setAttribute("errorMsg", "");
                }else {
                    request.setAttribute("errorMsg", "用户名或密码错误！");
                }
                return "loginNew";
            }
        }

        @RequestMapping("/loginSuccess")
        public String loginSuccess() {
            return "index";
        }
}