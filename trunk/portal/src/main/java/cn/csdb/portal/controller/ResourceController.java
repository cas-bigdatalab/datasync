package cn.csdb.portal.controller;

import cn.csdb.portal.service.ResourceService;
import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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


    /**
     * Function Description: 取得资源分页数据
     *
     * @param:
     * @return: 资源列表
     * @auther: Administrator
     * @date:   2018/10/25 16:46
     */

    @ResponseBody
    @RequestMapping("/getPageData")
    public JSONObject getPageData(HttpServletRequest request, @RequestParam(value = "subjectCode",required = false) String subjectCode,
                              @RequestParam(value = "title",required = false) String title,
                              @RequestParam(value = "publicType",required = false) String publicType,
                              @RequestParam(value = "status",required = false) String status,
                              @RequestParam(value = "pageNo",defaultValue = "1") int pageNo,
                              @RequestParam(value = "pageSize",defaultValue = "10") int pageSize )
    {

        List<cn.csdb.portal.model.Resource> list = resourceService.getListByPage(subjectCode,title,publicType,status,pageNo,pageSize);
        long count = resourceService.countByPage(subjectCode,title,publicType,status);
        JSONObject json = new JSONObject();
        json.put("list",list);
        json.put("totalCount",count);
        json.put("currentPage",pageNo);
        json.put("pageSize",pageSize);
        json.put("totalPages",count % pageSize == 0 ? count / pageSize : count / pageSize + 1);
        return json;
    }


    /**
     * Function Description: 删除一条资源记录
     *
     * @param:  id
     * @return: JSONObject
     * @auther: Administrator
     * @date:   2018/10/25 16:47
     */
    @RequestMapping(value = "/delete/{id}",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject delete(@PathVariable("id") String id){
        JSONObject jsonObject = new JSONObject();
        resourceService.delete(id);
        jsonObject.put("result","ok");
        return jsonObject;
    }
}
