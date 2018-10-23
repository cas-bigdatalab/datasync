package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.service.FileResourceService;
import cn.csdb.drsr.service.RelationShipService;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by shiba on 2018/10/8.
 */
@Controller
@RequestMapping("/fileResource")
public class FileSourceController {
    private Logger logger = LoggerFactory.getLogger(FileSourceController.class);
    @Resource
    private FileResourceService fileResourceService;

    @RequestMapping("/deleteData")
    public
    @ResponseBody
    String delete(String dataId) {
        logger.debug("进入删除功能");
        String tag = fileResourceService.deleteRelation(Integer.valueOf(dataId));
        ModelAndView modelAndView = new ModelAndView("relationSource");
        return tag;
    }

    @RequestMapping("/add")
    public
    @ResponseBody
    String add(String dataSourceName, String dataSourceType, String fileType, String[] data) {
        logger.debug("新增功能开始");
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setFileType(fileType);
        StringBuffer filePath = new StringBuffer("");
        for (String nodeId : data){
            String str = nodeId.replaceAll("%_%","\\\\");
            String str1 = fileResourceService.traversingFiles(str);
            filePath.append(str1);
        }
        datasrc.setFilePath(filePath.toString());
        logger.info("最终拼接的filePath为{}"+filePath.toString());
/*
        String flag = fileResourceService.testFileIsExist(filePath.toString());
*/
            return fileResourceService.addData(datasrc);

    }

    @RequestMapping("/edit")
    public
    @ResponseBody
    String edit(String dataSourceId, String dataSourceName, String dataSourceType,
                String fileType, String[] attr,String[] nodes) {
        logger.debug("编辑功能开始,开始插入");
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setFileType(fileType);
        if(nodes!=null) {
            String nodePath = "";
            for (String nodeId : nodes) {
                String str = nodeId.replaceAll("%_%", "\\\\");
                String str1 = fileResourceService.traversingFiles(str);
                nodePath += str1;
            }
            String[] traversingNodes = nodePath.split(";");
            String[] unionNodes = FileResourceService.union(attr, traversingNodes);
            String filePath = "";
            for (String unionNode : unionNodes) {
                filePath += unionNode.replaceAll("/", "\\\\").replaceAll("\\\\", "%_%") + ";";
            }
            datasrc.setFilePath(filePath);
        }else{
            String filePath = "";
            for (String unionNode : attr) {
                filePath += unionNode.replaceAll("/", "\\\\").replaceAll("\\\\", "%_%") + ";";
            }
            datasrc.setFilePath(filePath);
        }
        datasrc.setDataSourceId(Integer.valueOf(dataSourceId));
        return fileResourceService.editData(datasrc);
    }
    @RequestMapping("/queryData")
    public
    @ResponseBody
    List<DataSrc> queryData(String dataId) {
        logger.debug("编辑功能开始,开始查询");
        List<DataSrc> editData = fileResourceService.editQueryData(Integer.valueOf(dataId));
        return editData;
    }

    @RequestMapping(value = "/index")
    public ModelAndView index(HttpServletRequest request, Integer currentPage) {
        logger.info("进入文件数据源模块列表页");
        if (currentPage == null) {
            currentPage = 1;
        }
        Integer totalPage = fileResourceService.queryTotalPage();
        String totalPageS = String.valueOf(totalPage);
        List<DataSrc> fileDataOfThisPage = fileResourceService.queryPage(currentPage);
        String osName = fileResourceService.testOsName();
        ModelAndView mv = new ModelAndView("fileSource");
        mv.addObject("fileDataOfThisPage", fileDataOfThisPage);
        mv.addObject("totalPage", totalPageS);
        mv.addObject("currentPage", currentPage);
        mv.addObject("osName", osName);
        return mv;
    }

    @RequestMapping("/resCatalogTest")
    public
    @ResponseBody
    List<JSONObject> showResCatalog(String data) {
        logger.info("加载文件树");
        List<JSONObject> jsonObjects = fileResourceService.fileTreeLoading(data);
        return jsonObjects;
    }

    @RequestMapping("/fileSourceabc")
    public
    @ResponseBody
    String fileSource(String[] data){
        for (String nodeId : data){
            nodeId.replace("%_%", "\\\\");
            String str = nodeId.replaceAll("%_%","\\\\");
            fileResourceService.traversingFiles(str);
        }
        return "success";
    }


    /**
     *
     * Function Description: 
     *
     * @param: []
     * @return: java.util.List<cn.csdb.drsr.model.DataSrc>
     * @auther: hw
     * @date: 2018/10/23 10:34
     */
    @RequestMapping(value="findAllFileSrc")
    public @ResponseBody List<DataSrc> findAllFileSrc(){
        return fileResourceService.findAll();
    }


    /**
     *
     * Function Description: 
     *
     * @param: [dataSourceId]
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: hw
     * @date: 2018/10/23 10:06
     */
    @ResponseBody
    @RequestMapping(value="fileSourceFileList")
    public List<JSONObject> fileSourceFileList(int dataSourceId) {

        DataSrc dataSrc = fileResourceService.findById(dataSourceId);
        List<JSONObject> jsonObjects = fileResourceService.fileSourceFileList(dataSrc.getFilePath());
        return jsonObjects;
    }
}
