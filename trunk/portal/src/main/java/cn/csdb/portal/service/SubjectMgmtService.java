package cn.csdb.portal.service;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.SubjectMgmtDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.IOException;
import java.util.List;

@Service
public class SubjectMgmtService {
    private SubjectMgmtDao subjectMgmtDao;

    @Autowired
    public void setSubjectMgmtDao(SubjectMgmtDao subjectMgmtDao)
    {
        this.subjectMgmtDao = subjectMgmtDao;
    }

    /**
     * Function Description:
     *
     * @param subject, the wrapped object which contains information of the subject ot be added
     * @return  addSubjectNotice, a notice inform user if create subject success or not
     */
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

        Runtime runtime = Runtime.getRuntime();
        try {
            Process process = runtime.exec(new String[]{"bash", "-c", "./etc/vsftpd/vftpuseradd "+subject.getFtpUser()+" "+subject.getFtpPassword()});
        } catch (IOException e) {
            e.printStackTrace();
        }

        return addSubjectNotice;
    }


    /**
     * Function Description:
     *
     * @param id, the id of Subject to be deleted
     * @return  deleteSubjectNotice, a notice inform user the deletion result
     * @author zzl
     * @date 2018/10/23
     */
    @Transactional
    public int deleteSubject(String id)
    {
        String deleteSubjectNotice = "";
        int deletedRowCnt = subjectMgmtDao.deleteSubject(id);

        return deletedRowCnt;
    }

    /**
     * Function Description:
     *
     * @param subject the subject to be updated
     * @return  updatedSubjectNotice a notice which inform user update result.
     * @author zzl
     * @date 2018/10/23
     */
    @Transactional
    public String updateSubject(Subject subject)
    {
        String updatedSubjectNotice = "";
        int modifiedRowCnt = subjectMgmtDao.updateSubject(subject);
        if (modifiedRowCnt == 1)
        {
            updatedSubjectNotice = "修改专题库：成功！";
        }
        else
        {
            updatedSubjectNotice = "修改专题库：失败！";
        }

        return updatedSubjectNotice;
    }

    /**
     * Function Description:
     *
     * @param requestedPage
     * @return List<Subject>
     * @author zzl
     * @date 2018/10/23
     */
    public List<Subject> querySubject(String subjectNameFilter, int requestedPage)
    {
        return subjectMgmtDao.querySubject(subjectNameFilter, requestedPage);
    }

    /**
     * Function Description:
     *
     * @return totalPages
     * @author zzl
     * @date 2018/10/23
     */
    public long getTotalPages(String subjectNameFilter)
    {
        return subjectMgmtDao.getTotalPages(subjectNameFilter);
    }

    /**
     * Function Description:
     *
     * @param id
     * @return Subject
     * @author zzl
     * @date 2018/10/23
     */
    public Subject findSubjectById(String id)
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


    /**
     * Function Description:
     *
     */
    public long querySubjectCode(String subjectCode)
    {
        return subjectMgmtDao.querySubjectCode(subjectCode);
    }


    public long queryAdmin(String userName)
    {
        return subjectMgmtDao.queryAdmin(userName);
    }

    public long getTotalSubject(String subjectNameFilter)
    {
        return subjectMgmtDao.getTotalSubject(subjectNameFilter);
    }

    public List<Subject> getSubjectCodeList()
    {
        return subjectMgmtDao.getSubjectCodeList();
    }
}
