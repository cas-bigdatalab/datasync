package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
public class DataTaskController {
    @Resource
    private DataTaskService dataTaskService;

    @ResponseBody
    @RequestMapping(value="/task/{id}")
    public JSONObject executeTask(@PathVariable("id") String id){
        JSONObject jsonObject = new JSONObject();
        DataTask dataTask = dataTaskService.get(Integer.parseInt(id));
        //IDataSource dataSource = data
        jsonObject.put("result","true");
        return jsonObject;
    }

}
