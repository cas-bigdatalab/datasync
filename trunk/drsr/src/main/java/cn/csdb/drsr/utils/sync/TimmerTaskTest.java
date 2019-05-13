package cn.csdb.drsr.utils.sync;

import cn.csdb.drsr.model.DataTask;
import cn.csdb.drsr.repository.mapper.DataTaskMapper;
import com.alibaba.fastjson.JSONObject;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.TimerTask;

@Repository
public class TimmerTaskTest extends TimerTask {

    private JdbcTemplate jdbcTemplate;

    public TimmerTaskTest(JdbcTemplate jdbcTemplate){
        this.jdbcTemplate=jdbcTemplate;
    }

    @Override
    public void run() {
        long nd = 1000 * 24 * 60 * 60;// 一天的毫秒数
        long nh = 1000 * 60 * 60;// 一小时的毫秒数
        StringBuffer sql = new StringBuffer("select * from t_datatask where status='1' and  syncdata='true'");
        List<DataTask> list = jdbcTemplate.query(sql.toString(),new DataTaskMapper());
        Date date = new Date(this.scheduledExecutionTime());
        System.out.println("本次检查日期：" + date);
        System.out.println("本次需同步任务条数："+list.size()+"条");
        for(int num=0;num<list.size();num++) {
            int n = num + 1;
            long time = new Date().getTime() - list.get(num).getSynctime().getTime();
            long hour = time / nh;// 计算差多少小时
            if(hour>=Long.valueOf(list.get(num).getPeriod())){
                SyncUtil syncUtil = new SyncUtil();
                JSONObject jsonObject = syncUtil.executeTask(list.get(num), jdbcTemplate);
                if (jsonObject.size() != 0 && "success".equals(jsonObject.getString("result"))) {
                    jdbcTemplate.update("update t_datatask set SyncTime='" + new Date().getTime() + "' where datataskid='" + list.get(num).getDataTaskId() + "'");
                }
            }
         }

    }








}
