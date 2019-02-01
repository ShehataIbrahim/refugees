package net.hitachifbbot;

import net.hitachifbbot.utils.DBUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class DB {

    public static NamminUser getNamminUserByMailAddress(String mailAddress) throws SQLException {
        return DBUtils.preparedStatement("SELECT * FROM nammin_user WHERE MAIL_ADDRESS = ?",
                ps -> {
                    ps.setString(1, mailAddress);
                },
                r -> {
                    if (!r.next()) {
                        return null;
                    }
                    return NamminUser.getFromResultSet(r);
                });
    }

    public static ArrayList<NamminAnswer> getNamminAnswer(int namminID) throws SQLException {
        return DBUtils.preparedStatement("select answer.nammin_id,answer.nammin_q_id,answer.answer,question.screening_q_text from nammin_answer answer inner join screening_q question on question.screening_q_id=answer.nammin_q_id WHERE nammin_id = ?",
                ps -> {
                    ps.setInt(1, namminID);
                },
                r -> {
                    ArrayList<NamminAnswer> result = new ArrayList<>();
                    while (r.next()) {
                        result.add(NamminAnswer.getFromResultSet(r));
                    }
                    return result;
                });
    }

    public static ArrayList<ScreeningResultSet> getLastScreeningAnswer(int namminID) throws SQLException {
        return DBUtils.preparedStatement("SELECT screening_q_id,answer,category_id,screening_q_text FROM view_last_screening_answer " +
                        "WHERE nammin_id = ?",
                ps -> {
                    ps.setInt(1, namminID);
                },
                r -> {
                    ArrayList<ScreeningResultSet> result = new ArrayList<>();
                    while (r.next()) {
                        result.add(
                                new ScreeningResultSet(
                                        r.getInt("screening_q_id"),
                                        r.getString("answer"),
                                        r.getInt("category_id") == 1,
                                        r.getString("screening_q_text")
                                )
                        );
                    }
                    return result;
                });
    }

    public static DoctorUser getDoctorUserByID(String userID) throws SQLException {
        return DBUtils.preparedStatement("SELECT * FROM doctor_user WHERE DOCTOR_ID = ?",
                ps -> {
                    ps.setString(1, userID);
                },
                r -> {
                    if (!r.next()) {
                        return null;
                    }
                    return DoctorUser.getFromResultSet(r);
                });
    }

    public static class NamminAnswer{
        /*
            nammin_id   INT REFERENCES nammin_user(nammin_id),
            nammin_q_id INT,
            answer      VARCHAR(1024)
         */
        public int namminID;
        public int namminQID;
        public String questionKey;
        public String answer;

        public String getQuestionKey() {
			return questionKey;
		}

		public void setQuestionKey(String questionKey) {
			this.questionKey = questionKey;
		}

		public NamminAnswer(int namminID, int namminQID, String answer) {
            this.namminID = namminID;
            this.namminQID = namminQID;
            this.answer = answer;
        }

        public NamminAnswer(int namminID, int namminQID, String questionKey, String answer) {
			super();
			this.namminID = namminID;
			this.namminQID = namminQID;
			this.questionKey = questionKey;
			this.answer = answer;
		}

		public static NamminAnswer getFromResultSet(ResultSet r) throws SQLException {
            return new NamminAnswer(
                    r.getInt("nammin_id"),
                    r.getInt("nammin_q_id"),
                    r.getString("screening_q_text"),
                    r.getString("answer")
            );
        }
    }

    public static class DoctorUser{
        /*
    doctor_id VARCHAR(256) PRIMARY KEY,
    pass_hash VARCHAR(128),
    pass_salt VARCHAR(128),
    translate_lang_code VARCHAR(10)
         */
        public String doctorID;
        public String passHash;
        public String passSalt;
        public String translateLangCode;

        public DoctorUser(String doctorID, String passHash, String passSalt, String translateLangCode) {
            this.doctorID = doctorID;
            this.translateLangCode = translateLangCode;
            this.passHash = passHash;
            this.passSalt = passSalt;
        }

        public static DoctorUser getFromResultSet(ResultSet r) throws SQLException {
            return new DoctorUser(
                    r.getString("doctor_id"),
                    r.getString("pass_hash"),
                    r.getString("pass_salt"),
                    r.getString("translate_lang_code")
            );
        }
    }

    public static class NamminUser{
        /*
    nammin_id                   SERIAL PRIMARY KEY,
    nammin_name                 VARCHAR(256),
    facebook_info               TEXT,
    mail_address                VARCHAR(256),
    pass_hash                   VARCHAR(128),
    pass_salt                   VARCHAR(128),
    translate_lang_code         VARCHAR(10),
    last_screening_time         DATE,
    last_screening_request_time DATE
        */
        public int namminID;
        public String namminName;
        public String facebookInfo;
        public String mailAddress;
        public String passHash;
        public String passSalt;
        public String translateLangCode;
        public Date lastScreeningTime;
        public Date lastScreeningRequestTime;

        public NamminUser(int namminID, String namminName, String facebookInfo, String mailAddress, String passHash, String passSalt, String translateLangCode, Date lastScreeningTime, Date lastScreeningRequestTime) {
            this.namminID = namminID;
            this.namminName = namminName;
            this.facebookInfo = facebookInfo;
            this.mailAddress = mailAddress;
            this.passHash = passHash;
            this.passSalt = passSalt;
            this.translateLangCode = translateLangCode;
            this.lastScreeningTime = lastScreeningTime;
            this.lastScreeningRequestTime = lastScreeningRequestTime;
        }

        public static NamminUser getFromResultSet(ResultSet r) throws SQLException {
            return new NamminUser(
                    r.getInt("nammin_id"),
                    r.getString("nammin_name"),
                    r.getString("facebook_info"),
                    r.getString("mail_address"),
                    r.getString("pass_hash"),
                    r.getString("pass_salt"),
                    r.getString("translate_lang_code"),
                    r.getTimestamp("last_screening_time"),
                    r.getTimestamp("last_screening_request_time")
            );
        }
    }


    public static class ScreeningAnswer{
        /*
    screening_id   INT REFERENCES screening(screening_id),
    screening_q_id INT REFERENCES screening_q(screening_q_id),
    answer         VARCHAR(1024)
        */
        public int screeningID;
        public int screeningQID;
        public String answer;

        public ScreeningAnswer(int screeningID, int screeningQID, String answer) {
            this.screeningID = screeningID;
            this.screeningQID = screeningQID;
            this.answer = answer;
        }

        public static ScreeningAnswer getFromResultSet(ResultSet r) throws SQLException {
            return new ScreeningAnswer(
                    r.getInt("screening_id"),
                    r.getInt("screening_q_id"),
                    r.getString("answer")
            );
        }
    }

    public static class ScreeningResultSet{
        /*
    screening_id   INT REFERENCES screening(screening_id),
    screening_q_id INT REFERENCES screening_q(screening_q_id),
    answer         VARCHAR(1024)
        */
        public int screeningQID;
        public String answer;
        /**
         * 初回検診か？
         */
        public boolean isFirstQuestion;
        public String questionKey;

        public ScreeningResultSet(int screeningQID, String answer, boolean isFirstQuestion,String questionKey) {
            this.screeningQID = screeningQID;
            this.answer = answer;
            this.isFirstQuestion = isFirstQuestion;
            this.questionKey=questionKey;
        }
    }
}
