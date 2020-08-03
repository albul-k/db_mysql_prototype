-- список email пользователей с закончившейся подпиской и разрешением на отправку новостей через email
CREATE VIEW emails_of_profiles_with_expired_subscription AS
SELECT
	email
FROM
	profiles
JOIN profile_settings ON
	profile_settings.profile_id = profiles.id
JOIN profile_subscriptions ON
	profile_subscriptions.profile_id = profiles.id
WHERE
	profile_settings.offer_by_email = 1 AND profile_subscriptions.status = 'ended';
SELECT * FROM emails_of_profiles_with_expired_subscription;


-- аналитика по медиафайлам в разрезе качества и занимаемого ими дискового пространства
CREATE VIEW analysis_of_media_files_by_bitrate AS
SELECT DISTINCT
	bitrate,
	COUNT(id) OVER w AS files_amount,
	AVG(`size`) OVER w AS average_size,
	SUM(`size`) OVER w AS total_size,
	CONCAT(ROUND(COUNT(id) OVER w / COUNT(id) OVER() * 100, 0),"%") AS "%"
FROM
	media_files
WINDOW w AS (PARTITION BY bitrate);
SELECT * FROM analysis_of_media_files_by_bitrate;
