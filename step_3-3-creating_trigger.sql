/*
При добавлении комментария, меняем столбец rating_ivi у медиафайла
Суммируем столбцы score_*, находим среднее и делим дополнительно на 100 (итого делим на 400), чтобы оценка не давала сильный вклад в общую оценку, после чего округляем результат до одного знака после запятой
Итого, если пользователь выставляет 10, 10, 10, 10 то это даст вклад в общую оценку 0.1
*/

DELIMITER $$

DROP TRIGGER IF EXISTS media_feedbacks_on_insert$$
CREATE TRIGGER media_feedbacks_on_insert
AFTER INSERT ON media_feedbacks FOR EACH ROW
BEGIN
	IF NEW.feedback_type = "comment" THEN
		UPDATE 
			media
		SET media.rating_ivi = media.rating_ivi + ROUND((COALESCE(NEW.score_directing,0) + COALESCE(NEW.score_story,0) + COALESCE(NEW.score_entertainment,0) + COALESCE(NEW.score_actors,0))/400,1)
		
		WHERE media.id = NEW.media_id;
	END IF;
END$$

DELIMITER ;

SELECT
	media.id,
	media.media_type,
	media.rating_ivi,
	media_feedbacks.description,
	media_feedbacks.id
FROM
	media
JOIN media_feedbacks ON
	media_feedbacks.media_id = media.id
WHERE
	media.id = 3;

INSERT INTO media_feedbacks VALUES
	(NULL, 3, 1, 'comment', 'test description', 10, 10, 10, 10, NULL);