package cn.csdb.portal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by xiajl on 2018/9/19.
 */
@Controller
public class IndexController {


    @RequestMapping("/")
    public String index(HttpServletRequest request) {
        return "index";
    }


}
