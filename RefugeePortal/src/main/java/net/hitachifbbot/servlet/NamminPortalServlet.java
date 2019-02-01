package net.hitachifbbot.servlet;

import net.hitachifbbot.Consts;
import net.hitachifbbot.DB;
import net.hitachifbbot.model.PasswordHash;
import net.hitachifbbot.session.AppSession;
import org.apache.commons.codec.DecoderException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.SQLException;

public class NamminPortalServlet extends AppServlet {

    /**
     * GETメソッド処理
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            if(DB.getLastScreeningAnswer(AppSession.getNamminUserData(req).dbUserData.namminID).size() == 0){
                req.setAttribute("noScreening", true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        forwardJSP("/nammin/portal.jsp",req,resp);
    }
}
