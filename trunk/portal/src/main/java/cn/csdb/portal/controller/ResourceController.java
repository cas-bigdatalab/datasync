package cn.csdb.portal.controller;

import cn.csdb.portal.model.*;
import cn.csdb.portal.repository.TableFieldComsDao;
import cn.csdb.portal.service.*;
import cn.csdb.portal.utils.FileTreeNode;
import cn.csdb.portal.utils.FileUploadUtil;
import cn.csdb.portal.utils.dataSrc.DataSourceFactory;
import cn.csdb.portal.utils.dataSrc.IDataSource;
import com.alibaba.fastjson.JSONObject;
import com.google.common.base.Strings;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.NumberFormat;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.*;

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
    private ResCatalogService resCatalogService;
    @Resource
    private GroupService groupService;

    @Resource
    private SubjectService subjectService;
    @Resource
    private AuditMessageService auditMessageService;
    @Resource
    private DataSrcService dataSrcService;
    @Resource
    private TableFieldComsDao tableFieldComsDao;
    @Resource
    private MetadataTemplateService metadataTemplateService;
    @Resource
    private MetaTemplateService metaTemplateService;

    @Value("#{systemPro['imagesPath']}")
    private String imagesPath;

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
    public JSONObject getPageData(/*@RequestParam(value = "subjectCode", required = false) String subjectCode,*/
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "publicType", required = false) String publicType,
            @RequestParam(value = "status", required = false) String resState,
            @RequestParam(value = "pageNo", defaultValue = "1") int pageNo,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize,
            HttpSession session) {
        String subjectCode = "";
        Set<String> roles = (HashSet<String>) (session.getAttribute("roles"));
        if (roles.contains("系统管理员")) {
            subjectCode = "";
        } else {
            subjectCode = session.getAttribute("SubjectCode").toString();
            Subject subject = subjectService.findBySubjectCode(subjectCode);
        }
        List<cn.csdb.portal.model.Resource> list = resourceService.getListByPage(subjectCode, title, publicType, resState, pageNo, pageSize);
        long count = resourceService.countByPage(subjectCode, title, publicType, resState);
        JSONObject json = new JSONObject();
        json.put("resourceList", list);
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

    @RequestMapping(value = "editResource")
    public ModelAndView resourceEdit(String resourceId, Model model) {
        ModelAndView mv = new ModelAndView("dataEditResource");
        mv.addObject("resourceId", resourceId);
        List<MetadataTemplate> list = metadataTemplateService.getAll();
        model.addAttribute("list", list);
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        List<Map<String, Object>> metadataList = resource.getExtMetadata();
        model.addAttribute("metadataList", metadataList);
        return mv;
    }

    /**
     * Function Description: 获得mysql数据库表单
     *
     * @param: []
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/1 10:36
     */
    @ResponseBody
    @RequestMapping(value = "relationalDatabaseTableList")
    public JSONObject relationalDatabaseTableList(HttpSession session) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        IDataSource dataSource = DataSourceFactory.getDataSource("mysql");
        Connection connection = null;
        try {
            connection = dataSource.getConnection(subject.getDbHost(), subject.getDbPort(),
                    subject.getDbUserName(), subject.getDbPassword(), subject.getDbName());
            if (connection == null)
                return null;
            List<String> list = new ArrayList<>(10);
            List<Described_Table> list_describe = tableFieldComsDao.queryDescribeTable(subject.getDbName());
            for (Described_Table described_table : list_describe) {
                list.add(described_table.getTableName());
            }
            jsonObject.put("list", list);
//        jsonObject.put("dataSourceName", dataSrc.getDataSourceName());
            return jsonObject;
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    logger.error("数据库连接关闭异常");
                }
            }
        }
    }

    /**
     * Function Description: 获得已经选择的数据库表list
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 13:55
     */
    @ResponseBody
    @RequestMapping(value = "getCheckedTables")
    public JSONObject getCheckedTables(@RequestParam(name = "resourceId") String resourceId) {
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        String tableList = resource.getPublicContent();
        jsonObject.put("tableList", tableList);
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
    public List<JSONObject> fileSourceFileList(HttpSession session) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        List<JSONObject> jsonObjects = resourceService.fileSourceFileListFirst(subject.getFtpFilePath());
        return jsonObjects;
    }

    /**
     * Function Description: 获得已经选择文件list
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:23
     */
    @ResponseBody
    @RequestMapping(value = "getCheckedFiles")
    public JSONObject getCheckedFiles(@RequestParam(name = "resourceId") String resourceId) {
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        String fileList = resource.getFilePath();
        jsonObject.put("fileList", fileList);
        return jsonObject;
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
        System.out.println("进入treeNode方法！");
        List<JSONObject> jsonObjects = null;
        String separator = File.separator;
        if (separator.equals("\\")) {
            filePath = filePath.replace("%_%", "\\");
        } else {
            filePath = filePath.replace("%_%", "/");
        }
        jsonObjects = resourceService.fileSourceFileList(filePath);
        return jsonObjects;
    }

    /**
     * Function Description: 获得文件树节点下第一层的文件结构
     *
     * @param: [filePath]
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: shibaoping
     * @date: 2018/11/1 10:58
     */
    @ResponseBody
    @RequestMapping(value = "treeNodeFirst")
    public List<JSONObject> treeNodeFirst(String filePath) {
        List<JSONObject> jsonObjects = null;
//        jsonObjects = resourceService.fileSourceFileListFirst(filePath.replace("%_%", "\\"));
        jsonObjects = resourceService.treeNodeFirst(filePath.replace("%_%", "\\"), 2);
        return jsonObjects;
    }

    /**
     * Function Description: 添加资源第一步保存
     *
     * @param: [title, imagePath, introduction, keyword, catalogId, createdByOrganization]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/1 15:46
     */
    @ResponseBody
    @RequestMapping(value = "addResourceFirstStep")
    public JSONObject saveResourceFirstStep(HttpSession session,
                                            @RequestParam(name = "title") String title,
                                            @RequestParam(name = "imagePath", required = false) String imagePath,
                                            @RequestParam(name = "introduction") String introduction,
                                            @RequestParam(name = "keyword") String keyword,
                                            @RequestParam(name = "catalogId") String catalogId,
                                            @RequestParam(name = "createdByOrganization") String createdByOrganization,
                                            @RequestParam(name = "startTime") String startTime,
                                            @RequestParam(name = "endTime") String endTime,
                                            @RequestParam(name = "email") String email,
                                            @RequestParam(name = "phoneNum") String phoneNum,
                                            @RequestParam(name = "createTime") String createTime,
                                            @RequestParam(name = "publishOrganization") String publishOrganization,
                                            @RequestParam(name = "createOrganization") String createOrganization,
                                            @RequestParam(name = "createPerson") String createPerson,
                                            @RequestParam(name = "extMetadata") String extMetadata,
                                            @RequestParam(name = "metaTemplateName", required = false) String metaTemplateName,
                                            @RequestParam(name = "memo", required = false) String memo,
                                            @RequestParam(name = "isTemplate", required = false) String isTemplate
    ) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = new cn.csdb.portal.model.Resource();
        resource.setTitle(title);
        resource.setImagePath(imagePath);
        resource.setIntroduction(introduction);
        resource.setKeyword(keyword);
        resource.setCatalogId(catalogId);
        resource.setCreatedByOrganization(createdByOrganization);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        ParsePosition pos1 = new ParsePosition(0);
        ParsePosition pos2 = new ParsePosition(0);
        ParsePosition pos3 = new ParsePosition(0);
        Date startDate = formatter.parse(startTime, pos1);
        Date endDate = formatter.parse(endTime, pos2);
        Date createDate = formatter.parse(createTime, pos3);
        resource.setStartTime(startDate);
        resource.setEndTime(endDate);
        resource.setCreatorCreateTime(createDate);
        resource.setCreateTime(new Date());
        resource.setEmail(email);
        resource.setPhoneNum(phoneNum);
        resource.setSubjectCode(subject.getSubjectCode());
//        resource.setResState("未完成");
        resource.setCreationDate(new Date());
        resource.setUpdateDate(new Date());
        resource.setPublishOrgnization(publishOrganization);
        resource.setCreateOrgnization(createOrganization);
        resource.setCreatePerson(createPerson);
        resource.setStatus("-1");
        resource.setdCount(0);
        resource.setvCount(0);
        System.out.println(extMetadata);
        List<Map<String, Object>> list = new ArrayList<>();
        if (StringUtils.isNotEmpty(extMetadata)) {
            JSONObject json = JSONObject.parseObject(extMetadata);
            for (Map.Entry<String, Object> map : json.entrySet()) {
                Map<String, Object> item = new HashMap<>();
                item.put(map.getKey(), map.getValue());
                list.add(item);
            }
            resource.setExtMetadata(list);
        }

        //xiajl20190424增加创建元数据模板信息
        System.out.println(isTemplate);
        if ("true".equals(isTemplate)) {
            MetaTemplate metaTemplate = new MetaTemplate();
            metaTemplate.setMetaTemplateName(metaTemplateName);
            metaTemplate.setMemo(memo);
            metaTemplate.setMetaTemplateCreator(session.getAttribute("userName").toString());
            metaTemplate.setMetaTemplateCreateDate(new Date());
            metaTemplate.setSubjectCode(subjectCode);

            metaTemplate.setTitle(title);
            metaTemplate.setIntroduction(introduction);
            metaTemplate.setImagePath(imagePath);
            metaTemplate.setKeyword(keyword);
            metaTemplate.setCatalogId(catalogId);
            metaTemplate.setStartTime(startDate);
            metaTemplate.setEndTime(endDate);
            metaTemplate.setCreatedByOrganization(createdByOrganization);
            metaTemplate.setCreateOrgnization(createOrganization);
            metaTemplate.setCreatePerson(createPerson);
            metaTemplate.setCreatorCreateTime(createDate);
            metaTemplate.setPublishOrgnization(publishOrganization);
            metaTemplate.setEmail(email);
            metaTemplate.setPhoneNum(phoneNum);
            if (list.size() > 0) {
                metaTemplate.setExtMetadata(list);
            }
            metaTemplateService.add(metaTemplate);

        }

        String resourceId = resourceService.save(resource);
        jsonObject.put("resourceId", resourceId);
        return jsonObject;
    }


    /**
     * Function Description: 添加资源第二步保存
     *
     * @param session          获取当前节点编码
     * @param resourceDataList 序列化参数
     */
    @RequestMapping("/addResourceSecondStep")
    @ResponseBody
    public JSONObject addResourceSecondStep(HttpSession session, resourceDataList resourceDataList) {
        JSONObject jsonObject = new JSONObject();
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceDataList.getResourceId());

        String sqlDataListString = resourceDataList.getSqlDataList();
        boolean sqlDataListIsNullOrEmpty = Strings.isNullOrEmpty(sqlDataListString);
        String fileDataListString = resourceDataList.getFileDataList();
        boolean fileDataListIsNullOrEmpty = Strings.isNullOrEmpty(fileDataListString);
        BigDecimal memorySize = new BigDecimal(0);

        if (!sqlDataListIsNullOrEmpty) {
            resource.setPublicContent(sqlDataListString);
            List<String> sqlDataList = Arrays.asList(sqlDataListString.split(";"));

            BigDecimal allTableLength = new BigDecimal(0);
            for (String tableName : sqlDataList) {
                BigDecimal tableLength = resourceService.getTableLength(subject, tableName);
                allTableLength = allTableLength.add(tableLength);
            }
            memorySize = memorySize.add(allTableLength);

            BigDecimal allTableRow = new BigDecimal(0);
            for (String tableName : sqlDataList) {
                BigDecimal tableRow = resourceService.getTableRow(subject, tableName);
                allTableRow = allTableRow.add(tableRow);
            }
            resource.setToRecordNumber(allTableRow.longValue());
        } else {
            resource.setPublicContent("");
        }

        if (!fileDataListIsNullOrEmpty) {
            resource.setFilePath(fileDataListString);
            List<String> filePathList = Arrays.asList(fileDataListString.split(";"));
            BigDecimal allFileLength = new BigDecimal(0);
            int fileNumber = 0;
            for (String filepath : filePathList) {
                BigDecimal fileLength = resourceService.getFileLength(subject, filepath);
                allFileLength = allFileLength.add(fileLength);
                if (!Objects.equals(fileLength.intValue(), 0)) {
                    fileNumber++;
                }
            }
            memorySize = memorySize.add(allFileLength);
            resource.setToFilesNumber(fileNumber);
        } else {
            resource.setFilePath("");
        }

        resource.setToMemorySize(memorySize.toString());
        if (!sqlDataListIsNullOrEmpty && !fileDataListIsNullOrEmpty) {
            resource.setPublicType("RDB+FILE");
        } else if (!sqlDataListIsNullOrEmpty && fileDataListIsNullOrEmpty) {
            resource.setPublicType("RDB");
            resource.setToFilesNumber(0);
        } else if (sqlDataListIsNullOrEmpty && !fileDataListIsNullOrEmpty) {
            resource.setPublicType("FILE");
            resource.setToRecordNumber(0);
        }

        resource.setStatus("1");
        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);

        return jsonObject;
    }

    /**
     * Function Description: 添加资源第三步保存
     *
     * @param: [resourceId, userGroupIdList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 11:19
     */
    @ResponseBody
    @RequestMapping(value = "addResourceThirdStep")
    public JSONObject addResourceThirdStep(HttpSession session,
                                           @RequestParam(name = "resourceId") String resourceId,
                                           @RequestParam(name = "userGroupIdList") String userGroupIdList) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setUserGroupId(userGroupIdList);
        resource.setStatus("1");
        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }

    /**
     * Function Description: 通过id获得resource
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:26
     */
    @ResponseBody
    @RequestMapping(value = "getResourceById")
    public JSONObject getResourceById(@RequestParam(name = "resourceId") String resourceId) {
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        jsonObject.put("resource", resource);
        jsonObject.put("metadataList", resource.getExtMetadata());
        return jsonObject;
    }

    /**
     * Function Description: 编辑资源保存第一步
     *
     * @param: [resourceId, title, imagePath, introduction, keyword, catalogId, createdByOrganization]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:51
     */
    @ResponseBody
    @RequestMapping(value = "editResourceFirstStep")
    public JSONObject editResourceFirstStep(HttpSession session,
                                            @RequestParam(name = "resourceId") String resourceId,
                                            @RequestParam(name = "title") String title,
                                            @RequestParam(name = "imagePath", required = false) String imagePath,
                                            @RequestParam(name = "introduction") String introduction,
                                            @RequestParam(name = "keyword") String keyword,
                                            @RequestParam(name = "catalogId") String catalogId,
                                            @RequestParam(name = "createdByOrganization") String createdByOrganization,
                                            @RequestParam(name = "startTime") String startTime,
                                            @RequestParam(name = "endTime") String endTime,
                                            @RequestParam(name = "email") String email,
                                            @RequestParam(name = "phoneNum") String phoneNum,
                                            @RequestParam(name = "creatorCreateTimeString") String creatorCreateTimeString,
                                            @RequestParam(name = "publishOrganization") String publishOrganization,
                                            @RequestParam(name = "createOrganization") String createOrganization,
                                            @RequestParam(name = "createPerson") String createPerson,
                                            @RequestParam(name = "extMetadata") String extMetadata,
                                            @RequestParam(name = "metaTemplateName", required = false) String metaTemplateName,
                                            @RequestParam(name = "memo", required = false) String memo,
                                            @RequestParam(name = "isTemplate", required = false) String isTemplate) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setTitle(title);
        String oldImagePath = resource.getImagePath();
        if (!Strings.isNullOrEmpty(imagePath)) {
            if (imagePath.equals(oldImagePath)) {
                resource.setImagePath(oldImagePath);
            } else {
                File f = new File(oldImagePath);
                f.delete();
                resource.setImagePath(imagePath);
            }
        }

        resource.setIntroduction(introduction);
        resource.setKeyword(keyword);
        resource.setCatalogId(catalogId);
        resource.setCreatedByOrganization(createdByOrganization);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        ParsePosition pos1 = new ParsePosition(0);
        ParsePosition pos2 = new ParsePosition(0);
        ParsePosition pos3 = new ParsePosition(0);
        Date startDate = formatter.parse(startTime, pos1);
        Date endDate = formatter.parse(endTime, pos2);
        Date creatorCreateTime = formatter.parse(creatorCreateTimeString, pos3);
        resource.setStartTime(startDate);
        resource.setEndTime(endDate);
        resource.setCreatorCreateTime(creatorCreateTime);
        resource.setCreateTime(new Date());
        resource.setEmail(email);
        resource.setPhoneNum(phoneNum);
        resource.setSubjectCode(subject.getSubjectCode());
//        resource.setResState("未完成");
        resource.setUpdateDate(new Date());
        resource.setPublishOrgnization(publishOrganization);
        resource.setCreateOrgnization(createOrganization);
        resource.setCreatePerson(createPerson);
        if (StringUtils.isNotBlank(resource.getToMemorySize())) {
            resource.setStatus("1");
        } else {
            resource.setStatus("-1");
        }

        //xiajl20190310 增加
        System.out.println(extMetadata);
        List<Map<String, Object>> list = new ArrayList<>();
        if (StringUtils.isNotEmpty(extMetadata)) {
            JSONObject json = JSONObject.parseObject(extMetadata);
            for (Map.Entry<String, Object> map : json.entrySet()) {
                Map<String, Object> item = new HashMap<>();
                item.put(map.getKey(), map.getValue());
                list.add(item);
            }
            resource.setExtMetadata(list);
        }

        //添加模板
        if ("true".equals(isTemplate)) {
            MetaTemplate metaTemplate = new MetaTemplate();
            metaTemplate.setMetaTemplateName(metaTemplateName);
            metaTemplate.setMemo(memo);
            metaTemplate.setMetaTemplateCreator(session.getAttribute("userName").toString());
            metaTemplate.setMetaTemplateCreateDate(new Date());
            metaTemplate.setSubjectCode(subjectCode);

            metaTemplate.setTitle(title);
            metaTemplate.setIntroduction(introduction);
            metaTemplate.setImagePath(imagePath);
            metaTemplate.setKeyword(keyword);
            metaTemplate.setCatalogId(catalogId);
            metaTemplate.setStartTime(startDate);
            metaTemplate.setEndTime(endDate);
            metaTemplate.setCreatedByOrganization(createdByOrganization);
            metaTemplate.setCreateOrgnization(createOrganization);
            metaTemplate.setCreatePerson(createPerson);
            metaTemplate.setCreatorCreateTime(creatorCreateTime);
            metaTemplate.setPublishOrgnization(publishOrganization);
            metaTemplate.setEmail(email);
            metaTemplate.setPhoneNum(phoneNum);
            if (list.size() > 0) {
                metaTemplate.setExtMetadata(list);
            }
            metaTemplateService.add(metaTemplate);

        }

        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }

    /**
     * Function Description: 编辑资源保存第二步
     *
     * @param: [resourceId, publicType, dataList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:52
     */
    @ResponseBody
    @RequestMapping(value = "editResourceSecondStep")
    public JSONObject editResourceSecondStep(HttpSession session,
                                             @RequestParam(name = "resourceId") String resourceId,
                                             @RequestParam(name = "publicType") String publicType,
                                             @RequestParam(name = "dataList") String dataList) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        if (publicType.equals("mysql")) {
            resource.setPublicContent(dataList);
            resource.setToFilesNumber(0);
            resource.setPublicType("mysql");
            List<String> tableList = Arrays.asList(dataList.split(";"));
            int rowCount = resourceService.getRecordCount(subject.getDbHost(), subject.getDbPort(), subject.getDbUserName(), subject.getDbPassword(), subject.getDbName(), tableList);
            resource.setToRecordNumber(rowCount);
        } else if (publicType.equals("file")) {
            resource.setPublicType("file");
            StringBuffer sb = new StringBuffer();
            Double size = 0.00;
            if (StringUtils.isNoneBlank(dataList)) {
                String[] s = dataList.split(";");
                for (String str : s) {
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
                            sb.append(fp + ";");
                        }
                    }
                }
            }
            String[] filePaths = sb.toString().split(";");
            //清空以前保存的文件记录
            resourceService.deleteFileInfo(resourceId);
            int i = 0;
            for (String str : filePaths) {
                FileInfo fileInfo = new FileInfo();
                int one = str.lastIndexOf("/");
                fileInfo.setFile_name(str.substring((one + 1), str.length()));
                fileInfo.setFile_path(str);
                File file = new File(str);
                if (file.exists() && file.isFile()) {
                    Double d = Double.valueOf(file.length()) / 1024 / 1024;
                    NumberFormat nf = NumberFormat.getNumberInstance();
                    nf.setMaximumFractionDigits(4);
                    fileInfo.setSize(nf.format(d));
                }
                fileInfo.getSize();
                fileInfo.setResourceId(resourceId);
                fileInfo.setTime(new Date());
                resourceService.saveFileInfo(fileInfo);
                i++;
            }
            resource.setFilePath(sb.toString().replace("/", "%_%"));
            Double toMemorySize = size / 1024 / 1024;
            NumberFormat nf = NumberFormat.getNumberInstance();
            nf.setMaximumFractionDigits(4);
            resource.setToMemorySize(nf.format(toMemorySize));
            resource.setToRecordNumber(0);
            resource.setToFilesNumber(i);
        }
        if (StringUtils.isNotBlank(resource.getUserGroupId())) {
            resource.setStatus("1");
        } else {
            resource.setStatus("-1");
        }
        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }

    /**
     * Function Description: 编辑资源保存第三步
     *
     * @param: [resourceId, userGroupIdList]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/2 14:53
     */
    @ResponseBody
    @RequestMapping(value = "editResourceThirdStep")
    public JSONObject editResourceThirdStep(HttpSession session,
                                            @RequestParam(name = "resourceId") String resourceId,
                                            @RequestParam(name = "userGroupIdList") String userGroupIdList) {
        String subjectCode = session.getAttribute("SubjectCode").toString();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setUserGroupId(userGroupIdList);
        resource.setStatus("1");
        String resId = resourceService.save(resource);
        jsonObject.put("resourceId", resId);
        return jsonObject;
    }

    @RequestMapping(value = "/uploadHeadImage", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject uploadHeadImageCopy(
            HttpServletRequest request,
            @RequestParam(value = "imgFile") MultipartFile imageFile
    ) throws Exception {
        JSONObject jsonObject = new JSONObject();
        String saveName = "";
        String subjectCode = (String) request.getSession().getAttribute("SubjectCode");
        String resourcePath = imagesPath;
        resourcePath += "/" + subjectCode + "/resources";
        if (imageFile != null) {
            if (FileUploadUtil.allowUpload(imageFile.getContentType())) {
                String fileName = FileUploadUtil.rename(imageFile.getOriginalFilename());
                int end = fileName.lastIndexOf(".");
                saveName = fileName.substring(0, end);
                File dir = new File(resourcePath);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                File file = new File(dir, saveName + ".jpg");
                imageFile.transferTo(file);
                jsonObject.put("saveName", "/imagesPath/" + subjectCode + "/resources/" + saveName + ".jpg");
            }
        }
        return jsonObject;
    }

    /**
     * Function Description: 查看资源
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/6 14:54
     */
    @ResponseBody
    @RequestMapping(value = "resourceDetail")
    public JSONObject resourceDetail(String resourceId) {
        JSONObject jsonObject = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        ResCatalog_Mongo resCatalog_mongo = resCatalogService.getLocalResCatalogNodeById(resource.getCatalogId());
        jsonObject.put("resCatalog", resCatalog_mongo);
        jsonObject.put("resource", resource);
        return jsonObject;
    }

    @ResponseBody
    @RequestMapping(value = "getUserGroups")
    public JSONObject getUserGroups() {
        JSONObject jsonObject = new JSONObject();
        List<Group> groupList = groupService.getAll();
        jsonObject.put("groupList", groupList);
        return jsonObject;
    }

    /**
     * Function Description: 审核资源
     *
     * @param: [resourceId, status, auditContent]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/22 11:15
     */
    @ResponseBody
    @RequestMapping(value = "audit")
    public JSONObject audit(HttpSession session, String resourceId, String status, String auditContent, String userGroupId) {
        String auditPerson = session.getAttribute("userName").toString();
        JSONObject jo = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setStatus(status);
        long currentTimeMillis = System.currentTimeMillis();
        Date date = new Date(currentTimeMillis);
        resource.setAuditTime(date);
        resource.setUserGroupId(userGroupId);
        AuditMessage auditMessage = new AuditMessage();
        auditMessage.setAuditTime(new Date());
        auditMessage.setAuditCom(auditContent);
        auditMessage.setResourceId(resourceId);
        auditMessage.setAuditPerson(auditPerson);
        auditMessageService.save(auditMessage);
        String returnId = resourceService.save(resource);
        if (StringUtils.isNotBlank(resourceId)) {
            jo.put("result", "success");
        } else {
            jo.put("result", "fail");
        }
        return jo;
    }

    /**
     * Function Description: 资源审核信息列表
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/22 11:15
     */
    @ResponseBody
    @RequestMapping("getAuditMessage")
    public JSONObject getAuditMessage(String resourceId) {
        JSONObject jo = new JSONObject();
        List<AuditMessage> auditMessageList = auditMessageService.getAuditMessageListByResourceId(resourceId);
        jo.put("auditMessageList", auditMessageList);
        return jo;
    }

    /**
     * Function Description: 停用
     *
     * @param: [resourceId]
     * @return: com.alibaba.fastjson.JSONObject
     * @auther: hw
     * @date: 2018/11/22 14:27
     */
    @ResponseBody
    @RequestMapping("stopResource")
    public JSONObject stopResource(String resourceId) {
        JSONObject jo = new JSONObject();
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        resource.setStatus("1");
        resourceService.saveDeleteId(resourceId);
        String newresourceId = resourceService.save(resource);
        if (StringUtils.isNotBlank(newresourceId)) {
            jo.put("result", "success");
        } else {
            jo.put("result", "fail");
        }
        return jo;
    }

    @RequestMapping(value = "sqlValidation", method = RequestMethod.GET)
    @ResponseBody
    public JSONObject validateSql(@RequestParam("sqlStr") String sqlStr, @RequestParam("dataSourceId") int dataSourceId) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", dataSrcService.validateSql(sqlStr, dataSourceId));
        return jsonObject;
    }

    /**
     * Function Description: 获取砖题库文件列表
     *
     * @param: []
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: caohq
     * @date: 2019/03/15 10:43
     */
    @ResponseBody
    @RequestMapping(value = "fileSourceZtreeFileList")
    public JSONObject fileSourceZtreeFileList(String resourceId, HttpServletRequest request) {
        cn.csdb.portal.model.Resource resource = resourceService.getById(resourceId);
        String[] filePathArry = new String[0];

        List<FileTreeNode> nodeList = new ArrayList<FileTreeNode>();
        String filePath = (String) request.getSession().getAttribute("FtpFilePath") + "file";
//        String filePath="D:\\workspace";
        File dirFile = new File(filePath);
        JSONObject jsonObject = new JSONObject();
        if (resource != null) {
            if (resource.getFilePath() != null) {//库内被选中字段
                filePathArry = resource.getFilePath().replace("%_%", File.separator).split(";");
                for (String fileStr : filePathArry) {
                    File file = new File(fileStr);
                    if (file.isDirectory()) {
                        nodeList = resourceService.loadingFileTree(file.getPath(), nodeList);
                    }
                }
            }

            if (dirFile.isDirectory()) {
                nodeList.add(new FileTreeNode(filePath, "0", filePath, "true", "true", "init"));
                nodeList = resourceService.loadingFileTree(filePath, nodeList);
            }
            for (String filestr : filePathArry) {
                for (FileTreeNode ftn : nodeList) {
                    if (filestr.equals(ftn.getId())) {
                        ftn.setChecked("true");
                    }
                }
            }

            jsonObject.put("nodeList", nodeList);
        }
        return jsonObject;
    }

    @RequestMapping(value = "ZTreeNode")
    @ResponseBody
    public List<FileTreeNode> ZTreeNode(String id, String path, String name, String taskId, HttpServletRequest req) {
        List<FileTreeNode> nodeList = new ArrayList<FileTreeNode>();
        nodeList = resourceService.asynLoadingTree("", id, "false");//此处id为文件节点（文件路径）
        return nodeList;
    }


    /**
     * @param: []
     * @return: java.util.List<com.alibaba.fastjson.JSONObject>
     * @auther: caohq
     * @date: 2019/04/11 15:43
     */
    @ResponseBody
    @RequestMapping(value = "addFileSourceFileList")
    public JSONObject addFileSourceFileList(HttpSession session) {
        String subjectCode = session.getAttribute("SubjectCode").toString();

        Subject subject = subjectService.findBySubjectCode(subjectCode);


        String filePath = subject.getFtpFilePath() + "file";

        List<FileTreeNode> nodeList = new ArrayList<FileTreeNode>();
        filePath = filePath.replace("/", File.separator);
        if ("/".equals(filePath.charAt(filePath.length() - 1) + "") || "\\".equals(filePath.charAt(filePath.length() - 1) + "")) {
            filePath = filePath.substring(0, filePath.length() - 1);
        }
        nodeList = subjectService.asynLoadingTree("", filePath, "init");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("nodeList", nodeList);
        return jsonObject;
    }

    @RequestMapping(value = "asyncGetNodes")
    @ResponseBody
    public List<FileTreeNode> asyncGetNodes(String id, String pid, String name, String taskId, HttpServletRequest req) {
        List<FileTreeNode> nodeList = new ArrayList<FileTreeNode>();
        nodeList = subjectService.asynLoadingTree("", id, "false");
        return nodeList;
    }


}
