package cn.csdb.drsr.controller;

import cn.csdb.drsr.service.LoginService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class LoginController {
    @Resource
    private LoginService loginService;

    private static final Logger logger = LogManager.getLogger(LoginController.class);

    @RequestMapping(value = "/validateLogin")
    public String validateLogin(HttpServletRequest request, @RequestParam(required = true) String userName, @RequestParam(required = true) String password, RedirectAttributes attributes) {
        logger.info("enterring validateLogin");
        logger.info("userName = " + userName + ", password = " + password);

        String loginNotice = "";
        int loginStatus = 0; // log success or not， 0 ：success, 1: failed, notice : username or password is wrong
        loginStatus = loginService.validateLogin(userName, password);

        String retView = "";
        if (loginStatus == 1)
        {
            request.getSession().setAttribute("userName", userName);
            retView = "redirect:/index";
        }
        else
        {
            retView = "redirect:/";
            attributes.addFlashAttribute("loginNotice", "用户名或密码错误！");
        }

        return retView;
    }

    @RequestMapping(value = "/login")
    public
    @ResponseBody
    String login(HttpServletRequest request,HttpServletResponse response, @RequestParam(required = true) String userName, @RequestParam(required = true) String password,@RequestParam String remberPassword,RedirectAttributes attributes) throws IOException {
        logger.info("enterring validateLogin");
        logger.info("userName = " + userName + ", password = " + password);

        String loginNotice = "";
        int loginStatus = 0; // log success or not， 0 ：success, 1: failed, notice : username or password is wrong
        if("".equals(userName) || "".equals(password)){//账号或者密码为空
            loginStatus=2;
        }else{
            loginStatus = loginService.validateLogin(userName, password);
        }

        //记住密码
        request.setCharacterEncoding("utf-8");
        String remember = "passcookies";//request.getParameter("passcookies");
        if ("true".equals(remberPassword)) {
            Cookie c1 = new Cookie("username", userName);
            Cookie c2 = new Cookie("password", password);
            Cookie c3 = new Cookie("remberPassword", "checked");
            c1.setMaxAge(3 * 24 * 60 * 60);
            c2.setMaxAge(3 * 24 * 60 * 60);//这里设置保存这条Cookie的时间
            c3.setMaxAge(3 * 24 * 60 * 60);//这里设置保存这条Cookie的时间
            response.addCookie(c1);//添加Cookie
            response.addCookie(c2);
            response.addCookie(c3);
           } else {
            Cookie[] c = request.getCookies();
            for(Cookie cookie:c){
                if(!"JSESSIONID".equals(cookie.getName())){//避免删除登录状态信息
                    cookie.setMaxAge(0);
                    cookie.setValue("");
                    response.addCookie(cookie);
                }
            }
            System.out.println();
        }
        String retView = loginStatus+"";
        if(loginStatus==1){
            request.getSession().setAttribute("userName", userName);
        }


//        if (loginStatus == 1)
//        {
//            request.getSession().setAttribute("userName", userName);
//            retView = "redirect:/subjectInfo";
//        }
//        else if(loginStatus == 2){
//            retView = "redirect:/";
//            attributes.addFlashAttribute("loginNotice", "账号或者密码不能为空！");
//        }
//        else
//        {
//            retView = "redirect:/";
//            attributes.addFlashAttribute("loginNotice", "用户名或密码错误！");
//        }

        return retView;
    }

    @RequestMapping(value = "/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        logger.info("注销session");
        HttpSession session=request.getSession();
        if(session !=null){
          session.invalidate();
        }
        response.sendRedirect("/drsr/");
    }



}
