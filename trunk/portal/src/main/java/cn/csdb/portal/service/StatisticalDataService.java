package cn.csdb.portal.service;

import cn.csdb.portal.model.Resource;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.repository.ResourceDao;
import cn.csdb.portal.repository.SubjectDao;
import com.mongodb.BasicDBObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

@Service
@Transactional
public class StatisticalDataService {

    @Autowired
    private SubjectDao subjectDao;

    @Autowired
    private ResourceDao resourceDao;

//    查询所有的专题
    public  List<Subject> findAllSubject(){
        List<Subject> list=subjectDao.findAllsubject();
        return list;
    }

//    主题库浏览量统计
    public List<Subject> statisDataDatil(){
        List<Subject> list=subjectDao.findAllsubject();
        List<Subject> list1=new ArrayList<>();

        for(Subject s:list){
            Subject ss=new Subject();
           long l=resourceDao.getBySubject(s.getSubjectCode()); //浏览量----top10
            ss.setSubjectName(s.getSubjectName());
            ss.setSubjectCode(s.getSubjectCode());
            ss.setVisitCount(l);
            list1.add(ss);
        }
        Collections.sort(list1, new Comparator<Subject>(){

            @Override
            public int compare(Subject o1, Subject o2) {
                if(o1.getVisitCount()<o2.getVisitCount()){
                    return 1;
                }
                if(o1.getVisitCount()==o2.getVisitCount()){
                    return 0;
                }
                return -1;
            }
        });
//        for(Subject s:list1){
//            System.out.println(s.getSubjectCode()+"的浏览量："+s.getVisitCount());
//        }
        return list1;
    }

    //    主题库下载量统计
public List<Subject> getDownloadCount(){
    List<Subject> list=subjectDao.findAllsubject();
    List<Subject> list1=new ArrayList<>();

    for(Subject s:list){
        Subject ss=new Subject();
        long l=resourceDao.getDownladCount(s.getSubjectCode()); //浏览量----top10
        ss.setSubjectName(s.getSubjectName());
        ss.setSubjectCode(s.getSubjectCode());
        ss.setDownCont(l);
        list1.add(ss);
    }
    Collections.sort(list1, new Comparator<Subject>(){

        @Override
        public int compare(Subject o1, Subject o2) {
            if(o1.getDownCont()<o2.getDownCont()){
                return 1;
            }
            if(o1.getDownCont()==o2.getDownCont()){
                return 0;
            }
            return -1;
        }
    });
    return list1;
}

   public List<Resource> getResourcVisit(){
        List<Resource> list=resourceDao.getResourceVisit();
        return list;
   }
    public List<Resource> getResourcDown(){
        List<Resource> list=resourceDao.getResourceDown();
        return list;
    }

    public List<Resource> getResouceVisitBySCode(String subjectCode){
        List<Resource> list=resourceDao.getResouceVisitBySCode(subjectCode);
        return list;
    }
    /**
     * Function Description: 根据专题库统计该专题库内各数据集的访问量
     *
     * @param:
     * @return:
     * @auther:zcy
     * @date:   2019/3/13 9:36
     */
    public List<Resource> getResouceDownBySCode(String subjectCode){
        List<Resource> list=resourceDao.getResouceDownBySCode(subjectCode);
        return list;
    }

}
