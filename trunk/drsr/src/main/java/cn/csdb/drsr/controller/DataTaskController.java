package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.service.DataSrcService;
import cn.csdb.drsr.service.DataTaskService;
import cn.csdb.drsr.utils.PropertiesUtil;
import cn.csdb.drsr.utils.dataSrc.DataSourceFactory;
import cn.csdb.drsr.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.omg.CORBA.DATA_CONVERSION;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;


/**
 * @program: DataSync
 * @description: 数据任务执行处理控制器
 * @author: xiajl
 * @create: 2018-10-10 10:12
 **/
@Controller
public class DataTaskController {
    @Resource
    private DataTaskService dataTaskService;
    @Resource
    private DataSrcService dataSrcService;

    /**
     * Function Description:执行一个数据任务，导出SQL文件后返回执行状态
     *
     * @param:  id: 任务Id
     * @return: 执行结果JsonObject
     * @auther: xiajl
     * @date:   2018/10/18 13:36
     */
    @ResponseBody
    @RequestMapping(value="/task/{id}")
    public JSONObject executeTask(@PathVariable("id") String id){
        JSONObject jsonObject = new JSONObject();
        DataTask dataTask = dataTaskService.get(Integer.parseInt(id));
        jsonObject = dataTaskService.executeTask(dataTask);
        return jsonObject;
    }


    /**
     * Function Description: 获取所有的任务列表信息
     *
     * @param:
     * @return: Json 字符串
     * @auther: xiajl
     * @date:   2018/10/18 13:45
     */
    @ResponseBody
    @RequestMapping(value="/task/getAll")
    public JSONObject getAll(){
        JSONObject jsonObject = new JSONObject();
        List<DataTask> list = dataTaskService.getAllData();
        jsonObject.put("data",list);
        return jsonObject;
    }

}
