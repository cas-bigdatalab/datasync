package cn.csdb.portal.controller;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-12 10:15
 **/
@Controller
public class HttpServiceController {

    @ResponseBody
    @RequestMapping("getDataTask")
    public String getDataTask(JSONObject siteDataTaskJson){

        return "";
    }
}
