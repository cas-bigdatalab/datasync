package cn.csdb.portal.controller;

import cn.csdb.portal.model.MetadataTemplate;
import cn.csdb.portal.model.User;
import cn.csdb.portal.service.CheckUserService;
import cn.csdb.portal.service.MetadataTemplateService;
import cn.csdb.portal.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class portalPages {
    @Resource
    private MetadataTemplateService metadataTemplateService;
    @Resource
    private CheckUserService checkUserService;
    @Resource
    private UserService userService;

    @RequestMapping("/dataRelease")
    public ModelAndView index() {
        ModelAndView modelAndView = new ModelAndView("dataReleaseNew");
        return modelAndView;
    }
    @RequestMapping("/dataSourceDescribe")
    public ModelAndView index2(Model model) {
        //ModelAndView modelAndView = new ModelAndView("dataSourceDescribe");
        List<MetadataTemplate> list = metadataTemplateService.getAll();
        model.addAttribute("list",list);
        ModelAndView modelAndView = new ModelAndView("dataAdd_Publication");
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
        ModelAndView modelAndView = new ModelAndView("dataRealtion_editeFiledNew");
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

    @RequestMapping("/authorization")//用戶授權
    public String authorization(HttpServletRequest request, Model model) {
//         modelAndView = new ModelAndView("authorizationPage");

        String loginid = "";
        if (request.getSession().getAttribute("LoginId") != null) {
            loginid = request.getSession().getAttribute("LoginId").toString();
        }
        List<User> list = userService.getAllByRole("普通用户");
        model.addAttribute("list",list);
        User u = checkUserService.getByUserName(loginid);
        cn.csdb.portal.model.Subject subject = null;
        if (u.getSubjectCode() != null) {
            subject = checkUserService.getSubjectByCode(u.getSubjectCode());
            model.addAttribute("subject", subject);
        }

        return "authorizationPage";
    }
}
