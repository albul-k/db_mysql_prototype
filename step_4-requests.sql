-- ������ email �������������, � ������� ��������� �������� ����������� �� ivi.ru
-- EXPLAIN SELECT
SELECT
	email
FROM
	profiles
JOIN profile_settings ON
	profile_settings.profile_id = profiles.id
WHERE
	profile_settings.offer_by_email = 1;

-- ������ email �������������, � ������� ��������� �������� ����������� �� ivi.ru � ������� ���������������� ��������
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


-- ������ �������������, ��������������� �� ���������� ��������� ������� � �������� ������� (��������� �� 100 �������������)
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


-- ���� �����, ������ ����� WINDOW
-- EXPLAIN SELECT DISTINCT
SELECT DISTINCT
	profiles.id,
	CONCAT(profiles.first_name, ' ', profiles.last_name) AS name,
	COUNT(media.id) OVER w AS total_purchases
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

