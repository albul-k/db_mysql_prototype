SHOW TABLES;

DESC media_files;
SELECT * FROM media_files LIMIT 100;
ALTER TABLE media_files MODIFY COLUMN id INT UNSIGNED AUTO_INCREMENT;
UPDATE media_files SET size = FLOOR(10000 + RAND() * 1000000) WHERE bitrate = "low";
UPDATE media_files SET size = FLOOR(100000 + RAND() * 1000000) WHERE bitrate = "medium";
UPDATE media_files SET size = FLOOR(5000000 + RAND() * 1000000) WHERE bitrate = "high";
UPDATE media_files SET size = FLOOR(7000000 + RAND() * 1000000) WHERE bitrate = "hd";
UPDATE media_files SET size = FLOOR(10000000 + RAND() * 1000000) WHERE bitrate = "hd1080";
UPDATE media_files SET size = FLOOR(20000000 + RAND() * 1000000) WHERE bitrate = "4K";
UPDATE media_files SET filename = CONCAT('https://dropbox.com/ivi_db/',filename,'.mpeg');
UPDATE media_files SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;



DESC media;
SELECT * FROM media LIMIT 100;
ALTER TABLE media MODIFY COLUMN id INT UNSIGNED AUTO_INCREMENT;
UPDATE media SET media_type = "film" WHERE media_type = "trailer";
ALTER TABLE media DROP COLUMN trailer_id;
ALTER TABLE media MODIFY COLUMN media_type ENUM('film','tv_series','sport','cartoon');
UPDATE media SET age_limit = "0+" WHERE media_type = "cartoon";
UPDATE media SET age_limit = "12+" WHERE media_type = "film";
DROP TABLE IF EXISTS countries;
CREATE TEMPORARY TABLE countries (name VARCHAR(150));
INSERT INTO countries VALUES ('Russian Federation'), ('USA'), ('Germany'), ('France'), ('Italy');
UPDATE media SET country = (SELECT name FROM countries ORDER BY RAND() LIMIT 1);
UPDATE
	media
SET
	rating_imdb = ROUND(4 + RAND() * 5, 1),
	rating_ivi = ROUND(3 + RAND() * 6, 1),
	rating_kinopoisk = ROUND(5 + RAND() * 4, 1);
UPDATE media SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;



DESC profiles;
SELECT * FROM profiles LIMIT 100;
ALTER TABLE profiles MODIFY COLUMN id INT UNSIGNED AUTO_INCREMENT;
UPDATE profiles SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;



DESC profile_settings;
SELECT * FROM profile_settings LIMIT 100;
UPDATE
	profile_settings
SET
	offer_by_sms = ROUND(RAND(), 0),
	offer_by_email = ROUND(RAND(), 0),
	offer_by_push = ROUND(RAND(), 0),
	myivi_by_sms = ROUND(RAND(), 0),
	myivi_by_email = ROUND(RAND(), 0),
	myivi_by_push = ROUND(RAND(), 0),
	newitems_by_email = ROUND(RAND(), 0),
	newitems_by_push = ROUND(RAND(), 0),
	newitems_by_sms = ROUND(RAND(), 0),
	news_by_email = ROUND(RAND(), 0),
	news_by_push = ROUND(RAND(), 0);



DESC profile_devices;
SELECT * FROM profile_devices LIMIT 100;
UPDATE profile_devices SET profile_id = FLOOR(1 + RAND() * 1000);
ALTER TABLE profile_devices MODIFY COLUMN device_OS ENUM('tv','win','android','mac');
UPDATE profile_devices SET device_OS = 'tv' WHERE device_type = "tv";
-- исправление дат добавления устройств, которые больше дат создания профиля
UPDATE
	profile_devices
JOIN profiles ON
	profile_devices.profile_id = profiles.id
SET
	profile_devices.created_at = profiles.created_at
WHERE
	profile_devices.created_at > profiles.created_at;
UPDATE profile_devices SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;



DESC profile_purchases;
SELECT * FROM profile_purchases LIMIT 100;
UPDATE profile_purchases SET profile_id = FLOOR(1 + RAND() * 1000);
UPDATE profile_purchases SET media_id = FLOOR(1 + RAND() * 20000);
UPDATE
	profile_purchases
JOIN profiles ON
	profile_purchases.profile_id = profiles.id
SET
	profile_purchases.created_at = profiles.created_at
WHERE
	profile_purchases.created_at > profiles.created_at;



DESC profile_subscriptions;
SELECT * FROM profile_subscriptions LIMIT 100;
UPDATE profile_subscriptions SET profile_id = FLOOR(1 + RAND() * 1000);
UPDATE
	profile_subscriptions
JOIN profiles ON
	profile_subscriptions.profile_id = profiles.id
SET
	profile_subscriptions.created_at = profiles.created_at
WHERE
	profile_subscriptions.created_at > profiles.created_at;
-- записываем в created_at текущую дату, вычитая из нее случайное количество лет от 1 до 5
UPDATE profile_subscriptions SET created_at = DATE_SUB(CURRENT_TIMESTAMP, INTERVAL FLOOR(1 + RAND() * 5) YEAR);
-- записываем в ends_at дату создания, добавляя к ней случайное количество лет от 1 до 5
UPDATE profile_subscriptions SET ends_at = DATE_ADD(created_at, INTERVAL FLOOR(1 + RAND() * 5) YEAR);
UPDATE profile_subscriptions SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;
UPDATE
	profile_subscriptions
SET
	status =
	(CASE
		FLOOR(RAND()* 3) WHEN 0 THEN "actual"
		WHEN 1 THEN "suspended"
		WHEN 2 THEN "ended"
	END);
UPDATE profile_subscriptions SET status = "ended" WHERE ends_at < CURRENT_TIMESTAMP;
UPDATE profile_subscriptions SET status = "actual" WHERE ends_at >= CURRENT_TIMESTAMP;
UPDATE
	profile_subscriptions
SET
	status =
	(CASE
		FLOOR(RAND()* 2) WHEN 0 THEN "actual"
		WHEN 1 THEN "suspended"
	END)
WHERE status = "actual";



DESC profile_views_list;
SELECT * FROM profile_views_list LIMIT 100;
UPDATE profile_views_list SET media_id = FLOOR(1 + RAND() * 20000);
UPDATE profile_views_list SET profile_id = FLOOR(1 + RAND() * 1000);
UPDATE
	profile_views_list
JOIN profiles ON
	profile_views_list.profile_id = profiles.id
SET
	profile_views_list.created_at = profiles.created_at
WHERE
	profile_views_list.created_at > profiles.created_at;
UPDATE profile_views_list SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;



DESC media_feedbacks;
SELECT * FROM media_feedbacks LIMIT 100;
ALTER TABLE media_feedbacks MODIFY COLUMN id INT UNSIGNED AUTO_INCREMENT;
UPDATE media_feedbacks SET media_id = FLOOR(1 + RAND() * 20000);
UPDATE media_feedbacks SET profile_id = FLOOR(1 + RAND() * 1000);
UPDATE
	media_feedbacks
JOIN media ON
	media_feedbacks.media_id = media.id
SET
	media_feedbacks.created_at = media.created_at
WHERE
	media_feedbacks.created_at > media.created_at;



DESC media_genres;
SELECT * FROM media_genres LIMIT 100;
ALTER TABLE media_genres DROP PRIMARY KEY;
ALTER TABLE media_genres ADD COLUMN id SERIAL PRIMARY KEY;
UPDATE media_genres SET media_id = FLOOR(1 + RAND() * 20000);



DESC media_hashtags;
SELECT * FROM media_hashtags LIMIT 100;
ALTER TABLE media_hashtags DROP PRIMARY KEY;
ALTER TABLE media_hashtags ADD COLUMN id SERIAL PRIMARY KEY;
UPDATE media_hashtags SET media_id = FLOOR(1 + RAND() * 20000);



DESC media_languages;
SELECT * FROM media_languages LIMIT 100;
ALTER TABLE media_languages DROP PRIMARY KEY;
ALTER TABLE media_languages ADD COLUMN id SERIAL;
ALTER TABLE media_languages ADD PRIMARY KEY (id, media_id, language);
UPDATE media_languages SET media_id = FLOOR(1 + RAND() * 20000);



DROP TABLE media_persons;
DROP TABLE persons;