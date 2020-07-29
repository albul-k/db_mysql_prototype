DROP DATABASE IF EXISTS ivi_db;

CREATE DATABASE ivi_db;

USE ivi_db;

CREATE TABLE profiles (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL COMMENT "���",
	last_name VARCHAR(100) NOT NULL COMMENT "�������",
	phone VARCHAR(100) NOT NULL UNIQUE COMMENT "�������",
	email VARCHAR(100) NOT NULL UNIQUE COMMENT "����������� �����",
	birthday DATE COMMENT "���� ��������",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� �������� �������",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� �������"
) COMMENT "������� ������������";

CREATE TABLE profile_settings (
	profile_id INT UNSIGNED NOT NULL COMMENT "������ �� ������� ������������",
	offer_by_sms BOOLEAN DEFAULT 0 COMMENT "������� � ����������� ����������� SMS",
	offer_by_email BOOLEAN DEFAULT 1 COMMENT "������� � ����������� ����������� SMS",
	offer_by_push BOOLEAN DEFAULT 0 COMMENT "������� � ����������� ����������� Push",
	myivi_by_sms BOOLEAN DEFAULT 0 COMMENT "�� �� ivi SMS",
	myivi_by_email BOOLEAN DEFAULT 1 COMMENT "�� �� ivi E-mail",
	myivi_by_push BOOLEAN DEFAULT 0 COMMENT "�� �� ivi Push",
	newitems_by_sms BOOLEAN DEFAULT 0 COMMENT "������� SMS",
	newitems_by_email BOOLEAN DEFAULT 1 COMMENT "������� E-mail",
	newitems_by_push BOOLEAN DEFAULT 0 COMMENT "������� Push",
	news_by_email BOOLEAN DEFAULT 1 COMMENT "������� ������� E-mail",
	news_by_push BOOLEAN DEFAULT 0 COMMENT "������� ������� Push",
	PRIMARY KEY (profile_id)
) COMMENT "��������� ������������";

CREATE TABLE profile_subscriptions (
	id SERIAL PRIMARY KEY,
	profile_id INT UNSIGNED NOT NULL COMMENT "������ �� ������� ������������",
	status ENUM('actual','suspended','ended') NOT NULL COMMENT "��������� ��������: ��������� / �������������� / �����������",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ��������",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ��������",
	ends_at DATETIME COMMENT "���� ��������� ��������"
) COMMENT "�������� ������������";

CREATE TABLE profile_purchases (
	id SERIAL PRIMARY KEY,
	profile_id INT UNSIGNED NOT NULL COMMENT "������ �� ������� ������������",
	media_id INT UNSIGNED NOT NULL COMMENT "������ �� �������� ����������",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� �������"
) COMMENT "������� ������������";

CREATE TABLE profile_devices (
	device_hash VARCHAR(100) NOT NULL UNIQUE COMMENT "���������� ��� ����������",
	device_type ENUM('tv','laptop','phone','tablet') NOT NULL COMMENT "��� ����������: �� / ������� / ������� / �������",
	device_OS ENUM('win','android','mac') NOT NULL COMMENT "������������ ������� ����������",
	is_actual BOOLEAN DEFAULT 1 COMMENT "���������� ������������ ��� ���",
	profile_id INT UNSIGNED NOT NULL COMMENT "������ �� ������� ������������",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ����������",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ������� ����������",
	PRIMARY KEY (device_hash)
) COMMENT "���������� ����������� � �������";

CREATE TABLE profile_views_list (
	profile_id INT UNSIGNED NOT NULL COMMENT "������ �� ������� ������������",
	media_id INT UNSIGNED NOT NULL COMMENT "������ �� �������� ����������",
	status ENUM('viewed','wished') NOT NULL COMMENT "��������� �������������� �����: ������������� / ��������",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ����� � ������",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ������� �����",
	PRIMARY KEY (profile_id, media_id)
) COMMENT "������� ������������� �����/ �������� �����������";

CREATE TABLE media_files (
	id SERIAL PRIMARY KEY,
	filename VARCHAR(255) NOT NULL COMMENT "������ �� ����",
	size INT NOT NULL COMMENT "������ �����",
	bitrate ENUM('low','medium','high','hd','hd1080','4K') NOT NULL COMMENT "�������",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ����������",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ����������"
) COMMENT "������� �����������";

CREATE TABLE media (
	id SERIAL PRIMARY KEY,
	media_files_id INT UNSIGNED NOT NULL COMMENT "������ �� ���������",
	trailer_id INT UNSIGNED COMMENT "������ �� ��������� � ��������� (������� media_files)",
	media_type ENUM('film','tv_series','sport','cartoon','trailer') NOT NULL COMMENT "��� ��������: ����� / ������ / ����� / ���������� / �������",
	title VARCHAR(100) NOT NULL COMMENT "��������",
	official_title VARCHAR(100) NOT NULL COMMENT "������������ ��������",
	description TEXT(5000) NOT NULL COMMENT "��������",
	year_release YEAR NOT NULL COMMENT "��� ������",
	age_limit ENUM('0+','6+','12+','16+','18+') NOT NULL COMMENT "���������� �����������: 0+ - 18+",
	country VARCHAR(130) COMMENT "������",
	rating_kinopoisk FLOAT(1) COMMENT "������� ���������",
	rating_imdb FLOAT(1) COMMENT "������� IMDB",
	rating_ivi FLOAT(1) COMMENT "������� ivi",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ���������� � ����������",
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ���������� � ����������"
) COMMENT "�������� � ����������";

CREATE TABLE media_feedbacks (
	id SERIAL PRIMARY KEY,
	media_id INT UNSIGNED NOT NULL COMMENT "������ �� �������� ����������",
	profile_id INT UNSIGNED NOT NULL COMMENT "������ �� ������� ������������",
	feedback_type ENUM('comment','review') NOT NULL COMMENT "��� ������: �����������, ��������",
	description TEXT(5000) NOT NULL COMMENT "��������",
	score_directing INT(10) UNSIGNED,
	score_story INT(10) UNSIGNED,
	score_entertainment INT(10) UNSIGNED, 
	score_actors INT(10) UNSIGNED,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ������"
) COMMENT "������/��������";

CREATE TABLE media_languages (
	media_id INT UNSIGNED NOT NULL COMMENT "������ �� �������� ����������",
	language ENUM('original','russian','english') NOT NULL,
	PRIMARY KEY (media_id, language)
) COMMENT "������ ������ �������";

CREATE TABLE media_hashtags (
	media_id INT UNSIGNED NOT NULL COMMENT "������ �� �������� ����������",
	hashtag VARCHAR(100) NOT NULL COMMENT "������",
	PRIMARY KEY (media_id, hashtag)
) COMMENT "������ ������ ���������";

CREATE TABLE media_genres (
	media_id INT UNSIGNED NOT NULL COMMENT "������ �� �������� ����������",
	genre ENUM('erotic','anime','biographical','thriller','western_film','military','detective','child','documentary','drama','historical','kinomix','comedy','concert','short','crime','melodrama','mystic','music','cartoon','musical','scientific','adventures','reality_show','family','sport','talk_show','horrors','fantastic','film_noir','fantasy') NOT NULL COMMENT "���� ������",
	PRIMARY KEY (media_id, genre)
) COMMENT "������ ������ ���������";

CREATE TABLE media_persons (
	media_id INT UNSIGNED NOT NULL COMMENT "������ �� �������� ����������",
	persons_id INT UNSIGNED NOT NULL COMMENT "������ �� �������",
	PRIMARY KEY (media_id, persons_id)
) COMMENT "������ ������ ���������";

CREATE TABLE persons (
	id SERIAL PRIMARY KEY,
	person_type ENUM('actor','producer') NOT NULL COMMENT "��� �������: �����/��������",
	first_name VARCHAR(100) NOT NULL COMMENT "���",
	last_name VARCHAR(100) NOT NULL COMMENT "�������",
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� �������"
) COMMENT "�������";

CREATE TABLE likes (
  id SERIAL PRIMARY KEY,
  profile_id INT UNSIGNED NOT NULL COMMENT "������ �� ������� ������������",
  target_id INT UNSIGNED NOT NULL COMMENT "������ �� ���������� ������",
  target_type ENUM('comment','review') NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT "���� ���������� ������"
) COMMENT "������ �������/��������";
