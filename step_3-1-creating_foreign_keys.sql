USE ivi_db;

ALTER TABLE profile_settings
	ADD CONSTRAINT profile_settings_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id);

ALTER TABLE profile_subscriptions
	ADD CONSTRAINT profile_subscriptions_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id);

ALTER TABLE profile_purchases
	ADD CONSTRAINT profile_purchases_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id),
	ADD CONSTRAINT profile_purchases_media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE profile_devices
	ADD CONSTRAINT profile_devices_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id);

ALTER TABLE profile_views_list
	ADD CONSTRAINT profile_views_list_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id),
	ADD CONSTRAINT profile_views_list_media_files_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE media
	ADD CONSTRAINT media_media_files_fk FOREIGN KEY (media_files_id) REFERENCES media_files(id);

ALTER TABLE media_feedbacks
	ADD CONSTRAINT media_feedbacks_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id),
	ADD CONSTRAINT media_feedbacks_media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE media_languages
	ADD CONSTRAINT media_languages_media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE media_hashtags
	ADD CONSTRAINT media_hashtags_media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE media_genres
	ADD CONSTRAINT media_genres_media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE likes
	ADD CONSTRAINT likes_profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id),
	ADD CONSTRAINT likes_target_id_fk FOREIGN KEY (target_id) REFERENCES media_feedbacks(id);