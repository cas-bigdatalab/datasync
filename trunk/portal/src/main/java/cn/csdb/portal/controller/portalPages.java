package cn.csdb.portal.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
public class portalPages {
    @RequestMapping("/dataRelease")
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView("dataRelease");
        return modelAndView;
    }
    @RequestMapping("/dataSourceDescribe")
    public ModelAndView index2() {
        ModelAndView modelAndView = new ModelAndView("dataSourceDescribe");
        return modelAndView;
    }
    @RequestMapping("/editResource")
    public ModelAndView index3() {
        ModelAndView modelAndView = new ModelAndView("editResource");
        return modelAndView;
    }
    @RequestMapping("/dataDataDescribe")
    public ModelAndView index4() {
        ModelAndView modelAndView = new ModelAndView("dataDataDescribe");
        return modelAndView;
    }
    @RequestMapping("/dataConfiguration")
    public ModelAndView index5() {
        ModelAndView modelAndView = new ModelAndView("dataRealtion_editeFiled");
        return modelAndView;
    }

    @RequestMapping("/statisticalDataDetail")
    public ModelAndView index6(){
        ModelAndView modelAndView=new ModelAndView("statisticalDataDetail");
        return modelAndView;
    }
    @RequestMapping("/datatest")
    public ModelAndView  testData(){
        ModelAndView modelAndView=new ModelAndView("dataRealtion_recordManage");
        return modelAndView;
    }
    @RequestMapping("/statisticalDataTotal")
    public ModelAndView  statisticalDataTotal(){
        ModelAndView modelAndView=new ModelAndView("statisticalDataTotal");
        return modelAndView;
    }

    @RequestMapping("/fileMange")
    public ModelAndView fileMange() {
        ModelAndView modelAndView = new ModelAndView("fileMange");
        return modelAndView;
    }

    @RequestMapping("/createTableAndImportData")
    public ModelAndView createTableAndImportData() {
        ModelAndView modelAndView = new ModelAndView("dataRelation_createTableAndImportData");
//        ModelAndView modelAndView = new ModelAndView("dataConfiguration");
        return modelAndView;
    }
}
