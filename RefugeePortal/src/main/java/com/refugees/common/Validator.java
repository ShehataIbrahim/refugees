package com.refugees.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Validator {
	public static boolean validateSession(HttpServletRequest request) {
		HttpSession userSession = request.getSession(true);
		return (userSession.getAttribute("userData") != null);
	}
}
