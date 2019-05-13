package cn.csdb.drsr.utils.sync;

import org.springframework.jdbc.core.JdbcTemplate;
import java.util.Timer;


public class TimmerController {

    private JdbcTemplate jdbcTemplate;
    Timer timer;

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void start(){
        timer = new Timer();
        timer.schedule(new TimmerTaskTest(jdbcTemplate),0,60000);//3*60*1000 三分钟
    }
}
