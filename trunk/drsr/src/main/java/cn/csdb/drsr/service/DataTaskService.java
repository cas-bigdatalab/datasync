package cn.csdb.drsr.service;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.DataTaskDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @program: DataSync
 * @description:  DataTask Service
 * @author: xiajl
 * @create: 2018-09-30 16:29
 **/

@Service
public class DataTaskService {
    @Resource
    private DataTaskDao dataTaskDao;

    public DataTask get(int dataTaskId){
        return dataTaskDao.get(dataTaskId);
    }
}
