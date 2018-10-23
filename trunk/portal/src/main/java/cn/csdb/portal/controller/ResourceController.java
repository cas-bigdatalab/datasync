package cn.csdb.portal.controller;

import cn.csdb.portal.service.ResourceService;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @program: DataSync
 * @description: Resource Controller class
 * @author: xiajl
 * @create: 2018-10-23 16:32
 **/
@Controller
@RequestMapping("/resource")
public class ResourceController {
    @Resource
    private ResourceService resourceService;

    private Logger logger= LoggerFactory.getLogger(ResourceController.class);

    @RequestMapping("/list")
    public String list(HttpServletRequest request, Model model){
        logger.info("进入资源列表页面");
        return "resource";
    }


    @ResponseBody
    @RequestMapping("/getPageData")
    public JSONObject getPageData(@RequestParam(value = "subjectCode",required = false) String subjectCode,
                              @RequestParam(value = "title",required = false) String title,
                              @RequestParam(value = "status",required = false) String status,
                              @RequestParam(value = "pageNo",defaultValue = "1") int pageNo,
                              @RequestParam(value = "pageSize",defaultValue = "10") int pageSize )

    {

        List<cn.csdb.portal.model.Resource> list = resourceService.getListByPage(subjectCode,title,status,pageNo,pageSize);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data",list);
        return jsonObject;
    }
}
