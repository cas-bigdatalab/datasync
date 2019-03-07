package cn.csdb.portal.controller;

import cn.csdb.portal.model.Resource;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.StatisticalDataService;
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
        for(Subject s:list){
            subName.add(s.getSubjectName());
            visitCount.add(s.getVisitCount());
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
        for(Subject s:list){
            subName.add(s.getSubjectName());
            downCount.add(s.getDownCont());
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

}
