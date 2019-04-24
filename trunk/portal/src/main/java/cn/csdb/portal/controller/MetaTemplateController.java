package cn.csdb.portal.controller;

import cn.csdb.portal.model.MetaTemplate;
import cn.csdb.portal.service.MetaTemplateService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

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
    public JSONObject add(@ModelAttribute MetaTemplate metaTemplate, @RequestParam(name = "subjectCode") String subjectCode){
        JSONObject jsonObject = new JSONObject();
        metaTemplate.setSubjectCode(subjectCode);
        metaTemplateService.add(metaTemplate);
        jsonObject.put("result","true");
        return jsonObject;
    }


    @ResponseBody
    @RequestMapping(value = "/metaTemplate/getList")
    public JSONObject getList(@RequestParam(name = "subjectCode") String subjectCode){
        JSONObject jsonObject = new JSONObject();
        List<MetaTemplate> list = metaTemplateService.getList(subjectCode);
        jsonObject.put("list",list);
        return jsonObject;
    }
}
