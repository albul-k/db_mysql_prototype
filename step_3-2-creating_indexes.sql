USE ivi_db;

-- profiles
CREATE UNIQUE INDEX profiles_email_idx ON profiles(email);
CREATE UNIQUE INDEX profiles_phone_idx ON profiles(phone);

-- profile_settings
CREATE INDEX profile_settings_offer_by_sms_idx ON profile_settings(offer_by_sms);
CREATE INDEX profile_settings_offer_by_email_idx ON profile_settings(offer_by_email);
CREATE INDEX profile_settings_offer_by_push_idx ON profile_settings(offer_by_push);
CREATE INDEX profile_settings_myivi_by_sms_idx ON profile_settings(myivi_by_sms);
CREATE INDEX profile_settings_myivi_by_email_idx ON profile_settings(myivi_by_email);
CREATE INDEX profile_settings_myivi_by_push_idx ON profile_settings(myivi_by_push);
CREATE INDEX profile_settings_newitems_by_sms_idx ON profile_settings(newitems_by_sms);
CREATE INDEX profile_settings_newitems_by_email_idx ON profile_settings(newitems_by_email);
CREATE INDEX profile_settings_newitems_by_push_idx ON profile_settings(newitems_by_push);
CREATE INDEX profile_settings_news_by_email_idx ON profile_settings(news_by_email);
CREATE INDEX profile_settings_news_by_push_idx ON profile_settings(news_by_push);

-- profile_subscriptions
CREATE INDEX profile_subscriptions_profile_id_idx ON profile_subscriptions(profile_id);
CREATE INDEX profile_subscriptions_status_idx ON profile_subscriptions(status);

-- profile_purchases
CREATE INDEX profile_purchases_profile_id_idx ON profile_purchases(profile_id);
CREATE INDEX profile_purchases_media_id_idx ON profile_purchases(media_id);

-- profile_devices
CREATE INDEX profile_devices_profile_id_idx ON profile_devices(profile_id);

-- media
CREATE INDEX media_media_files_id_idx ON media(media_files_id);
CREATE INDEX media_media_type_idx ON media(media_type);
CREATE INDEX media_title_idx ON media(title);
CREATE INDEX media_official_title_idx ON media(official_title);
CREATE INDEX media_year_release_idx ON media(year_release);
CREATE INDEX media_age_limit_idx ON media(age_limit);
CREATE INDEX media_country_idx ON media(country);
CREATE INDEX media_rating_kinopoisk_idx ON media(rating_kinopoisk);
CREATE INDEX media_rating_imdb_idx ON media(rating_imdb);
CREATE INDEX media_rating_ivi_idx ON media(rating_ivi);

-- media_feedbacks
CREATE INDEX media_feedbacks_media_id_idx ON media_feedbacks(media_id);
CREATE INDEX media_feedbacks_profile_id_idx ON media_feedbacks(profile_id);

-- media_languages
CREATE INDEX media_languages_media_id_idx ON media_languages(media_id);
CREATE INDEX media_languages_language_idx ON media_languages(language);

-- media_hashtags
CREATE INDEX media_hashtags_media_id_idx ON media_hashtags(media_id);
CREATE INDEX media_hashtags_hashtag_idx ON media_hashtags(hashtag);

-- media_genres
CREATE INDEX media_genres_media_id_idx ON media_genres(media_id);
CREATE INDEX media_genres_genre_idx ON media_genres(genre);

-- likes
CREATE INDEX likes_profile_id_idx ON likes(profile_id);
CREATE INDEX likes_target_id_idx ON likes(target_id);