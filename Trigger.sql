DELIMITER $$

CREATE TRIGGER mem_join
BEFORE INSERT
ON tb_member
FOR EACH ROW
BEGIN
	set NEW.createdAt = curdate();
END $$

DELIMITER ;