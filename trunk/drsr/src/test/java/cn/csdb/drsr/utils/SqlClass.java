package cn.csdb.drsr.utils;

import java.io.*;

/**
 * @program: DataSync
 * @description:
 * @author: huangwei
 * @create: 2018-10-08 14:24
 **/
public class SqlClass {
    public void importSql() throws IOException {
        Runtime runtime = Runtime.getRuntime();
        //因为在命令窗口进行mysql数据库的导入一般分三步走，所以所执行的命令将以字符串数组的形式出现
        String cmdarray[] = getImportCommand();//根据属性文件的配置获取数据库导入所需的命令，组成一个数组
        //runtime.exec(cmdarray);//这里也是简单的直接抛出异常
//        Process process = runtime.exec(cmdarray[0]);
        Process process = runtime.exec(new String[]{"bash", "-c", "mysql -uroot testimport  < /root/testimport.sql"});
        //执行了第一条命令以后已经登录到mysql了，所以之后就是利用mysql的命令窗口
        BufferedReader br = null;
        br = new BufferedReader(new InputStreamReader(process.getInputStream()));
        String line = null;
        while ((line = br.readLine()) != null) {
            System.out.println(line);
        }
        //进程执行后面的代码
        /*try {
            process.waitFor();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }*/
        OutputStream os = process.getOutputStream();
        OutputStreamWriter writer = new OutputStreamWriter(os);
        //命令1和命令2要放在一起执行
        writer.write(cmdarray[1] + "\r\n" + cmdarray[2] + "\r\n" + "create database tttest");
        writer.flush();
        writer.close();
        os.close();
    }

    private String[] getImportCommand() {
        String username = "root";//用户名
        String password = "";//密码
        String host = "10.0.86.78";//导入的目标数据库所在的主机
        String port = "3306";//使用的端口号
        String importDatabaseName = "testimport";//导入的目标数据库的名称
        String importPath = "/root/testimport.sql";//导入的目标文件所在的位置
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
    }
}
