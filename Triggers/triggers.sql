-- DELIMITER used as marker for end of each command
-- 		sent to mysql command line client.
DELIMITER $$

-- trigger_name (must_be_adult)
CREATE TRIGGER must_be_adult
	-- trigger_time (BEFORE),
	-- trigger_event (INSERT),
	-- table_name (users)
	BEFORE INSERT ON users FOR EACH ROW
	BEGIN
		-- NEW is the data being inserted
		-- make sure the .age for NEW is <= 18
		IF NEW.age < 18
		THEN
			-- 'MySQL error, five-character sqlstate'
			-- 45000 - wild card error
			SIGNAL SQLSTATE '45000'
				-- personalized error message
				SET MESSAGE_TEXT = 'Must be an adult!';
		END IF;
	END;
$$

DELIMITER ;
