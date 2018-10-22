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

        createFtp(subject.getFtpUser(), subject.getFtpPassword());
        createDb(subject.getSubjectCode());

        return addSubjectNotice;
    }

    private boolean createFtp(String ftpUser, String ftpPassword)
    {
        boolean isCreated = subjectMgmtDao.createFtp(ftpUser, ftpPassword);

        return isCreated;
    }

    private boolean createDb(String dbName)
    {
        System.out.println("database name : " + dbName);

        return subjectMgmtDao.createDb(dbName);
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

    public int getTotalPages()
    {
        return subjectMgmtDao.getTotalPages();
    }

    public Subject findSubjectById(int id)
    {
        return subjectMgmtDao.findSubjectById(id);
    }

    /**
     *
     * Function Description: 
     *
     * @param: [code]
     * @return: cn.csdb.portal.model.Subject
     * @auther: hw
     * @date: 2018/10/22 15:13
     */
    public Subject findByCode(String code){
        return subjectMgmtDao.findByCode(code);
    }
}
