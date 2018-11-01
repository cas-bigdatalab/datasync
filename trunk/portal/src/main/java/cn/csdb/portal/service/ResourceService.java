package cn.csdb.portal.service;

import cn.csdb.portal.repository.ResourceDao;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

/**
 * @program: DataSync
 * @description: Resource Service
 * @author: xiajl
 * @create: 2018-10-23 16:19
 **/
@Service
public class ResourceService {

    @Resource
    private ResourceDao resourceDao;

    /**
     * Function Description: 保存资源
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date: 2018/10/23 16:22
     */
    @Transactional
    public void save(cn.csdb.portal.model.Resource resource) {
        resourceDao.save(resource);
    }

    /**
     * Function Description: 删除资源
     *
     * @param:
     * @return:
     * @auther: Administrator
     * @date: 2018/10/23 16:25
     */
    @Transactional
    public void delete(String id) {
        resourceDao.delete(id);
    }

    @Transactional
    public void delete(cn.csdb.portal.model.Resource resource) {
        resourceDao.delete(resource);
    }

    /**
     * Function Description: 分页查询获取资源List
     *
     * @param:  subjectCode:专题库代码, title:资源名称, status:状态, pageNo:页数, pageSize:第页记录条数
     * @return: 资源List列表
     * @auther: Administrator
     * @date:   2018/10/23 16:28
     */
    @Transactional(readOnly = true)
    public List<cn.csdb.portal.model.Resource> getListByPage(String subjectCode, String title, String publicType, String status, int pageNo, int pageSize) {
        return resourceDao.getListByPage(subjectCode, title, publicType, status, pageNo, pageSize);
    }


    @Transactional(readOnly = true)
    public long countByPage(String subjectCode, String title,String publicType, String status){
        return resourceDao.countByPage(subjectCode,title,publicType, status);
    }
/*----------------------------------------------------------------------------------------*/

    public List<JSONObject> fileSourceFileList(String filePath) {
        List<JSONObject> jsonObjects = new ArrayList<JSONObject>();
//        File file = new File(filePath);
//        if (!file.exists() || !file.isDirectory())
//            return jsonObjects;
        String[] fp = filePath.split(";");
        for (int i = 0; i < fp.length; i++) {
            if(StringUtils.isBlank(fp[i])){
                continue;
            }
            File file = new File(fp[i]);
            if(!file.exists()){
                continue;
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", file.getPath().replaceAll("\\\\","%_%"));
            jsonObject.put("text", file.getName().replaceAll("\\\\","%_%"));
            if (file.isDirectory()) {
                jsonObject.put("type", "directory");
                JSONObject jo = new JSONObject();
                jo.put("disabled","true");
                jsonObject.put("state",jo);
            } else {
                jsonObject.put("type", "file");
            }
            jsonObjects.add(jsonObject);
        }
        Collections.sort(jsonObjects, new FileComparator());
        return jsonObjects;
    }

    class FileComparator implements Comparator<JSONObject> {

        public int compare(JSONObject o1, JSONObject o2) {
            if ("directory".equals(o1.getString("type")) && "directory".equals(o2.getString("type"))) {
                return o1.getString("text").compareTo(o2.getString("text"));
            } else if ("directory".equals(o1.getString("type")) && !"directory".equals(o2.getString("type"))) {
                return -1;
            } else if (!"directory".equals(o1.getString("type")) && "directory".equals(o2.getString("type"))) {
                return 1;
            } else {
                return o1.getString("text").compareTo(o2.getString("text"));
            }
        }
    }
}