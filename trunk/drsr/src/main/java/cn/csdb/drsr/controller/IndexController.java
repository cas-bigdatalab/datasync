package cn.csdb.drsr.controller;

import cn.csdb.drsr.utils.SqlUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;

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

    @RequestMapping("/testsql")
    public String testsql() {
        SqlUtil sqlUtil = new SqlUtil();
        try {
            sqlUtil.importSql();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("123");
        return "123";

    }
}
