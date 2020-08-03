-- список email пользователей, у которых разрешена отправка предложений от ivi.ru
-- EXPLAIN SELECT
SELECT
	email
FROM
	profiles
JOIN profile_settings ON
	profile_settings.profile_id = profiles.id
WHERE
	profile_settings.offer_by_email = 1;

-- список email пользователей, у которых разрешена отправка предложений от ivi.ru и имеется приостановленная подписка
-- EXPLAIN SELECT
SELECT
	email
FROM
	profiles
JOIN profile_settings ON
	profile_settings.profile_id = profiles.id
JOIN profile_subscriptions ON
	profile_subscriptions.profile_id = profiles.id
WHERE
	profile_settings.offer_by_email = 1 AND profile_subscriptions.status = 'suspended';


-- список пользователей, отсортированный по количеству сделанных покупок в обратном порядке (ограничен до 100 пользователей)
-- EXPLAIN SELECT
SELECT
	profiles.id,
	CONCAT(profiles.first_name, ' ', profiles.last_name) AS name,
	COUNT(profile_purchases.profile_id) AS total_purchases
FROM
	profiles
LEFT JOIN profile_purchases ON
	profile_purchases.profile_id = profiles.id
GROUP BY
	profiles.id
ORDER BY
	total_purchases DESC, name
LIMIT 100;


-- тоже самое, только через WINDOW + подсчет количества привязанных устройств к пользователю
-- EXPLAIN SELECT DISTINCT
SELECT DISTINCT
	profiles.id,
	CONCAT(profiles.first_name, ' ', profiles.last_name) AS name,
	COUNT(profile_purchases.media_id) OVER w AS total_purchases,
	(SELECT COUNT(*) FROM profile_devices WHERE profile_devices.profile_id = profiles.id) AS total_devices
FROM
	profiles
LEFT JOIN profile_purchases ON
	profile_purchases.profile_id = profiles.id
JOIN media ON
	media.id = profile_purchases.media_id
WINDOW w AS (PARTITION BY profiles.id)
ORDER BY
	total_purchases DESC, name
LIMIT 100;


-- аналитика по медиафайлам в разрезе качества и занимаемого ими дискового пространства
SELECT DISTINCT
	bitrate,
	COUNT(id) OVER w AS files_amount,
	AVG(`size`) OVER w AS average_size,
	SUM(`size`) OVER w AS total_size,
	CONCAT(ROUND(COUNT(id) OVER w / COUNT(id) OVER() * 100, 0),"%") AS "%"
FROM
	media_files
WINDOW w AS (PARTITION BY bitrate);


-- аналитика по медиафайлам в разрезе типа медиафайла и занимаемого ими дискового пространства
SELECT DISTINCT
	media_type,
	COUNT(media.id) OVER w AS files_amount,
	SUM(media_files.size) OVER w AS total_size,
	CONCAT(ROUND(COUNT(media.id) OVER w / COUNT(media_files.id) OVER() * 100, 0),"%") AS "%"
FROM
	media
JOIN media_files ON
	media_files.id = media.media_files_id
WINDOW w AS (PARTITION BY media_type)
ORDER BY files_amount DESC;


-- аналитика по жанрам медиафайлов
SELECT DISTINCT
	genre,
	COUNT(id) OVER w AS files_amount,
	CONCAT(ROUND(COUNT(id) OVER w / COUNT(id) OVER() * 100, 0),"%") AS "%"
FROM
	media_genres
WINDOW w AS (PARTITION BY genre);