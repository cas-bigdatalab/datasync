package cn.csdb.portal.controller;

import cn.csdb.portal.model.Resource;
import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.StatisticalDataService;
import cn.csdb.portal.service.SubjectService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
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
//     @RequestMapping("/singlethemeChartsVisit")
//     @ResponseBody
//    public JSONObject singlethemeChartsVisit(String subjectCode ){
//        JSONObject jsonObjec=new JSONObject();
//        List<Resource> list=statisticalDataService.getResouceVisitBySCode(subjectCode);
//        List<Integer> vcount=new ArrayList<>();
//        List<String> title=new ArrayList<>();
//        for(Resource r:list){
//           vcount.add(r.getvCount());
//           title.add(r.getTitle());
//        }
//        jsonObjec.put("vcount",vcount);
//        jsonObjec.put("title",title);
//        return jsonObjec;
//     }

//    @RequestMapping("/singlethemeChartsDown")
//    @ResponseBody
//    public JSONObject singlethemeChartsDown(String subjectCode ){
//        JSONObject jsonObjec=new JSONObject();
//        List<Resource> list=statisticalDataService.getResouceDownBySCode(subjectCode);
//        List<Integer> dcount=new ArrayList<>();
//        List<String> title=new ArrayList<>();
//        for(Resource r:list){
//            dcount.add(r.getdCount());
//            title.add(r.getTitle());
//        }
//        jsonObjec.put("dcount",dcount);
//        jsonObjec.put("title",title);
//        return jsonObjec;
//    }

    @RequestMapping("/SingleSortTable")
    @ResponseBody
    public JSONObject SingleSortTable(String subjectCode,@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
                                      @RequestParam(name = "pageSize", defaultValue = "10") int pageSize){
         JSONObject jsonObject=new JSONObject();
        List<Resource> list=statisticalDataService.getResouceVisitBySCode(subjectCode,pageNo,pageSize);
        List<Resource> list2=statisticalDataService.getResouceDownBySCode(subjectCode,pageNo,pageSize);
        for(int i=0;i<list2.size();i++){
            list.get(i).setdCount(list2.get(i).getdCount());
        }

        jsonObject.put("vCount",list);
        int totalCount=statisticalDataService.countBySubjectCode(subjectCode);
        jsonObject.put("totalCount", totalCount);
        jsonObject.put("currentPage", pageNo);
        jsonObject.put("pageSize", pageSize);
        jsonObject.put("totalPages", totalCount % pageSize == 0 ? totalCount  / pageSize : totalCount / pageSize + 1);

//        jsonObject.put("dCount",list2);
        return jsonObject;
    }

    @RequestMapping("/SortByVcount")
    @ResponseBody
    public JSONObject SortByVcount(String subjectCode,String sortMethod,@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
                                      @RequestParam(name = "pageSize", defaultValue = "10") int pageSize){
        JSONObject jsonObject=new JSONObject();
        List<Resource> list=new ArrayList<>();
        if("asc".equals(sortMethod)){
        list=statisticalDataService.getResouceVisitBySCodeASC(subjectCode,pageNo,pageSize);
        }else{
            list=statisticalDataService.getResouceVisitBySCode(subjectCode,pageNo,pageSize);
        }
        jsonObject.put("vCount",list);
        int totalCount=statisticalDataService.countBySubjectCode(subjectCode);
        jsonObject.put("totalCount", totalCount);
        jsonObject.put("currentPage", pageNo);
        jsonObject.put("pageSize", pageSize);
        jsonObject.put("totalPages", totalCount % pageSize == 0 ? totalCount  / pageSize : totalCount / pageSize + 1);
        return jsonObject;
    }

    @RequestMapping("/SortByDcount")
    @ResponseBody
    public JSONObject SortByDcountSortByVcount(String subjectCode,String sortMethod,@RequestParam(name = "pageNo", defaultValue = "1") int pageNo,
                                   @RequestParam(name = "pageSize", defaultValue = "10") int pageSize){
        JSONObject jsonObject=new JSONObject();
        List<Resource> list=new ArrayList<>();
        if("asc".equals(sortMethod)){
            list=statisticalDataService.getResouceDownBySCodeASC(subjectCode,pageNo,pageSize);
        }else{
            list=statisticalDataService.getResouceDownBySCode(subjectCode,pageNo,pageSize);
        }
        jsonObject.put("vCount",list);
        int totalCount=statisticalDataService.countBySubjectCode(subjectCode);
        jsonObject.put("totalCount", totalCount);
        jsonObject.put("currentPage", pageNo);
        jsonObject.put("pageSize", pageSize);
        jsonObject.put("totalPages", totalCount % pageSize == 0 ? totalCount  / pageSize : totalCount / pageSize + 1);
        return jsonObject;
    }

    @RequestMapping(value = "/IoReadImage")
    public String IoReadImage(@RequestParam("filePath")String filePath, HttpServletRequest request,
                              HttpServletResponse response) throws IOException {
        ServletOutputStream out = null;
        FileInputStream ips = null;
        try {
            //获取图片存放路径
            String imgPath ="G:\\Users\\5793914_122325176000_2.jpg";    // "G:\\Users\\5793914_122325176000_2.jpg"/*filePath*/;
            ips = new FileInputStream(new File(imgPath));
            response.setContentType("multipart/form-data");
            out = response.getOutputStream();
            //读取文件流
            int len = 0;
            byte[] buffer = new byte[1024 * 10];
            while ((len = ips.read(buffer)) != -1){
                out.write(buffer,0,len);
            }
            out.flush();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            out.close();
            ips.close();
        }
        return null;
    }

}
