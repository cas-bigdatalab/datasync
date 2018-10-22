package cn.csdb.portal.webservice;

import cn.csdb.portal.model.Subject;
import cn.csdb.portal.service.SubjectService;
import com.alibaba.fastjson.JSONObject;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @program: DataSync
 * @description: a webservice method
 * @author: xiajl
 * @create: 2018-10-22 16:22
 **/
@RestController
@RequestMapping("/api")
public class WebAPI {
    @Resource
    private SubjectService subjectService;

    @RequestMapping(value = "/getSubject/{subjectCode}", method = RequestMethod.GET)
    public JSONObject getSubject(@PathVariable("subjectCode") String subjectCode){
        JSONObject jsonObject = new JSONObject();
        Subject subject = subjectService.findBySubjectCode(subjectCode);
        jsonObject.put("data",subject);
        return jsonObject;
    }
}
