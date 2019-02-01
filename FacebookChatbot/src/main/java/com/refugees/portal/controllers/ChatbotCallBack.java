package com.refugees.portal.controllers;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

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
import com.github.messenger4j.receive.events.AccountLinkingEvent;
import com.github.messenger4j.receive.handlers.*;
import com.github.messenger4j.receive.handlers.TextMessageEventHandler;
import com.github.messenger4j.send.*;
import com.github.messenger4j.send.NotificationType;
import com.github.messenger4j.send.Recipient;
import com.github.messenger4j.send.SenderAction;

@RestController
@RequestMapping("/callback")
public class ChatbotCallBack {

	@Value("${fb.pageAccessToken}")
	private String pageAccessToken_;

	private final MessengerReceiveClient receiveClient;
	private final MessengerSendClient sendClient;
	private static final List<Integer> NotYesNoList = new ArrayList<>();
	static {
		NotYesNoList.add(3);
		NotYesNoList.add(5);
		NotYesNoList.add(6);
	}
	private final static String YES = "Yes";
	private final static String NO = "No";
	private static final Map<String, Integer> usersSteps = new HashMap<>();
	@Autowired
	private Properties questions;
	private static final Logger logger = LoggerFactory.getLogger(ChatbotCallBack.class);

	@Autowired
	public ChatbotCallBack(@Value("${fb.random.key}") final String appSecret,
			@Value("${fb.verifyToken}") final String verifyToken, final MessengerSendClient sendClient) {

		logger.info("Initializing MessengerReceiveClient - appSecret: {" + appSecret + "} | verifyToken: {"
				+ verifyToken + "}");
		this.receiveClient = MessengerPlatform.newReceiveClientBuilder(appSecret, verifyToken)
				.onTextMessageEvent(newTextMessageEventHandler())
				.onQuickReplyMessageEvent(newQuickReplyMessageEventHandler()).build();
		this.sendClient = sendClient;
	}

	@GetMapping
	public ResponseEntity<String> verifyWebhook(@RequestParam("hub.mode") final String mode,
			@RequestParam("hub.verify_token") final String verifyToken,
			@RequestParam("hub.challenge") final String challenge) {
		try {
			return ResponseEntity.ok(this.receiveClient.verifyWebhook(mode, verifyToken, challenge));
		} catch (MessengerVerificationException e) {
			logger.warn("Webhook verification failed:" , e);
			return ResponseEntity.status(HttpStatus.FORBIDDEN).body(e.getMessage());
		}
	}

	@PostMapping
	public ResponseEntity<Void> handleCallback(@RequestBody final String payload,
			@RequestHeader("X-Hub-Signature") final String signature) {
		logger.info("Received Messenger Platform callback - payload: " + payload + " | signature: " + signature);
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
				final String messageId = event.getMid();
				final String messageText = event.getText();

				final Date timestamp = event.getTimestamp();
				logger.info(
						"Received Message:" + messageId + "," + messageText + "," + senderId + "," + timestamp);
				if (!usersSteps.containsKey(senderId)) {
					sendTextMessage(senderId, "Hello, can you please provide your name to start filling your info?");
					usersSteps.put(senderId, 0);
				} else {
					processMessage(senderId);
				}
			} catch (Exception e) {
				try {
					sendReadReceipt(senderId);
				} catch (Exception e1) {
					logger.warn(e1.getMessage(),e1);
				}
			}
		};
	}

	private void processMessage(String senderId) throws MessengerApiException, MessengerIOException {
		int currentStep = usersSteps.get(senderId);
		currentStep++;
		String questionKey = "Q" + currentStep;
		if (questions.containsKey(questionKey)) {
			if (NotYesNoList.contains(currentStep))
				sendTextMessage(senderId, questions.getProperty(questionKey));
			else
				sendQuickReply(senderId, questions.getProperty(questionKey));
			usersSteps.put(senderId, currentStep);
		} else
			sendTextMessage(senderId, "your data now is complete, thanks for your time");
	}

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
				if (quickReplyPayload.equals(YES))
					processMessage(senderId);
				else {
					int currentStep = usersSteps.get(senderId);
					if (currentStep == 2) {
						usersSteps.put(senderId, 3);
					}else if (currentStep == 4) {
						usersSteps.put(senderId, 6);
					}
					processMessage(senderId);
				}

			} catch (Exception e) {
				handleSendException(e);
			}
		};
	}

	private void sendTextMessage(String recipientId, String text) {
		try {
			final Recipient recipient = Recipient.newBuilder().recipientId(recipientId).build();
			final NotificationType notificationType = NotificationType.REGULAR;
			final String metadata = "DEVELOPER_DEFINED_METADATA";

			this.sendClient.sendTextMessage(recipient, notificationType, text, metadata);
		} catch (Exception e) {
			handleSendException(e);
		}
	}

	private void sendReadReceipt(String recipientId) throws MessengerApiException, MessengerIOException {
		this.sendClient.sendSenderAction(recipientId, SenderAction.MARK_SEEN);
	}

	private void handleSendException(Exception e) {
		logger.warn("Message could not be sent. An unexpected error occurred." + e.getMessage());
	}

	private void sendQuickReply(String recipientId, String message) throws MessengerApiException, MessengerIOException {
		final List<QuickReply> quickReplies = QuickReply.newListBuilder().addTextQuickReply("Yes", YES).toList()
				.addTextQuickReply("No", NO).toList().build();

		this.sendClient.sendTextMessage(recipientId, message, quickReplies);
	}

	@Bean
	@Singleton
	public Properties getQuestions(@Value("${questions.properties.file}") final String filePath) {
		questions = new Properties();
		try {
			questions.load(new FileInputStream(filePath));
		} catch (IOException e) {
			logger.warn(e.getMessage(),e);
		}
		return questions;
	}

}
