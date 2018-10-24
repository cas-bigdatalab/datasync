package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.TableInfo;
import cn.csdb.drsr.model.TableInfoR;
import cn.csdb.drsr.service.RelationShipService;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.google.common.collect.Maps;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import cn.csdb.drsr.model.DataSrc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.management.relation.RelationService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by shiba on 2018/10/8.
 */
@Controller
@RequestMapping("/relationship")
public class RelationSourceController {
    private Logger logger= LoggerFactory.getLogger(RelationSourceController.class);
    @Resource
    private RelationShipService relationShipService;
    @RequestMapping("/index")
    public ModelAndView index() {
       /* logger.debug("进入关系数据库模块");
        List<DataSrc> queryData = relationShipService.queryData();
        ModelAndView modelAndView = new ModelAndView("relationSource");
        modelAndView.addObject("queryData",queryData);*/
        logger.debug("进入关系数据库模块");
        ModelAndView modelAndView = new ModelAndView("dataResourceRegister");
        return modelAndView;
    }

    @RequestMapping("/deleteData")
    public
    @ResponseBody
    String delete(String dataId) {
        logger.debug("进入删除功能");
        String tag= relationShipService.deleteRelation(Integer.valueOf(dataId));
        return tag;
    }

    @RequestMapping("/add")
    public
    @ResponseBody
    String add(String dataSourceName,String dataSourceType,String dataBaseName,String dataBaseType, String host,
               String port, String userName, String password) {
        logger.debug("新增功能开始");
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setDatabaseName(dataBaseName);
        datasrc.setDatabaseType(dataBaseType);
        datasrc.setHost(host);
        datasrc.setPort(port);
        datasrc.setUserName(userName);
        datasrc.setPassword(password);
        logger.info("测试新增或编辑的数据能否连通数据库");

        String flag = relationShipService.testCon(host,port,userName,password,dataBaseName);

        if(flag=="success"){
            return relationShipService.addData(datasrc);
        }else{
            return "2";
        }
    }

    @RequestMapping("/edit")
    public
    @ResponseBody
    String edit(String dataSourceName,String dataSourceType,String dataBaseName,String dataBaseType, String host,
               String port, String userName, String password,String dataSourceId) {
        logger.debug("编辑功能开始,开始插入");
        DataSrc datasrc = new DataSrc();
        int dataSourceId1 =Integer.valueOf(dataSourceId);
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setDatabaseName(dataBaseName);
        datasrc.setDatabaseType(dataBaseType);
        datasrc.setHost(host);
        datasrc.setPort(port);
        datasrc.setUserName(userName);
        datasrc.setPassword(password);
        datasrc.setDataSourceId(dataSourceId1);
        logger.info("测试新增或编辑的数据能否连通数据库");

        String flag = relationShipService.testCon(host,port,userName,password,dataBaseName);

        if(flag=="success"){
            return relationShipService.editData(datasrc);
        }else{
            return "2";
        }

    }

    @RequestMapping("/queryData")
    public
    @ResponseBody
    List<DataSrc> queryData(String dataId) {
        logger.debug("编辑功能开始,开始查询");
        List<DataSrc> editData = relationShipService.editQueryData(3);/*Integer.valueOf(dataId)*/
        return editData;
    }

    @RequestMapping(value = "/indexTest")
    public ModelAndView indexTest(HttpServletRequest request,Integer currentPage)
    {
        logger.info("进入关系数据源模块列表页");
        if(currentPage==null){
            currentPage = 1;
        }
        Integer totalPage = relationShipService.queryTotalPage();
        String totalPageS = String.valueOf(totalPage);
        List<DataSrc> relationDataOfThisPage = relationShipService.queryPage(currentPage);
        ModelAndView mv = new ModelAndView("relationSource");
        mv.addObject("relationDataOfThisPage", relationDataOfThisPage);
        mv.addObject("totalPage",totalPageS);
        mv.addObject("currentPage", currentPage);
        return mv;
    }



    /**
     *
     * Function Description: 
     *
     * @param: []
     * @return: java.util.List<cn.csdb.drsr.model.DataSrc>
     * @auther: hw
     * @date: 2018/10/22 17:59
     */
    @RequestMapping(value="findAllDBSrc")
    public @ResponseBody List<DataSrc> findAllDBSrc(){
        return relationShipService.findAll();
    }

    /**
     *
     * Function Description: 
     *
     * @param: [dataSourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/22 17:59
     */
    @ResponseBody
    @RequestMapping(value="relationalDatabaseTableList")
    public JSONObject relationalDatabaseTableList(int dataSourceId){
        JSONObject jsonObject = new JSONObject();
        DataSrc dataSrc = relationShipService.findById(dataSourceId);
        List<String> list = relationShipService.relationalDatabaseTableList(dataSrc);
        jsonObject.put("list",list);
        jsonObject.put("dataSourceName",dataSrc.getDataSourceName());
        return jsonObject;
    }

    /**
     *
     * Function Description:
     *
     * @param: []
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/23 10:29
     */
    @ResponseBody
    @RequestMapping(value="saveDatatask",method = RequestMethod.POST)
    public JSONObject saveDatatask() {
        JSONObject jsonObject = new JSONObject();
        return jsonObject;
    }

    /**
     *
     * Function Description: preview RelationalDatabase By TableName
     *
     * @param: [dataSourceId, tableInfosListStr, pageSize]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/23 10:29
     */
    @ResponseBody
    @RequestMapping(value = "/previewRelationalDatabaseByTableName")
    public JSONObject previewRelationalDatabaseByTableName(
            @RequestParam(required = false) String dataSourceId,
            @RequestParam(required = false, name = "tableInfosList") String tableInfosListStr,
            @RequestParam(required = false, defaultValue = "10") int pageSize) {
        logger.info("预览表数据");
        JSONObject jsonObject = new JSONObject();
        List<TableInfoR> tableInfosList = JSON.parseArray(tableInfosListStr, TableInfoR.class);
        HashMap<String, List<TableInfo>> maps = Maps.newHashMap();
        String tableName = null;
        if (tableInfosList != null && tableInfosList.size() == 1) {
            tableName = tableInfosList.get(0).getTableName();
            maps.put(tableName, tableInfosList.get(0).getTableInfos());
        } else {
            return jsonObject;
        }
        List<List<Object>> datas = relationShipService.getDataByTable(tableName, maps, Integer.valueOf(dataSourceId), 0, pageSize);
        jsonObject.put("datas", datas);
        return jsonObject;
    }

    /**
     *
     * Function Description: preview RelationalDatabase By SQL
     *
     * @param: [dataSourceId, sqlStr, tableInfosListStr, pageSize]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/10/23 10:29
     */
    @ResponseBody
    @RequestMapping(value = "/previewRelationalDatabaseBySQL")
    public JSONObject previewRelationalDatabaseBySQL(
            @RequestParam(required = false) String dataSourceId,
            @RequestParam() String sqlStr,
//            @RequestParam(required = false, name = "tableInfosList") String tableInfosListStr,
            @RequestParam(required = false, defaultValue = "10") int pageSize) {
        logger.info("预览表数据");
        JSONObject jsonObject = new JSONObject();
//        List<TableInfoR> tableInfosList = JSON.parseArray(tableInfosListStr, TableInfoR.class);
        Map<String, List<TableInfo>> maps = relationShipService.getDefaultFieldComsBySql(Integer.parseInt(dataSourceId),sqlStr);
//        if (tableInfosList != null && tableInfosList.size() >= 1) {
//            String tableName = null;
//            for (TableInfoR tableInfoR : tableInfosList) {
//                tableName = tableInfoR.getTableName();
//                maps.put(tableName, tableInfoR.getTableInfos());
//            }
//        } else {
//            return jsonObject;
//        }
        List<List<Object>> datas = relationShipService.getDataBySql(sqlStr, maps, Integer.valueOf(dataSourceId), 0, pageSize);
        jsonObject.put("datas", datas);
        return jsonObject;
    }

    /*@ResponseBody
    @RequestMapping(value = "/previewRelationalDatabaseByTableName")
    public JSONObject previewRelationalDatabaseByTableName(
            @RequestParam(required = false) String dataSourceId,
            @RequestParam(required = false, name = "tableInfosList") String tableInfosListStr,
            @RequestParam(required = false, defaultValue = "10") int pageSize) {
        logger.info("预览表数据");
        JSONObject jsonObject = new JSONObject();
        List<TableInfoR> tableInfosList = JSON.parseArray(tableInfosListStr, TableInfoR.class);
        HashMap<String, List<TableInfo>> maps = Maps.newHashMap();
        String tableName = null;
        if (tableInfosList != null && tableInfosList.size() == 1) {
            tableName = tableInfosList.get(0).getTableName();
            maps.put(tableName, tableInfosList.get(0).getTableInfos());
        } else {
            return jsonObject;
        }
        List<List<Object>> datas = dataRMDBservice.getDataByTable(tableName, maps, Integer.valueOf(dataSourceId), 0, pageSize);
        jsonObject.put("datas", datas);
        return jsonObject;
    }*/
}
