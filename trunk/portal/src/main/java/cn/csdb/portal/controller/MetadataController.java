package cn.csdb.portal.controller;

import cn.csdb.portal.model.Group;
import cn.csdb.portal.model.MetadataTemplate;
import cn.csdb.portal.service.MetadataTemplateService;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;

/**
 * @program: DataSync
 * @description: metadata controller
 * @author: xiajl
 * @create: 2019-03-14 10:04
 **/
@Controller
public class MetadataController {
    private Logger logger= LoggerFactory.getLogger(MetadataController.class);
    @Resource
    private MetadataTemplateService metadataTemplateService;

    @RequestMapping("/admin/metadata")
    public String metadata(HttpServletRequest request, Model model)
    {
        return "metadata";
    }

    @ResponseBody
    @RequestMapping("/admin/metadata/getList")
    public JSONObject getList(@RequestParam(name = "extField") String extField, @RequestParam(name = "extFieldName") String extFieldName ){
        JSONObject jsonObject = new JSONObject();
        List<MetadataTemplate> list = metadataTemplateService.getList(extField,extFieldName);
        jsonObject.put("list",list);
        return jsonObject;
    }

    @RequestMapping(value = "/admin/metadata/add", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject add(MetadataTemplate metadataTemplate) {
        metadataTemplateService.save(metadataTemplate);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", "ok");
        return jsonObject;
    }
}
