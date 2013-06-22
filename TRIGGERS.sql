DROP TRIGGER tr_hist_equ;

DELIMITER $$

CREATE TRIGGER tr_hist_equ AFTER INSERT ON equipo
	FOR EACH ROW BEGIN
		SET @id = NEW.id_equipo;
		INSERT INTO historico_equipo (id_equipo) VALUES (id);
	END;
$$

DELIMITER ;