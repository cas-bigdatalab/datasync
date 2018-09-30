package cn.csdb.portal.service;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.SubjectMgmtDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class SubjectMgmtService {
    private SubjectMgmtDao subjectMgmtDao;

    @Autowired
    public void setSubjectMgmtDao(SubjectMgmtDao subjectMgmtDao)
    {
        this.subjectMgmtDao = subjectMgmtDao;
    }

    @Transactional
    public int addSubject(Subject subject)
    {
        return subjectMgmtDao.addSubject(subject);
    }

    @Transactional
    public int deleteProjectLib(int id)
    {
        return subjectMgmtDao.deleteSubject(id);
    }

    @Transactional
    public int modifySubject(Subject subject)
    {
        return subjectMgmtDao.modifySubject(subject);
    }

    public List<Subject> querySubject(int currentNum)
    {
        return null;
    }

    @Transactional
    public String dbConnectable()
    {
        return subjectMgmtDao.dbConnectable();
    }
}
