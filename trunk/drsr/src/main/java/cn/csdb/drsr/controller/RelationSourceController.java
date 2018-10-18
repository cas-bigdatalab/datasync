package cn.csdb.drsr.controller;

import cn.csdb.drsr.service.RelationShipService;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import cn.csdb.drsr.model.DataSrc;
import org.springframework.beans.factory.annotation.Autowired;
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

        String flag = relationShipService.testCon(host,port,userName,"",dataBaseName);

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

        String flag = relationShipService.testCon(host,port,userName,"",dataBaseName);

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
}
