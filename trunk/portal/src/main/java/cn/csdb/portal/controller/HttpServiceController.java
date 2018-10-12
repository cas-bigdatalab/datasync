package cn.csdb.portal.controller;

import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-12 10:15
 **/
@Controller
@RequestMapping("/service")
public class HttpServiceController {

    @ResponseBody
    @RequestMapping(value = "getDataTask", method = {RequestMethod.POST,RequestMethod.GET})
    public int getDataTask(@RequestBody String dataTaskString){
        JSONObject dataTaskJson = JSONObject.parseObject(dataTaskString);
        System.out.println(dataTaskString);
        return 1;
    }
}
