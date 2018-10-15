package cn.csdb.portal.controller;

import cn.csdb.portal.model.DataTask;
import cn.csdb.portal.model.Site;
import cn.csdb.portal.service.DataTaskService;
import cn.csdb.portal.service.SiteService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private DataTaskService dataTaskService;

    @Autowired
    private SiteService siteService;

    @ResponseBody
    @RequestMapping(value = "getDataTask", method = {RequestMethod.POST,RequestMethod.GET})
    public int getDataTask(@RequestBody String requestString){
        JSONObject requestJson = JSON.parseObject(requestString);
        String siteMarker = requestJson.get("siteMarker").toString();
        String dataTaskString = requestJson.get("dataTask").toString();
        DataTask dataTask = JSON.parseObject(JSONObject.toJSONString(dataTaskString),DataTask.class);
        Integer nullId = null;
        Site site = siteService.getSiteByMarker(siteMarker);
        dataTask.setSiteId(site.getId());
        boolean insertSuccess = dataTaskService.insert(dataTask);
        if(insertSuccess == true){
            return 1;
        }else{
            return 0;
        }

    }
}
