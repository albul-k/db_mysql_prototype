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