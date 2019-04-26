package cn.csdb.portal.controller;

import cn.csdb.portal.model.MetaTemplate;
import cn.csdb.portal.service.MetaTemplateService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * @program: DataExplore
 * @description: meta template Controller
 * @author: xiajl
 * @create: 2019-04-24 10:31
 **/
@Controller
public class MetaTemplateController {
    @Resource
    private MetaTemplateService metaTemplateService;

    @ResponseBody
    @RequestMapping(value = "/metaTemplate/add")
    public JSONObject add(@ModelAttribute MetaTemplate metaTemplate, @RequestParam(name = "subjectCode") String subjectCode) {
        JSONObject jsonObject = new JSONObject();
        metaTemplate.setSubjectCode(subjectCode);
        metaTemplateService.add(metaTemplate);
        jsonObject.put("result", "true");
        return jsonObject;
    }


    @ResponseBody
    @RequestMapping(value = "/metaTemplate/getList")
    public JSONObject getList(@RequestParam(name = "subjectCode") String subjectCode) {
        JSONObject jsonObject = new JSONObject();
        List<MetaTemplate> list = metaTemplateService.getList(subjectCode);
        jsonObject.put("list", list);
        return jsonObject;
    }

    @RequestMapping("/metaTemplate/toMateTemMsgList")
    public String getDataMsgList() {
//        String subjectCode = session.getAttribute("SubjectCode").toString();
//        model.addAttribute("subjectCode",subjectCode);
        return "MateTemMsgList";
    }
    @ResponseBody
    @RequestMapping(value = "/metaTemplate/getAllList")
    public JSONObject getAllist() {
        JSONObject jsonObject = new JSONObject();
        List<MetaTemplate> list = metaTemplateService.getAllList();
        jsonObject.put("list", list);
        return jsonObject;
    }

    @RequestMapping("/metaTemplate/getDetail")
    @ResponseBody
    public JSONObject getDetail(String id) {
        JSONObject jsonObject = new JSONObject();
        MetaTemplate metaTemplate = metaTemplateService.get(id);
        List<Map<String, Object>> extMetadata = metaTemplate.getExtMetadata();
        List<String> extList = new ArrayList<>();
        if(extMetadata!=null) {
            for (int i = 0; i < extMetadata.size(); i++) {
                Map<String, Object> map = extMetadata.get(i);
                Set<String> set = map.keySet();
                Iterator<String> it = set.iterator();
                while (it.hasNext()) {
                    extList.add(map.get(it.next()).toString());
                }
            }
        }
        jsonObject.put("list", metaTemplate);
        jsonObject.put("extList",extList);
        return jsonObject;
    }

    @RequestMapping("/metaTemplate/deleteMetaTem")
    @ResponseBody
    public JSONObject deleteMetaTem(String id){
        JSONObject jsonObject=new JSONObject();
         metaTemplateService.deleteById(id);
         jsonObject.put("success","success");
        return jsonObject;
    }

}
