package cn.csdb.drsr.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class LoginFilter  implements Filter {

    private static final Logger logger = LogManager.getLogger(LoginController.class);

    /**
     * 初始化
     */
    public void init(FilterConfig fc) throws ServletException {
        // FileUtil.createDir("d:/FH/topic/");
    }

    public void destroy() {

    }

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String[] notFilter = new String[] { "js","xml","css","demo","img","images","fonts","common","gateway","payCallback","toOrderPage","show_order"};//过滤字段、路径。。。。。。
        String urlPath = request.getServletPath();
        Boolean flg = false;
        HttpSession session = request.getSession();
        String userName = (String) session.getAttribute("userName"); //登录成功将登录ID放入session中，这里将session取出对比
      //  String[] notFilter = new String[] { "/","/login"};
        for (String url : notFilter) {
             if ((urlPath.contains(url))) {
                flg = true;
            }

         }
        if("/".equals(urlPath)){
            if (userName!=null && userName!=""){
//                IndexController indexController=new IndexController();
//                indexController.index(userName);
                response.sendRedirect(request.getRequestURL()+"index");
                return;
            }
            flg = true;
        }
        if("/login".equals(urlPath)){
            flg = true;
        }
        if("/ftpUploadProcess".equals(urlPath)){
            flg = true;
        }

        if(flg){
            chain.doFilter(req, res);
        }else{
            if (null == userName||"".equals(userName)) {
                logger.warn("用户登录超时或未登录，请重新登录！");
                java.io.PrintWriter out = response.getWriter();
//                out.println("<html>");
//                out.println("<script>");
//                out.println("window.open ('"+request.getContextPath()+"/','_top')");
//                out.println("</script>");
//                out.println("</html>");
                ((HttpServletResponse) res).sendRedirect("/");
                return;

            }else {
                chain.doFilter(req, res);
            }
        }

    }

}
