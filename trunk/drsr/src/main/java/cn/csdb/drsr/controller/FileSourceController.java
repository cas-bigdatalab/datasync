package cn.csdb.drsr.controller;

import cn.csdb.drsr.model.DataSrc;
import cn.csdb.drsr.service.FileResourceService;
import cn.csdb.drsr.service.RelationShipService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by shiba on 2018/10/8.
 */
@Controller
@RequestMapping("/fileResource")
public class FileSourceController {
    private Logger logger= LoggerFactory.getLogger(FileSourceController.class);
    @Resource
    private FileResourceService fileResourceService;

    @RequestMapping("/deleteData")
    public
    @ResponseBody
    String delete(String dataId) {
        logger.debug("进入删除功能");
        String tag= fileResourceService.deleteRelation(Integer.valueOf(dataId));
        ModelAndView modelAndView = new ModelAndView("relationSource");
        return tag;
    }

    @RequestMapping("/add")
    public
    @ResponseBody
    String add(String dataSourceName,String dataSourceType,String fileType,String filePath) {
        logger.debug("新增功能开始");
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setFileType(fileType);
        datasrc.setFilePath(filePath);
        logger.info("验证新增或编辑的文件路径中的文件是否存在");
        String flag = fileResourceService.testFileIsExist(filePath);
        if(flag!="fileIsNull"){
            return fileResourceService.addData(datasrc);
        }else{
            return "2";
        }
    }

    @RequestMapping("/edit")
    public
    @ResponseBody
    String edit(String dataSourceId, String dataSourceName, String dataSourceType, String fileType, String filePath) {
        logger.debug("编辑功能开始,开始插入");
        DataSrc datasrc = new DataSrc();
        datasrc.setDataSourceName(dataSourceName);
        datasrc.setDataSourceType(dataSourceType);
        datasrc.setFileType(fileType);
        datasrc.setFilePath(filePath);
        datasrc.setDataSourceId(Integer.valueOf(dataSourceId));
        logger.info("验证新增或编辑的文件路径中的文件是否存在");
        String flag = fileResourceService.testFileIsExist(filePath);
        if(flag!="fileIsNull"){
            return fileResourceService.editData(datasrc);
        }else{
            return "2";
        }
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
    public ModelAndView index(HttpServletRequest request,Integer currentPage)
    {
        logger.info("进入文件数据源模块列表页");
        if(currentPage==null){
            currentPage = 1;
        }
        Integer totalPage = fileResourceService.queryTotalPage();
        String totalPageS = String.valueOf(totalPage);
        List<DataSrc> fileDataOfThisPage = fileResourceService.queryPage(currentPage);
        String osName = fileResourceService.testOsName();
        ModelAndView mv = new ModelAndView("fileSource");
        mv.addObject("fileDataOfThisPage", fileDataOfThisPage);
        mv.addObject("totalPage",totalPageS);
        mv.addObject("currentPage", currentPage);
        mv.addObject("osName",osName);
        return mv;
    }
}
