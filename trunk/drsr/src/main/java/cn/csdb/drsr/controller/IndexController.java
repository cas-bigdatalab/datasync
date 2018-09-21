package cn.csdb.drsr.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by xiajl on 2018/9/19.
 */
@Controller
public class IndexController {

    private Logger logger= LoggerFactory.getLogger(IndexController.class);

    @RequestMapping("/")
    public ModelAndView index() {
        logger.debug("进入客户端首页");
        ModelAndView modelAndView = new ModelAndView("index");
        return modelAndView;
    }

}
