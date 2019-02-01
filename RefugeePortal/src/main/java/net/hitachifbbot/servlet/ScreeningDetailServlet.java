package net.hitachifbbot.servlet;

import net.hitachifbbot.filter.CSRFFilter;
import net.hitachifbbot.utils.DBUtils;
import net.hitachifbbot.utils.Template;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class ScreeningDetailServlet extends AppServlet {

 /*   private List<String> questions = Arrays.asList(
            "Q1","Q2","Q3","Q4"
    );*/

    /**
     * GETメソッド処理
     */
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Integer namminID = Integer.parseInt(req.getParameter("n_id"));
        Integer categoryID = Integer.parseInt(req.getParameter("c_id"));
        try{
            List<ScreeningDetail> detail = DBUtils.preparedStatement("select sa.screening_q_id,sq.screening_q_text ,sa.answer from view_last_screening_answer as sa " +
                            "join screening_q as sq on sq.screening_q_id = sa.screening_q_id " +
                            "where sa.nammin_id = ? AND sq.category_id = ? order by sa.screening_q_id;", // 選択されたカテゴリの問診結果を取得する
                    ps -> {
                        ps.setInt(1, namminID);
                        ps.setInt(2, categoryID);
                    },
                    r -> {
                        List<ScreeningDetail> list = new ArrayList<>();
                        while(r.next()){
                            int i = 0;
                            int questionId = r.getInt(++i) - 1;
                            list.add(new ScreeningDetail(
                            		r.getString(++i),
                                    r.getString(++i),
                                    questionId
                            ));
                        }
                        return list;
                    });

            // Select Answer ID , Answer text
            HashMap<String, String> answers = DBUtils.preparedStatement("select na.nammin_q_id, na.answer from nammin_answer as na where na.nammin_id = ?;",
                    ps -> {
                        ps.setInt(1, namminID);
                    },
                    r -> {
                        HashMap<String, String> map = new HashMap<String, String>();
                        while(r.next()){
                            int i = 0;
                            map.put(r.getString(++i), r.getString(++i));
                        }
                        return map;
                    });

            String categoryName = DBUtils.preparedStatement("select sc.category_name from screening_category as sc where sc.category_id = ?;",
                    ps -> {
                        ps.setInt(1, categoryID);
                    },
                    r -> {
                        r.next();
                        return r.getString(1);
                    });

            LocalDate ld = LocalDate.parse(answers.get("3"), DateTimeFormatter.ofPattern("yyyyMMdd"));
            int age = Period.between(ld, LocalDate.now()).getYears();


            HashMap<String,Object> map = new HashMap<String,Object>(){{
                put("namminID", namminID);
                put("details", detail);
                put("nammin_name", answers.get("1"));
                put("nammin_sex", answers.get("2"));
                put("nammin_age", age);
                put("category_name", categoryName);
                put("category_id", categoryID);
                put("csrfTokenName", CSRFFilter.CSRF_TOKEN_PARAM_NAME);
                put("csrfToken", CSRFFilter.getCSRFToken(req));
                put("csrfToken2", CSRFFilter.getCSRFToken(req));
            }};
            Template.responseTranslated("doctor/personal_details",map,req,resp);
        }catch (SQLException e) {
            throw new IOException(e);
        }
    }

    /**
     * POST
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
    }
	private final static List<Integer> YES_NO_QUESTIONS;
	static {
		YES_NO_QUESTIONS=new ArrayList<Integer>();
		YES_NO_QUESTIONS.add(0);
		YES_NO_QUESTIONS.add(1);
		YES_NO_QUESTIONS.add(2);
		YES_NO_QUESTIONS.add(3);
		YES_NO_QUESTIONS.add(6);
		YES_NO_QUESTIONS.add(7);
		YES_NO_QUESTIONS.add(9);
		YES_NO_QUESTIONS.add(11);
		YES_NO_QUESTIONS.add(12);
		YES_NO_QUESTIONS.add(13);
		YES_NO_QUESTIONS.add(14);
		YES_NO_QUESTIONS.add(15);
		YES_NO_QUESTIONS.add(16);
		YES_NO_QUESTIONS.add(17);
		YES_NO_QUESTIONS.add(18);
	}
    public class ScreeningDetail{
    
        public String question;
        public String answer;
        public int questionId;

        public ScreeningDetail(String question, String answer, int questionId){
            this.question = question;
            this.answer = answer;
            this.questionId = questionId;
        }

        public String getQuestion() {
            return question;
        }

        public String getAnswer() {
        	/* eliminating translator should go this way
        	if(YES_NO_QUESTIONS.contains(this.questionId))
        	{
        		if("1".equals(answer))
        			answer="yes";
        		else
        			answer="no";
        	}*/
            return answer;
        }

        public int getQuestionId() {
            return questionId;
        }
    }
}
//select sa.answer from screening_answer as sa join screening_q as sq on sq.screening_q_id = sa.screening_q_id where sa.screening_id = 1 and sq.category_id = 1;