package cn.csdb.portal.utils;

import java.io.IOException;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-15 14:42
 **/
public class SqlUtil {
    public void importSql(String username,String password,String importDatabaseName, String structImportPath,String dataImportPath) throws IOException {
        Runtime runtime = Runtime.getRuntime();
        StringBuffer command = new StringBuffer().append("mysql -u").append(username);
        if (password!=null&&!password.equals("")) {
            command.append(" -p").append(password);
        }
        command.append(" "+importDatabaseName);
        command.append(" < "+structImportPath);
        Process process = runtime.exec(new String[]{"bash", "-c", command.toString()});
        try {
            process.waitFor();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        StringBuffer command2 = new StringBuffer().append("mysql -u").append(username);
        if (password!=null&&!password.equals("")) {
            command2.append(" -p").append(password);
        }
        command2.append(" "+importDatabaseName);
        command2.append(" < "+dataImportPath);
        process = runtime.exec(new String[]{"bash", "-c", command2.toString()});
    }

    /*private String[] getImportCommand(String username,String password,String host,String port,String importDatabaseName, String importPath) {
//        String username = "root";//用户名
//        String password = "";//密码
//        String host = "10.0.86.78";//导入的目标数据库所在的主机
//        String port = "3306";//使用的端口号
//        String importDatabaseName = "testimport";//导入的目标数据库的名称
//        String importPath = "/root/struct.sql";//导入的目标文件所在的位置
        //第一步，获取登录命令语句
        StringBuffer loginCommand = new StringBuffer().append("mysql -u").append(username);
        if (!password.equals("")) {
            loginCommand.append(" -p").append(password);
        }
        loginCommand.append(" -h").append(host)
                .append(" -P").append(port).toString();
        //第二步，获取切换数据库到目标数据库的命令语句
        String switchCommand = new StringBuffer("use ").append(importDatabaseName).toString();
        //第三步，获取导入的命令语句
        String importCommand = new StringBuffer("source ").append(importPath).toString();
        //需要返回的命令语句数组
        System.out.println(loginCommand.toString());
        System.out.println(switchCommand);
        System.out.println(importCommand);
        String[] commands = new String[]{loginCommand.toString(), switchCommand, importCommand};
        return commands;
    }*/

}
