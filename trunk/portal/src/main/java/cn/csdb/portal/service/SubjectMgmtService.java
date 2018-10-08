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
    public String addSubject(Subject subject)
    {
        String addSubjectNotice = "";
        int addedRowCnt = subjectMgmtDao.addSubject(subject);
        if (addedRowCnt == 1)
        {
            addSubjectNotice = "添加专题库：成功！";
        }
        else
        {
            addSubjectNotice = "添加专题库：失败！";
        }

        return addSubjectNotice;
    }

    @Transactional
    public String deleteSubject(int id)
    {
        String deleteSubjectNotice = "";
        int deletedRowCnt = subjectMgmtDao.deleteSubject(id);
        if (deletedRowCnt == 1)
        {
            deleteSubjectNotice = "删除专题库：成功！";
        }
        else
        {
            deleteSubjectNotice = "删除专题库：失败！";
        }

        return deleteSubjectNotice;
    }

    @Transactional
    public String modifySubject(Subject subject)
    {
        String modifySubjectNotice = "";
        int modifiedRowCnt = subjectMgmtDao.modifySubject(subject);
        if (modifiedRowCnt == 1)
        {
            modifySubjectNotice = "修改专题库：成功！";
        }
        else
        {
            modifySubjectNotice = "修改专题库：失败！";
        }

        return modifySubjectNotice;
    }

    public List<Subject> querySubject(int requestedPage)
    {
        return subjectMgmtDao.querySubject(requestedPage);
    }
}
