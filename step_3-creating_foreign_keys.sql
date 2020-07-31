USE ivi_db;

ALTER TABLE profile_settings
	ADD CONSTRAINT profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id);

ALTER TABLE profile_subscriptions
	ADD CONSTRAINT profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id);

ALTER TABLE profile_purchases
	ADD CONSTRAINT profile_id_fk FOREIGN KEY (profile_id) REFERENCES profile_purchases(id),
	ADD CONSTRAINT media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE profile_devices
	ADD CONSTRAINT profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id);

ALTER TABLE media
	ADD CONSTRAINT media_files_fk FOREIGN KEY (profile_id) REFERENCES media_files(id),
	ADD CONSTRAINT trailer_id_fk FOREIGN KEY (trailer_id) REFERENCES media_files(id);

ALTER TABLE media_feedbacks
	ADD CONSTRAINT profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id),
	ADD CONSTRAINT media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE media_languages
	ADD CONSTRAINT media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE media_hashtags
	ADD CONSTRAINT media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE media_genres
	ADD CONSTRAINT media_id_fk FOREIGN KEY (media_id) REFERENCES media(id);

ALTER TABLE media_persons
	ADD CONSTRAINT media_id_fk FOREIGN KEY (media_id) REFERENCES media(id),
	ADD CONSTRAINT persons_id_fk FOREIGN KEY (persons_id) REFERENCES persons(id);

ALTER TABLE likes
	ADD CONSTRAINT profile_id_fk FOREIGN KEY (profile_id) REFERENCES profiles(id),
	ADD CONSTRAINT target_id_fk FOREIGN KEY (target_id) REFERENCES media_feedbacks(id);