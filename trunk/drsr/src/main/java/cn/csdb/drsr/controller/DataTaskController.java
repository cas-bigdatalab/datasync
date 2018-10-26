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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;


/**
 * @program: DataSync
 * @description: 数据任务执行处理控制器
 * @author: xiajl
 * @create: 2018-10-10 10:12
 **/
@Controller
@RequestMapping("/datatask")
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
    @RequestMapping(value="/{id}")
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
    @RequestMapping(value="/getAll")
    public JSONObject getAll(){
        JSONObject jsonObject = new JSONObject();
        List<DataTask> list = dataTaskService.getAllData();
        jsonObject.put("data",list);
        return jsonObject;
    }


    /**
     *
     * Function Description: 数据任务页面跳转
     *
     * @param: []
     * @return: org.springframework.web.servlet.ModelAndView
     * @auther: hw
     * @date: 2018/10/23 14:56
     */
    @RequestMapping("/")
    public ModelAndView datatask() {
        ModelAndView modelAndView = new ModelAndView("datatask");
        return modelAndView;
    }

    /**
     *
     * Function Description: 数据任务展示、查询列表
     *
     * @param: [pageNo, pageSize, datataskType, status]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/24 10:37
     */
    @RequestMapping(value="/list")
    @ResponseBody
    public JSONObject datataskList(@RequestParam(name = "pageNo", defaultValue = "1", required = false) int pageNo,
                                   @RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
                                   @RequestParam(name = "datataskType", required = false) String datataskType,
                                   @RequestParam(name = "status", required = false) String status){
        JSONObject jsonObject = new JSONObject();
        List<DataTask> dataTasks = dataTaskService.getDatataskByPage((pageNo-1)*pageSize,pageSize,datataskType,status);
        jsonObject.put("dataTasks",dataTasks);
        return jsonObject;
    }

    /**
     *
     * Function Description:
     *
     * @param: [id]
     * @return: int >0 删除成功 否则失败
     * @auther: hw
     * @date: 2018/10/24 10:47
     */
    @RequestMapping(value="/delete")
    @ResponseBody
    public int deleteDatatask(String datataskId){
        return dataTaskService.deleteDatataskById(Integer.parseInt(datataskId));
    }

    /**
     *
     * Function Description: 查看数据任务信息
     *
     * @param: [id]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/24 10:54
     */
    @RequestMapping(value="detail")
    @ResponseBody
    public JSONObject datataskDetail(String datataskId){
        JSONObject jsonObject = new JSONObject();
        DataTask datatask = dataTaskService.get(Integer.parseInt(datataskId));
        DataSrc dataSrc = dataSrcService.findById(datatask.getDataSourceId());
        jsonObject.put("datatask",datatask);
        jsonObject.put("dataSrc",dataSrc);
        return jsonObject;
    }

    /**
     *
     * Function Description:关系型数据任务保存
     *
     * @param: []
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/23 10:29
     */
//    @ResponseBody
    @RequestMapping(value="saveRelationDatatask",method = RequestMethod.POST)
    public JSONObject saveRelationDatatask(int dataSourceId,
                                   String dataRelTableList,
                                   @RequestParam(name = "dataRelSqlList", required = false)String dataRelSqlList) {
        JSONObject jsonObject = new JSONObject();
        DataTask datatask = new DataTask();
        datatask.setDataSourceId(dataSourceId);
        datatask.setTableName(dataRelTableList);
        datatask.setSqlString(dataRelSqlList);
        datatask.setCreateTime(new Date());
        datatask.setStatus("0");
        boolean flag = dataTaskService.insertDatatask(datatask);
        jsonObject.put("result",flag);
        if(flag == false){
            return  jsonObject;
        }
        return jsonObject;
    }
}
