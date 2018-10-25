package cn.csdb.portal.service;

import cn.csdb.portal.repository.ResourceDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
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
    public List<cn.csdb.portal.model.Resource> getListByPage(String subjectCode, String title, String status, int pageNo, int pageSize) {
        return resourceDao.getListByPage(subjectCode, title, status, pageNo, pageSize);
    }


    @Transactional(readOnly = true)
    public long countByPage(String subjectCode, String title, String status){
        return resourceDao.countByPage(subjectCode,title,status);
    }
}