package com.refugees.servlets.user;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.lang3.StringUtils;

import com.refugees.common.Validator;
import com.refugees.db.model.RefugeeUser;
import com.refugees.db.service.RefugeeUserService;

import net.hitachifbbot.Consts;
import net.hitachifbbot.model.PasswordHash;
import net.hitachifbbot.servlet.AppServlet;

/**
 * Servlet implementation class UserLogin
 */
public class UserLoginServlet extends AppServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserLoginServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (Validator.validateSession(request)) {
			response.sendRedirect(Consts.USER_HOME_SERVLET_URL);
		} else
			forwardJSP("/user/login.jsp", request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//get user data
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		//data validations
		if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
			forwardJSPWithError("/user/login.jsp", request, response,"login.emptydata");
		}
		//try to load user info
		RefugeeUser user = RefugeeUserService.findUserByEmail(username);
		if (user == null) {
			forwardJSPWithError("/user/login.jsp", request, response,"login.invaliddata");
		} else {
			try {
				PasswordHash hash = new PasswordHash(user.getPassword(), user.getPasswordSalt());

				if (hash.isMatch(password)) {
					HttpSession userSession = request.getSession(true);
					userSession.setAttribute("userData", user);
					response.sendRedirect(Consts.USER_HOME_SERVLET_URL);

				}else
					forwardJSPWithError("/user/login.jsp", request, response,"login.invaliddata");
			} catch (Exception e) {
				log("Error user login", e);
				forwardJSPWithError("/user/login.jsp", request, response,"login.general_error");
			}
		}
	}
	private void forwardJSPWithError(String jsp,HttpServletRequest request,HttpServletResponse response, String messageCode) throws ServletException, IOException
	{
		request.setAttribute("errorMessage", messageCode);
		forwardJSP("/user/login.jsp", request, response);
	}
}
