package cn.csdb.portal.service;

import cn.csdb.portal.model.MetadataTemplate;
import cn.csdb.portal.repository.MetadataTemplateDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @program: DataSync
 * @description: metadata template service
 * @author: xiajl
 * @create: 2019-03-08 15:17
 **/
@Service
public class MetadataTemplateService {

    @Resource
    private MetadataTemplateDao metadataTemplateDao;

    public  List<MetadataTemplate> getAll(){
        return metadataTemplateDao.getAll();
    }
}
