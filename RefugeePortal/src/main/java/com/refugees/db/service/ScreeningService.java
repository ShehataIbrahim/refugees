package com.refugees.db.service;

import net.hitachifbbot.utils.DBUtils;

public class ScreeningService {
	public static boolean checkUserHasPendingScreening(int userId) {
		try {
			return DBUtils.preparedStatement(
					"select sa.screening_q_id,sq.screening_q_text ,sa.answer from view_last_screening_answer as sa "
							+ "join screening_q as sq on sq.screening_q_id = sa.screening_q_id "
							+ "where sa.status='INITIAL' AND sa.nammin_id = ? order by sa.screening_q_id;",
					ps -> {
						ps.setInt(1, userId);
					}, r -> {
						if (r.next()) {
							return true;
						}
						return false;
					});
		} catch (Exception e) {
			return false;
		}
	}
}
