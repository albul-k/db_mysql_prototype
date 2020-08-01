/*
При добавлении комментария, меняем столбец rating_ivi у медиафайла
Суммируем столбцы score_*, находим среднее и делим дополнительно на 400, чтобы оценка не давала сильный вклад в общую оценку, после чего округляем результат до одного знака после запятой
Итого, если пользователь выставляет 10, 10, 10, 10 то это даст вклад в общую оценку 0.1
*/

DELIMITER $$

CREATE TRIGGER media_feedbacks_on_insert
AFTER INSERT ON media_feedbacks
FOR EACH ROW
BEGIN
	UPDATE 
		media
	SET media.rating_ivi = media.rating_ivi + ROUND(((COALESCE(score_directing,0) + COALESCE(score_story,0) + COALESCE(score_entertainment,0) + COALESCE(score_actors,0))/4)/400,1)
	WHERE media.id = media_feedbacks.media_id AND media_feedbacks.feedback_type="comment";
END$$