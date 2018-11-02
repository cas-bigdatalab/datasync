package cn.csdb.portal.controller;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.ResourceService;
import cn.csdb.portal.service.SubjectService;
import cn.csdb.portal.utils.dataSrc.DataSourceFactory;
import cn.csdb.portal.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.sql.Connection;
import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * @program: DataSync
 * @description: Resource Controller class
 * @author: xiajl
 * @create: 2018-10-23 16:32
 **/
@Controller
@RequestMapping("/resource")
public class ResourceController {
    @Resource
    private ResourceService resourceService;

    @Resource
    private SubjectService subjectService;

    private Logger logger = LoggerFactory.getLogger(ResourceController.class);

    @RequestMapping("/list")
    public String list(HttpServletRequest request, Model model) {
        logger.info("进入资源列表页面");
        return "resource";
    }


    /**
     * Function Description: 取得资源分页数据
     *
     * @param:
     * @return: 资源列表
     * @auther: Administrator
     * @date: 2018/10/25 16:46
     */

    @ResponseBody
    @RequestMapping("/getPageData")
    public JSONObject getPageData(HttpServletRequest request, @RequestParam(value = "subjectCode", required = false) String subjectCode,
                                  @RequestParam(value = "title", required = false) String title,
                                  @RequestParam(value = "publicType", required = false) String publicType,
                                  @RequestParam(value = "status", required = false) String status,
                                  @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
                                  @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {

        List<cn.csdb.portal.model.Resource> list = resourceService.getListByPage(subjectCode, title, publicType, status, pageNo, pageSize);
        long count = resourceService.countByPage(subjectCode, title, publicType, status);
        JSONObject json = new JSONObject();
        json.put("list", list);
        json.put("totalCount", count);
        json.put("currentPage", pageNo);
        json.put("pageSize", pageSize);
        json.put("totalPages", count % pageSize == 0 ? count / pageSize : count / pageSize + 1);
        return json;
    }


    /**
     * Function Description: 删除一条资源记录
     *
     * @param: id
     * @return: JSONObject
     * @auther: Administrator
     * @date: 2018/10/25 16:47
     */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject delete(@PathVariable("id") String id) {
        JSONObject jsonObject = new JSONObject();
        resourceService.delete(id);
        jsonObject.put("result", "ok");
        return jsonObject;
    }



    /*---------------------------------------------------------------------------------------------*/

    /**
     * Function Description: 资源注册页面跳转
     *
     * @param: []
     * @return: java.lang.String
     * @auther: hw
     * @date: 2018/11/1 9:48
     */
    @RequestMapping(value = "addResource")
    public String resourceAdd() {
        return "addResource";
    }

    /**
     * Function Description: 获得mysql数据库表单
     *
     * @param: []
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/1 10:36
     */
    @RequestMapping(value = "relationalDatabaseTableList")
    public JSONObject relationalDatabaseTableList() {
        Subject subject = subjectService.findBySubjectCode("sdc002");
        JSONObject jsonObject = new JSONObject();
        IDataSource dataSource = DataSourceFactory.getDataSource("mysql");
        Connection connection = dataSource.getConnection(subject.getDbHost(), subject.getDbPort(),
                subject.getDbUserName(), subject.getDbPassword(), subject.getDbName());
        if (connection == null)
            return null;
        List<String> list = dataSource.getTableList(connection);
        jsonObject.put("list", list);
//        jsonObject.put("dataSourceName", dataSrc.getDataSourceName());
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping(value="getCheckedTables")
    public JSONObject getCheckedTables(@RequestParam(name = "resourceId")String resourceId){
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        return jsonObject;
    }


    /**
     * Function Description: 获取砖题库文件列表
     *
     * @param: []
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: hw
     * @date: 2018/11/1 10:43
     */
    @ResponseBody
    @RequestMapping(value = "fileSourceFileList")
    public List<JSONObject> fileSourceFileList() {
        Subject subject = subjectService.findBySubjectCode("sdc002");
        List<JSONObject> jsonObjects = resourceService.fileSourceFileList(subject.getFtpFilePath());
        return jsonObjects;
    }


    /**
     * Function Description: 获得文件树节点下的文件结构
     *
     * @param: [filePath]
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: hw
     * @date: 2018/11/1 10:58
     */
    @ResponseBody
    @RequestMapping(value = "treeNode")
    public List<JSONObject> treeNode(String filePath) {
        List<JSONObject> jsonObjects = null;
        jsonObjects = resourceService.fileSourceFileList(filePath.replace("%_%", "\\"));
        return jsonObjects;
    }


    /**
     *
     * Function Description: 添加资源第一步保存
     *
     * @param: [title, imagePath, introduction, keyword, catalogId, createdByOrganization]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/1 15:46
     */
    @ResponseBody
    @RequestMapping(value = "addResourceFirstStep")
    public JSONObject saveResourceFirstStep(@RequestParam(name = "title")String title,
                                            @RequestParam(name = "imagePath",required = false)String imagePath,
                                            @RequestParam(name = "introduction")String introduction,
                                            @RequestParam(name = "keyword")String keyword,
                                            @RequestParam(name = "catalogId")String catalogId,
                                            @RequestParam(name = "createdByOrganization")String createdByOrganization) {
        Subject subject = subjectService.findBySubjectCode("sdc002");
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = new cn.csdb.portal.model.Resource();
        resource.setTitle(title);
        resource.setImagePath(imagePath);
        resource.setIntroduction(introduction);
        resource.setKeyword(keyword);
        resource.setCatalogId(catalogId);
        resource.setCreatedByOrganization(createdByOrganization);
        resource.setSubjectCode(subject.getSubjectCode());
        resource.setResState("未完成");
        resource.setCreationDate(new Date());
        resource.setUpdateDate(new Date());
        String resourceId = resourceService.save(resource);
        jsonObject.put("resourceId",resourceId);
        return jsonObject;
    }


    /**
     *
     * Function Description: 添加资源第二步保存
     *
     * @param: [resourceId, publicType, dataList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 10:45
     */
    @ResponseBody
    @RequestMapping(value = "addResourceSecondStep")
    public JSONObject addResourceSecondStep(@RequestParam(name = "resourceId")String resourceId,
                                            @RequestParam(name = "publicType")String publicType,
                                            @RequestParam(name = "dataList")String dataList) {
        Subject subject = subjectService.findBySubjectCode("sdc002");
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setPublicType(publicType);
        if(publicType.equals("mysql")){
            resource.setPublicContent(dataList);
            resource.setToFilesNumber(0);
        }else if(publicType.equals("file")){
            StringBuffer sb = new StringBuffer();
            long size = 0L;
            if(StringUtils.isNoneBlank(dataList)){
                String[] s = dataList.split(";");
                for(String str : s){
                    str = str.replaceAll("%_%", "/");
                    File file = new File(str);
                    if (file.isDirectory()) {
                        Collection<File> files = FileUtils.listFiles(file, null, true);
                        for (File file1 : files) {
                            String fp = file1.getPath();
                            size += file1.length();
                            if (fp.indexOf("\\") > -1) {
                                fp = fp.replaceAll("\\\\", "/");
                            }
                            sb.append(fp+";");
                        }
                    }
                }
            }
            resource.setFilePath(sb.toString().replace("/","%_%"));
            resource.setToMemorySize(String.valueOf(size));
        }
        resourceService.save(resource);
        return jsonObject;
    }


    /**
     *
     * Function Description: 添加资源第三步保存
     *
     * @param: [resourceId, userGroupIdList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 11:19
     */
  /*  @ResponseBody
    @RequestMapping(value = "addResourceSecondStep")
    public JSONObject addResourceSecondStep(@RequestParam(name = "resourceId")String resourceId,
                                            @RequestParam(name = "userGroupIdList")String userGroupIdList){
        Subject subject = subjectService.findBySubjectCode("sdc002");
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setUserGroupId(userGroupIdList);
        return jsonObject;
    }*/




}
