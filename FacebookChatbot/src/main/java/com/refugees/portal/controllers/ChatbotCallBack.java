package com.refugees.portal.controllers;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

import javax.inject.Singleton;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.github.messenger4j.MessengerPlatform;
import com.github.messenger4j.exceptions.MessengerApiException;
import com.github.messenger4j.exceptions.MessengerIOException;
import com.github.messenger4j.exceptions.MessengerVerificationException;
import com.github.messenger4j.receive.MessengerReceiveClient;
import com.github.messenger4j.receive.handlers.QuickReplyMessageEventHandler;
import com.github.messenger4j.receive.handlers.TextMessageEventHandler;
import com.github.messenger4j.send.MessengerSendClient;
import com.github.messenger4j.send.NotificationType;
import com.github.messenger4j.send.QuickReply;
import com.github.messenger4j.send.Recipient;
import com.github.messenger4j.send.SenderAction;
import com.refugees.portal.db.model.FacebookUser;
import com.refugees.portal.db.model.RefugeeUser;
import com.refugees.portal.db.model.Screening;
import com.refugees.portal.db.service.RefugeeService;
import com.refugees.portal.db.service.ScreenedBeforeException;

@RestController
@RequestMapping("/callback")
public class ChatbotCallBack {

	@Value("${fb.pageAccessToken}")
	private String pageAccessToken_;
	@Autowired
	ResourceBundle bundle;
	private final MessengerReceiveClient receiveClient;
	private static MessengerSendClient sendClient;
	private static final List<Integer> NotYesNoList = new ArrayList<>();
	static {
		NotYesNoList.add(5);
		NotYesNoList.add(6);
		NotYesNoList.add(9);
		NotYesNoList.add(11);
	}
	private final static String YES = "Yes";
	private final static String NO = "No";
	// private static final Map<String, Integer> usersSteps = new HashMap<>();
	@Autowired
	private Properties questions;
	private static final Logger logger = LoggerFactory.getLogger(ChatbotCallBack.class);

	@Autowired
	RefugeeService refugeeService;

	enum UserEvents {
		ASK_YES_NO, ASK_TEXT
	}

	@Autowired
	public ChatbotCallBack(@Value("${fb.random.key}") final String appSecret,
			@Value("${fb.verifyToken}") final String verifyToken, final MessengerSendClient sendClient) {
		this.receiveClient = MessengerPlatform.newReceiveClientBuilder(appSecret, verifyToken)
				.onTextMessageEvent(newTextMessageEventHandler())
				.onQuickReplyMessageEvent(newQuickReplyMessageEventHandler()).build();
		ChatbotCallBack.sendClient = sendClient;
		// allQuestions = refugeeService.getAllQuestions();
	}

	@GetMapping
	public ResponseEntity<String> verifyWebhook(@RequestParam("hub.mode") final String mode,
			@RequestParam("hub.verify_token") final String verifyToken,
			@RequestParam("hub.challenge") final String challenge) {
		try {
			return ResponseEntity.ok(this.receiveClient.verifyWebhook(mode, verifyToken, challenge));
		} catch (MessengerVerificationException e) {
			logger.warn("Webhook verification failed:", e);
			return ResponseEntity.status(HttpStatus.FORBIDDEN).body(e.getMessage());
		}
	}

	@PostMapping
	public ResponseEntity<Void> handleCallback(@RequestBody final String payload,
			@RequestHeader("X-Hub-Signature") final String signature) {
		try {
			this.receiveClient.processCallbackPayload(payload, signature);
			return ResponseEntity.status(HttpStatus.OK).build();
		} catch (MessengerVerificationException e) {
			logger.warn("Processing of callback payload failed:" + e.getMessage());
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
		}
	}

	// auto reply method
	private TextMessageEventHandler newTextMessageEventHandler() {
		return event -> {

			logger.info("Received TextMessageEvent: " + event);
			final String senderId = event.getSender().getId();
			try {
				//final String messageId = event.getMid();
				final String messageText = event.getText();
				final Date timestamp = event.getTimestamp();
				processInputMessage(senderId, messageText, timestamp);

			} catch (Exception e) {
				try {
					sendReadReceipt(senderId);
				} catch (Exception e1) {
					logger.warn(e1.getMessage(), e1);
				}
			}
		};
	}

	private void processInputMessage(String senderId, String messageText, Date timestamp) {
		FacebookUser user = refugeeService.findFacebookUser(senderId);
		// first time user scenario
		if (user == null) {
			System.out.println("First time user");
			try {
				// start tracking user's visit
				refugeeService.initiateFacebookUser(senderId);
			} catch (Exception e) {
				sendTextMessage(senderId,
						"You are very welcomed to our system and we wish if we can proceed now but we have a technical issue :(");
				return;
			}
			// Ask user for his username
			sendTextMessage(senderId, "Welcome to our system, please provide your username to proceed");
		} else {
			// Alread talked before but no username provided
			if (user.getUserName() == null) {
				System.out.println("we talked but we don't know each other scenario this time it should be user name");
				// check if text provided is username
				RefugeeUser refugeeUser = refugeeService.findRefugeeByUserName(messageText);
				// text provided is not username
				if (refugeeUser == null) {
					System.out.println("invalid username");
					sendTextMessage(senderId, "Sorry the user name:" + messageText
							+ " doesn't exist in our system, would you please double check and provide the correct one?");
				} else {
					System.out.println("User info was found");
					// user provided user name
					// update info and ask the first question
					user.setUserName(refugeeUser.getName());
					user.setUserId(refugeeUser.getId());
					refugeeService.updateFacebook(user);
					refugeeUser.setFacebookUserId(senderId);
					refugeeUser.setFacebookInfo("1");
					refugeeService.updateRefugeeUser(refugeeUser);
					Screening sc= refugeeService.createScreeningData(refugeeUser.getId());
					String message = bundle.getString("Q1");
					
					if (NotYesNoList.contains(1))
						sendTextMessage(senderId, message);
					else
						try {
							sendQuickReply(senderId, message);
						} catch (Exception e) {
							handleSendException(e);
						}
				}
			} else {
				// user already communicated and was asked ... this is an answer
				System.out.println("Welcome back known user");
				user.setScanningDate(timestamp);
				RefugeeUser refugeeUser = refugeeService.findRefugeeByUserName(user.getUserName());
				System.out.println(refugeeUser);
				Screening screeningData=null;
				try {
					screeningData = refugeeService.getUserScreeningData(refugeeUser.getId());
					
				} catch (ScreenedBeforeException e1) {
					sendTextMessage(senderId, "Thanks for passing by, we will communicate you once done processing");
					return;
				}
				int currentQuestionId = Integer.parseInt(refugeeUser.getFacebookInfo());
				System.out.println("Current under processing question: "+currentQuestionId);
				Integer nextQuestionId = refugeeService.findNextQuestion(refugeeUser.getFacebookInfo());
				System.out.println("Next Question to go is :"+nextQuestionId);
				
				if (nextQuestionId == null || nextQuestionId==0) {
					System.out.println("just finalizing our chat");
					refugeeService.addScreeningAnswer(currentQuestionId, screeningData.getId(), messageText);
					screeningData.setStatus("INITIAL");
					refugeeService.updateScreening(screeningData);
					screeningData.setCompletinggDate(new java.util.Date());
					refugeeService.updateScreening(screeningData);
					sendTextMessage(senderId, "Thanks very much for your time we will contact you ASAP");
					return;
				}
				System.out.println("Going through questioning process");
				refugeeService.addScreeningAnswer(currentQuestionId, screeningData.getId(), messageText);
				System.out.println("added pervious question answer");
				refugeeUser.setFacebookInfo("" + nextQuestionId);
				System.out.println("update fb info to reflect the next question id");
				user.setScanningDate(timestamp);
				refugeeService.updateFacebook(user);
				refugeeService.updateRefugeeUser(refugeeUser);
				System.out.println("Reflected updated scanning date");
				
				String message = bundle.getString("Q" + nextQuestionId);
				if (NotYesNoList.contains(nextQuestionId))
					sendTextMessage(senderId, message);
				else
					try {
						sendQuickReply(senderId, message);
					} catch (Exception e) {
						handleSendException(e);
					}
				System.out.println("done processing");
			}
		}

	}

	// private List<ScreeningQuestions> allQuestions;

	/*
	 * private void processMessage(String senderId) throws MessengerApiException,
	 * MessengerIOException { int currentStep = usersSteps.get(senderId);
	 * currentStep++; String questionKey = "Q" + currentStep; if
	 * (questions.containsKey(questionKey)) { if
	 * (NotYesNoList.contains(currentStep)) sendTextMessage(senderId,
	 * questions.getProperty(questionKey)); else sendQuickReply(senderId,
	 * questions.getProperty(questionKey)); usersSteps.put(senderId, currentStep); }
	 * else sendTextMessage(senderId,
	 * "your data now is complete, thanks for your time"); }
	 */
	// auto reply for call backs
	private QuickReplyMessageEventHandler newQuickReplyMessageEventHandler() {
		return event -> {
			logger.info("Received QuickReplyMessageEvent:" + event);

			final String senderId = event.getSender().getId();
			final String messageId = event.getMid();
			final String quickReplyPayload = event.getQuickReply().getPayload();

			logger.info(
					"Received quick reply for message '" + messageId + "' with payload '" + quickReplyPayload + "'");
			try {
				processInputMessage(senderId, quickReplyPayload, event.getTimestamp());
			} catch (Exception e) {
				handleSendException(e);
			}
		};
	}

	public static void sendTextMessage(String recipientId, String text) {
		try {
			final Recipient recipient = Recipient.newBuilder().recipientId(recipientId).build();
			final NotificationType notificationType = NotificationType.REGULAR;
			final String metadata = "DEVELOPER_DEFINED_METADATA";
			if (sendClient == null) {
				System.out.println("SendClient is null");
				return;
			}
			sendClient.sendTextMessage(recipient, notificationType, text, metadata);
		} catch (Exception e) {
			handleSendException(e);
		}
	}

	private void sendReadReceipt(String recipientId) throws MessengerApiException, MessengerIOException {
		if (sendClient == null) {
			System.out.println("SendClient is null");
			return;
		}
		sendClient.sendSenderAction(recipientId, SenderAction.MARK_SEEN);
	}

	private static void handleSendException(Exception e) {
		logger.warn("Message could not be sent. An unexpected error occurred." + e.getMessage());
	}

	private void sendQuickReply(String recipientId, String message) throws MessengerApiException, MessengerIOException {
		final List<QuickReply> quickReplies = QuickReply.newListBuilder().addTextQuickReply("Yes", YES).toList()
				.addTextQuickReply("No", NO).toList().build();

		ChatbotCallBack.sendClient.sendTextMessage(recipientId, message, quickReplies);
	}

	@Bean
	@Singleton
	public Properties getQuestions(@Value("${questions.properties.file}") final String filePath) {
		questions = new Properties();
		try {
			questions.load(new FileInputStream(filePath));
		} catch (IOException e) {
			logger.warn(e.getMessage(), e);
		}
		return questions;
	}

}
