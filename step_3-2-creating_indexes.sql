USE ivi_db;

-- profiles
CREATE UNIQUE INDEX profiles_email_idx ON profiles(email);
CREATE UNIQUE INDEX profiles_phone_idx ON profiles(phone);

-- profile_subscriptions
CREATE INDEX profile_subscriptions_status_idx ON profile_subscriptions(status);

-- media
CREATE INDEX media_media_type_idx ON media(media_type);
CREATE INDEX media_title_idx ON media(title);
CREATE INDEX media_official_title_idx ON media(official_title);
CREATE INDEX media_year_release_idx ON media(year_release);
CREATE INDEX media_age_limit_idx ON media(age_limit);
CREATE INDEX media_country_idx ON media(country);

-- media_languages
CREATE INDEX media_languages_language_idx ON media_languages(language);

-- media_hashtags
CREATE INDEX media_hashtags_hashtag_idx ON media_hashtags(hashtag);

-- media_genres
CREATE INDEX media_genres_genre_idx ON media_genres(genre);