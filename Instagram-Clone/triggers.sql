DELIMITER $$
-- prevent users from following themselves
CREATE TRIGGER prevent_self_follows
	BEFORE INSERT ON follows FOR EACH ROW
	BEGIN
		IF NEW.follower_id = NEW.followee_id
		THEN
			SIGNAL SQLSTATE '45000'
				SET MESSAGE_TEXT = 'You cannot follow yourself.';
		END IF;
	END;

$$

DELIMITER ;

-- testing the trigger, show give error
INSERT INTO follows(follower_id, followee_id) VALUES(5,5);




DELIMITER $$
-- keeps meta data of users unfollowing people
CREATE TRIGGER capture_unfollows
	AFTER DELETE ON follows FOR EACH ROW
	BEGIN
		INSERT INTO unfollows
		SET
		follower_id = OLD.follower_id,
		followee_id = OLD.followee_id;
	END;

$$

DELIMITER ;

-- testing the trigger, should move all delete items to unfollows table
DELETE FROM follows WHERE follower_id=2 AND followee_id=1;
DELETE FROM follows WHERE follower_id=3;


-- Show all triggers
SHOW TRIGGERS;

-- Removing Triggers
DROP TRIGGER prevent_self_follows;
