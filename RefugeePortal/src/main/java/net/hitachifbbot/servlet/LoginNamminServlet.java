package net.hitachifbbot.servlet;

import net.hitachifbbot.Consts;
import net.hitachifbbot.DB;
import net.hitachifbbot.model.PasswordHash;
import net.hitachifbbot.node.HubotCaller;
import net.hitachifbbot.session.AppSession;
import net.hitachifbbot.utils.DBUtils;
import org.apache.commons.codec.DecoderException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.sql.SQLException;

public class LoginNamminServlet extends AppServlet {

    /**
     * GETメソッド処理
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        forwardJSP("/login/nammin.jsp",req,resp);
    }

    /**
     * POST処理
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            final String user = req.getParameter("user");
            final String password = req.getParameter("password");
            if(user == null || password == null){// 認証失敗
                req.setAttribute("retry", Boolean.TRUE);
                forwardJSP("/login/nammin.jsp",req,resp);
                return;
            }
            DB.NamminUser namminUser = DB.getNamminUserByMailAddress(user);

            if(namminUser == null){// 認証失敗
                req.setAttribute("retry", Boolean.TRUE);
                forwardJSP("/login/nammin.jsp",req,resp);
                return;
            }

            PasswordHash hash = new PasswordHash(namminUser.passHash,namminUser.passSalt);
            if(hash.isMatch(password)){ // 認証成功
                AppSession.NamminUserData userData = new AppSession.NamminUserData();
                userData.dbUserData = namminUser;

                AppSession.setUserData(req, userData);

                if (userData.dbUserData.lastScreeningRequestTime == null){ // 最終スクリーニング時間が指定されていない=スクリーニングまだなら
                    HubotCaller.requestScreening(userData.dbUserData.namminID);
                }

                resp.sendRedirect(Consts.NAMMIN_PORTAL_SERVLET_URL);
                return;
            }else{ // 認証失敗
                req.setAttribute("retry", Boolean.TRUE);
                forwardJSP("/login/nammin.jsp",req,resp);
                return;
            }
        } catch (SQLException | InvalidKeySpecException | NoSuchAlgorithmException | DecoderException e) {
            throw new IOException(e);
        }
    }
}
