package com.refugees.db.model;

import java.util.Date;

public class RefugeeUser {
	//@Id
	//@Column(name = "nammin_id")
	private Integer userId	;

	//@Column(name = "nammin_name")
	private String userName	;

	//@Column(name = "facebook_user_id")
	private String facebookId	;

	//@Column(name = "facebook_info")
	private String facebookInfo	;

	//@Column(name = "mail_address")
	private String email	;

	//@Column(name = "pass_hash")
	private String password	;

	//@Column(name = "pass_salt")
	private String passwordSalt	;

	//@Column(name = "translate_lang_code")
	private String defaultLanguage	;

	//@Column(name = "last_screening_time")
	private Date lastScreeningDate	;

	//@Column(name = "last_screening_request_time")
	private Date lastScreeningRequest;

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFacebookId() {
		return facebookId;
	}

	public void setFacebookId(String facebookId) {
		this.facebookId = facebookId;
	}

	public String getFacebookInfo() {
		return facebookInfo;
	}

	public void setFacebookInfo(String facebookInfo) {
		this.facebookInfo = facebookInfo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordSalt() {
		return passwordSalt;
	}

	public void setPasswordSalt(String passwordSalt) {
		this.passwordSalt = passwordSalt;
	}

	public String getDefaultLanguage() {
		return defaultLanguage;
	}

	public void setDefaultLanguage(String defaultLanguage) {
		this.defaultLanguage = defaultLanguage;
	}

	public Date getLastScreeningDate() {
		return lastScreeningDate;
	}

	public void setLastScreeningDate(Date lastScreeningDate) {
		this.lastScreeningDate = lastScreeningDate;
	}

	public Date getLastScreeningRequest() {
		return lastScreeningRequest;
	}

	public void setLastScreeningRequest(Date lastScreeningRequest) {
		this.lastScreeningRequest = lastScreeningRequest;
	}
	
}
