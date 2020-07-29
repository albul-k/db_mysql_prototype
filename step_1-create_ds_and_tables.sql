DROP DATABASE IF EXISTS ivi_db;

CREATE DATABASE ivi_db;

USE ivi_db;

CREATE TABLE profiles (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL COMMENT "Имя",
	last_name VARCHAR(100) NOT NULL COMMENT "Фамилия",
	phone VARCHAR(100) NOT NULL UNIQUE COMMENT "Телефон",
	email VARCHAR(100) NOT NULL UNIQUE COMMENT "Электронная почта",
	birthday DATE COMMENT "Дата рождения",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата создания профиля",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата обновления профиля"
) COMMENT "Профиль пользователя";

CREATE TABLE profile_settings (
	profile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на профиль пользователя",
	offer_by_sms BOOLEAN DEFAULT 0 COMMENT "Подарки и специальные предложения SMS",
	offer_by_email BOOLEAN DEFAULT 1 COMMENT "Подарки и специальные предложения SMS",
	offer_by_push BOOLEAN DEFAULT 0 COMMENT "Подарки и специальные предложения Push",
	myivi_by_sms BOOLEAN DEFAULT 0 COMMENT "Вы на ivi SMS",
	myivi_by_email BOOLEAN DEFAULT 1 COMMENT "Вы на ivi E-mail",
	myivi_by_push BOOLEAN DEFAULT 0 COMMENT "Вы на ivi Push",
	newitems_by_sms BOOLEAN DEFAULT 0 COMMENT "Новинки SMS",
	newitems_by_email BOOLEAN DEFAULT 1 COMMENT "Новинки E-mail",
	newitems_by_push BOOLEAN DEFAULT 0 COMMENT "Новинки Push",
	news_by_email BOOLEAN DEFAULT 1 COMMENT "Новости сервиса E-mail",
	news_by_push BOOLEAN DEFAULT 0 COMMENT "Новости сервиса Push",
	PRIMARY KEY (profile_id)
) COMMENT "Настройки пользователя";

CREATE TABLE profile_subscriptions (
	id SERIAL PRIMARY KEY,
	profile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на профиль пользователя",
	status ENUM('actual','suspended','ended') NOT NULL COMMENT "Состояние подписки: действует / приостановлена / закончилась",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата оформления подписки",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата обновления подписки",
	ends_at DATETIME COMMENT "Дата окончания подписки"
) COMMENT "Подписки пользователя";

CREATE TABLE profile_purchases (
	id SERIAL PRIMARY KEY,
	profile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на профиль пользователя",
	media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на карточку медиафайла",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата покупки"
) COMMENT "Покупки пользователя";

CREATE TABLE profile_devices (
	device_hash VARCHAR(100) NOT NULL UNIQUE COMMENT "Уникальный хэш устройства",
	device_type ENUM('tv','laptop','phone','tablet') NOT NULL COMMENT "Тип устройства: ТВ / нойтбук / телефон / планшет",
	device_OS ENUM('win','android','mac') NOT NULL COMMENT "Операционная система устройства",
	is_actual BOOLEAN DEFAULT 1 COMMENT "Устройство используемое или нет",
	profile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на профиль пользователя",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата добавления устройства",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата обновления статуса устройства",
	PRIMARY KEY (device_hash)
) COMMENT "Устройства привязанные к профилю";

CREATE TABLE profile_views_list (
	profile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на профиль пользователя",
	media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на карточку медиафайла",
	status ENUM('viewed','wished') NOT NULL COMMENT "Состояние просмотренного видео: просмотренное / желаемое",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата добавления видео в список",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата добавления статуса видео",
	PRIMARY KEY (profile_id, media_id)
) COMMENT "Таблица просмотренных видео/ желаемых просмотреть";

CREATE TABLE media_files (
	id SERIAL PRIMARY KEY,
	filename VARCHAR(255) NOT NULL COMMENT "Ссылка на файл",
	size INT NOT NULL COMMENT "Размер файла",
	bitrate ENUM('low','medium','high','hd','hd1080','4K') NOT NULL COMMENT "Битрейт",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата добавления медиафайла",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата обновления медиафайла"
) COMMENT "Таблица медиафайлов";

CREATE TABLE media (
	id SERIAL PRIMARY KEY,
	media_files_id INT UNSIGNED NOT NULL COMMENT "Ссылка на медиафайл",
	trailer_id INT UNSIGNED COMMENT "Ссылка на медиафайл с трейлером (таблица media_files)",
	media_type ENUM('film','tv_series','sport','cartoon','trailer') NOT NULL COMMENT "Тип контента: фильм / сериал / спорт / мультфильм / трейлер",
	title VARCHAR(100) NOT NULL COMMENT "Название",
	official_title VARCHAR(100) NOT NULL COMMENT "Оффициальное название",
	description TEXT(5000) NOT NULL COMMENT "Описание",
	year_release YEAR NOT NULL COMMENT "Год выхода",
	age_limit ENUM('0+','6+','12+','16+','18+') NOT NULL COMMENT "Возрастное ограничение: 0+ - 18+",
	country VARCHAR(130) COMMENT "Страна",
	rating_kinopoisk FLOAT(1) COMMENT "Рейтинг Кинопоиск",
	rating_imdb FLOAT(1) COMMENT "Рейтинг IMDB",
	rating_ivi FLOAT(1) COMMENT "Рейтинг ivi",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата добавления информации о медиафайле",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата обновления информации о медиафайле"
) COMMENT "Сведения о медиафайле";

CREATE TABLE media_feedbacks (
	id SERIAL PRIMARY KEY,
	media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на карточку медиафайла",
	profile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на профиль пользователя",
	feedback_type ENUM('comment','review') NOT NULL COMMENT "Тип отзыва: комментарий, рецензия",
	description TEXT(5000) NOT NULL COMMENT "Описание",
	score_directing INT(10) UNSIGNED,
	score_story INT(10) UNSIGNED,
	score_entertainment INT(10) UNSIGNED, 
	score_actors INT(10) UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата добавления отзыва"
) COMMENT "Отзывы/рецензии";

CREATE TABLE media_languages (
	media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на карточку медиафайла",
	language ENUM('original','russian','english') NOT NULL,
	PRIMARY KEY (media_id, language)
) COMMENT "Список языков озвучки";

CREATE TABLE media_hashtags (
	media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на карточку медиафайла",
	hashtag VARCHAR(100) NOT NULL COMMENT "Хэштег",
	PRIMARY KEY (media_id, hashtag)
) COMMENT "Список жанров медифайла";

CREATE TABLE media_genres (
	media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на карточку медиафайла",
	genre ENUM('erotic','anime','biographical','thriller','western_film','military','detective','child','documentary','drama','historical','kinomix','comedy','concert','short','crime','melodrama','mystic','music','cartoon','musical','scientific','adventures','reality_show','family','sport','talk_show','horrors','fantastic','film_noir','fantasy') NOT NULL COMMENT "Жанр фильма",
	PRIMARY KEY (media_id, genre)
) COMMENT "Список жанров медифайла";

CREATE TABLE media_persons (
	media_id INT UNSIGNED NOT NULL COMMENT "Ссылка на карточку медиафайла",
	persons_id INT UNSIGNED NOT NULL COMMENT "Ссылка на персону",
	PRIMARY KEY (media_id, persons_id)
) COMMENT "Список персон медифайла";

CREATE TABLE persons (
	id SERIAL PRIMARY KEY,
	person_type ENUM('actor','producer') NOT NULL COMMENT "Тип персоны: актер/режиссер",
	first_name VARCHAR(100) NOT NULL COMMENT "Имя",
	last_name VARCHAR(100) NOT NULL COMMENT "Фамилия",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата добавления персоны"
) COMMENT "Персоны";

CREATE TABLE likes (
  id SERIAL PRIMARY KEY,
  profile_id INT UNSIGNED NOT NULL COMMENT "Ссылка на профиль пользователя",
  target_id INT UNSIGNED NOT NULL COMMENT "Ссылка на получателя оценки",
  target_type ENUM('comment','review') NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "Дата добавления оценки"
) COMMENT "Оценки отзывов/рецензий";
