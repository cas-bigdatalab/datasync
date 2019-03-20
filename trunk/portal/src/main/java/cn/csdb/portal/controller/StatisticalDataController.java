package cn.csdb.portal.controller;

import cn.csdb.portal.model.Resource;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.StatisticalDataService;
import cn.csdb.portal.service.SubjectService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Controller
public class StatisticalDataController {

    @Autowired
    private StatisticalDataService statisticalDataService;

    @Autowired
    private SubjectService subjectService;

//    @RequestMapping("/statisticalDataDetail")
//    public ModelAndView index6(){
//        ModelAndView modelAndView=new ModelAndView("statisticalDataDetail");
//
//        return modelAndView;
//    }

    @RequestMapping("/ThemeStatisticVisit")
    @ResponseBody
    public JSONObject showThemeStatistic(){
        JSONObject jsonObject=new JSONObject();
        List<Subject> list=statisticalDataService.statisDataDatil();
        List<String> subName=new ArrayList<>();
        List<Long>   visitCount=new ArrayList<>();
        int i=0;
        for(Subject s:list){
            if (i<10) {
                subName.add(s.getSubjectName());
                visitCount.add(s.getVisitCount());
            }else{
                break;
            }
        }
        jsonObject.put("name",subName);
        jsonObject.put("visitCount",visitCount);
        return jsonObject;
    }
    @RequestMapping("/ThemeStatisticDown")
    @ResponseBody
    public JSONObject ThemeStatisticDown(){
       JSONObject jsonObject=new JSONObject();
       List<Subject> list=statisticalDataService.getDownloadCount();
        List<String> subName=new ArrayList<>();
        List<Long>   downCount=new ArrayList<>();
        int i=0;
        for(Subject s:list){
            if (i<10) {
                subName.add(s.getSubjectName());
                downCount.add(s.getDownCont());
            }else{
                break;
            }
        }
        jsonObject.put("name",subName);
        jsonObject.put("downCount",downCount);
        return jsonObject;
    }

    @RequestMapping("/dataCollentionVisit")
    @ResponseBody
    public JSONObject dataCollentionVisit(){
        JSONObject jsonObject=new JSONObject();
        List<String> subName=new ArrayList<>();
        List<Integer>   visitCount=new ArrayList<>();
        List<Resource> list=statisticalDataService.getResourcVisit();
        int i=0;
        for(Resource r:list){
            if (i<10){
                subName.add(r.getTitle());
                visitCount.add(r.getvCount());
                i++;
            }else{
                break;
            }
        }
        jsonObject.put("name",subName);
        jsonObject.put("visitCount",visitCount);
        return jsonObject;
    }
    @RequestMapping("/dataCollentionDown")
    @ResponseBody
    public JSONObject dataCollentionDown(){
        JSONObject jsonObject=new JSONObject();
        List<String> subName=new ArrayList<>();
        List<Integer>   downCount=new ArrayList<>();
        List<Resource> list=statisticalDataService.getResourcDown();
        int i=0;
        for(Resource r:list){
            if (i<10){
                subName.add(r.getTitle());
                downCount.add(r.getdCount());
                i++;
            }else{
                break;
            }
        }
        jsonObject.put("name",subName);
        jsonObject.put("downCount",downCount);
        return jsonObject;
    }

    @RequestMapping("/ThemeStatisticVisitTotal")
    @ResponseBody
    public JSONObject ThemeStatisticVisitTotal(){
        JSONObject jsonObject=new JSONObject();
        List<Subject> list=statisticalDataService.statisDataDatil();
        List<String> subName=new ArrayList<>();
        List<Long>   visitCount=new ArrayList<>();
        for(Subject s:list){
            subName.add(s.getSubjectName());
            visitCount.add(s.getVisitCount());
        }
        jsonObject.put("name",subName);
        jsonObject.put("visitCount",visitCount);
        return jsonObject;
    }
    @RequestMapping("/ThemeStatisticDownTotal")
    @ResponseBody
    public JSONObject ThemeStatisticDownTotal(){
        JSONObject jsonObject=new JSONObject();
        List<Subject> list=statisticalDataService.getDownloadCount();
        List<String> subName=new ArrayList<>();
        List<Long>   downCount=new ArrayList<>();
        for(Subject s:list){
            subName.add(s.getSubjectName());
            downCount.add(s.getDownCont());
        }
        jsonObject.put("name",subName);
        jsonObject.put("downCount",downCount);
        return jsonObject;
    }

    @RequestMapping("/showAllTheme")
    @ResponseBody
    public JSONObject showAllTheme(){
        JSONObject jsonObject=new JSONObject();
        List<Subject> list=statisticalDataService.findAllSubject();
        jsonObject.put("list",list);
        return jsonObject;
    }

//    根据专题库统计
     @RequestMapping("/findBySubjectCode")
     @ResponseBody
      public JSONObject findBySubjectCode(String subjectCode ){
        JSONObject jsonObject=new JSONObject();
        Subject subject=subjectService.findBySubjectCode(subjectCode);
        List<Subject> list=new ArrayList<>();
        list.add(subject);
        jsonObject.put("subject",list);

        return jsonObject;
     }
    /**
     * Function Description: 根据专题库统计该专题库内各数据集的访问量控制器
     *
     * @param:
     * @return:
     * @auther:zcy
     * @date:   2019/3/13 9:36
     */
     @RequestMapping("/singlethemeChartsVisit")
     @ResponseBody
    public JSONObject singlethemeChartsVisit(String subjectCode ){
        JSONObject jsonObjec=new JSONObject();
        List<Resource> list=statisticalDataService.getResouceVisitBySCode(subjectCode);
        List<Integer> vcount=new ArrayList<>();
        List<String> title=new ArrayList<>();
        for(Resource r:list){
           vcount.add(r.getvCount());
           title.add(r.getTitle());
        }
        jsonObjec.put("vcount",vcount);
        jsonObjec.put("title",title);
        return jsonObjec;
     }

    @RequestMapping("/singlethemeChartsDown")
    @ResponseBody
    public JSONObject singlethemeChartsDown(String subjectCode ){
        JSONObject jsonObjec=new JSONObject();
        List<Resource> list=statisticalDataService.getResouceDownBySCode(subjectCode);
        List<Integer> dcount=new ArrayList<>();
        List<String> title=new ArrayList<>();
        for(Resource r:list){
            dcount.add(r.getdCount());
            title.add(r.getTitle());
        }
        jsonObjec.put("dcount",dcount);
        jsonObjec.put("title",title);
        return jsonObjec;
    }
}
