package cn.csdb.drsr;

import cn.csdb.drsr.repository.PersonDao;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;
import java.util.Map;

public class SqlLiteDemo {
    public static void main(String[] args){
        ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
        PersonDao personDao = (PersonDao) ctx.getBean("personDao");
        List<Map<String,Object>> list = personDao.findAll();
        for(Map<String,Object> map : list){
            System.out.println(map.get("name"));
        }
    }

}
