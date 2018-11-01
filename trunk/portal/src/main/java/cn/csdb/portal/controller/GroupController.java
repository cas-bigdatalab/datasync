package cn.csdb.portal.controller;

import cn.csdb.portal.model.Group;
import cn.csdb.portal.service.GroupService;
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
 * @description: user group controller
 * @author: xiajl
 * @create: 2018-10-30 11:31
 **/
@RequestMapping("/group")
@Controller
public class GroupController {
    @Resource
    private GroupService groupService;

    private Logger logger= LoggerFactory.getLogger(GroupController.class);

    @RequestMapping("/list")
    public String list(HttpServletRequest request, Model model){
        logger.info("进入用户组列表页面");
        return "group";
    }


    @ResponseBody
    @RequestMapping("/getPageData")
    public JSONObject getPageData(HttpServletRequest request, @RequestParam(value = "groupName",required = false) String groupName,
                                  @RequestParam(value = "pageNo",defaultValue = "1") int pageNo,
                                  @RequestParam(value = "pageSize",defaultValue = "10") int pageSize )
    {
        List<Group> list = groupService.getListByPage(groupName,pageNo,pageSize);
        long count = groupService.countByPage(groupName);
        JSONObject json = new JSONObject();
        json.put("list",list);
        json.put("totalCount",count);
        json.put("currentPage",pageNo);
        json.put("pageSize",pageSize);
        json.put("totalPages",count % pageSize == 0 ? count / pageSize : count / pageSize + 1);
        return json;
    }

    @RequestMapping(value = "/delete/{id}",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject delete(@PathVariable("id") String id){
        JSONObject jsonObject = new JSONObject();
        Group group = groupService.get(id);
        groupService.delete(group);
        jsonObject.put("result","ok");
        return jsonObject;
    }


    @RequestMapping(value = "/add", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject addGroup(Group group) {
        groupService.add(group);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", "ok");
        return jsonObject;
    }


    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public JSONObject updateGroup(Group group) {
        groupService.update(group);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("result", "ok");
        return jsonObject;
    }


    @RequestMapping("/info")
    @ResponseBody
    public JSONObject getGroupInfo(@RequestParam(name = "id", defaultValue = "") String id) {
        Group group = groupService.get(id);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("group", group);
        return jsonObject;
    }

}
