drop trigger if exists equipo_insert_constraint;
drop trigger if exists arbitro_insert_constraint;
drop trigger if exists jugador_insert_constraint;
drop trigger if exists tecnico_insert_constraint;
drop trigger if exists entrenador_insert_constraint;
drop trigger if exists partido_insert_constraint;

drop trigger if exists equipo_update_constraint;
drop trigger if exists arbitro_update_constraint;
drop trigger if exists jugador_update_constraint;
drop trigger if exists tecnico_update_constraint;
drop trigger if exists entrenador_update_constraint;
drop trigger if exists partido_update_constraint;

drop trigger if exists jugador_update;
drop trigger if exists entrenador_update;
drop trigger if exists tecnico_update;

-- ------------ INSERT CONSTRAINT TRIGGERS

DELIMITER $$
CREATE TRIGGER equipo_insert_constraint BEFORE INSERT ON equipo FOR EACH ROW
BEGIN
  DECLARE msg varchar(255);
	IF (!(NEW.nombre_equipo regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint equipo_insert_constraint violated in attribute nombre_equipo with value ', NEW.nombre_equipo);
        SIGNAL sqlstate '45000' SET message_text = msg;
	END IF;
END;
$$

DELIMITER $$
CREATE TRIGGER arbitro_insert_constraint BEFORE INSERT ON arbitro FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombre_arbitro regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint arbitro_insert_constraint violated in attribute nombre_arbitro with value ', NEW.nombre_arbitro);
        SIGNAL sqlstate '45000' SET message_text = msg;
ELSEIF (!(NEW.apellido_arbitro regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint arbitro_insert_constraint violated in attribute apellido_arbitro with value ', NEW.apellido_arbitro);
        SIGNAL sqlstate '45000' SET message_text = msg;
	
	END IF;
END;
$$


DELIMITER $$
CREATE TRIGGER jugador_insert_constraint BEFORE INSERT ON jugador FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombres_jugador regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint jugador_insert_constraint violated in attribute nombres_jugador with value ', NEW.nombres_jugador);
        SIGNAL sqlstate '45000' SET message_text = msg;
ELSEIF (!(NEW.apellidos_jugador regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint jugador_insert_constraint violated in attribute apellidos_jugador with value ', NEW.apellidos_jugador);
        SIGNAL sqlstate '45000' SET message_text = msg;
	
	END IF;
    
  IF ((NEW.salario_jugador)<0)
  THEN
    SET msg = concat('Constraint jugador_insert_constraint violated in attribute salario_jugador with value ', NEW.salario_jugador);
        SIGNAL sqlstate '45000' SET message_text = msg;
   END IF;
   
END;
$$
	
DELIMITER $$
CREATE TRIGGER tecnico_insert_constraint BEFORE INSERT ON tecnico FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombres_tecnico regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint tecnico_insert_constraint violated in attribute nombres_tecnico with value ', NEW.nombres_tecnico);
        SIGNAL sqlstate '45000' SET message_text = msg;
ELSEIF (!(NEW.apellidos_tecnico regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint tecnico_insert_constraint violated in attribute apellidos_tecnico with value ', NEW.apellidos_tecnico);
        SIGNAL sqlstate '45000' SET message_text = msg;
	
	END IF;
    
  IF ((NEW.salario_tecnico)<0)
  THEN
    SET msg = concat('Constraint tecnico_insert_constraint violated in attribute salario_tecnico with value ', NEW.salario_tecnico);
        SIGNAL sqlstate '45000' SET message_text = msg;
   END IF;
   
END;
$$

DELIMITER $$
CREATE TRIGGER entrenador_insert_constraint BEFORE INSERT ON entrenador FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombres_entrenador regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint entrenador_insert_constraint violated in attribute nombres_entrenador with value ', NEW.nombres_entrenador);
        SIGNAL sqlstate '45000' SET message_text = msg;
ELSEIF (!(NEW.apellidos_entrenador regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint entrenador_insert_constraint violated in attribute apellidos_entrenador with value ', NEW.apellidos_entrenador);
        SIGNAL sqlstate '45000' SET message_text = msg;
	
	END IF;
    
  IF ((NEW.salario_entrenador)<0)
  THEN
    SET msg = concat('Constraint entrenador_insert_constraint violated in attribute salario_entrenador with value ', NEW.salario_entrenador);
        SIGNAL sqlstate '45000' SET message_text = msg;
   END IF;
   
END;
$$


DELIMITER $$
CREATE TRIGGER partido_insert_constraint BEFORE INSERT ON partido FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.goles_local >= 0))
	THEN 
		SET msg = concat('Constraint goles_positivos violated in attribute goles_local with value ', NEW.goles_local);
        SIGNAL sqlstate '45000' SET message_text = msg;
	ELSEIF (!(NEW.goles_visitante >= 0))
	THEN
		SET msg = concat('Constraint goles_positivos violated in attribute goles_visitante with value ', NEW.goles_visitante);
        SIGNAL sqlstate '45000' SET message_text = msg;
	END IF;
    
  IF ((select count(*) from partido where fecha_partido like new.fecha_partido)>0)
	THEN 
    
    IF((select count(*) from partido where ciudad_partido like new.ciudad_partido)>0)
    THEN
		SET msg = concat('Constraint insert_partido violated: El partido ya se jugo');
        SIGNAL sqlstate '45000' SET message_text = msg;
    END IF;
    
  END IF;
  
  
  
END;
$$

-- ------------ UPDATE CONSTRAINT TRIGGERS

DELIMITER $$
CREATE TRIGGER equipo_update_constraint BEFORE UPDATE ON equipo FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombre_equipo regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint equipo_update_constraint violated in attribute nombre_equipo with value ', NEW.nombre_equipo);
        SIGNAL sqlstate '45000' SET message_text = msg;
	END IF;
END;
$$

DELIMITER $$
CREATE TRIGGER arbitro_update_constraint BEFORE UPDATE ON arbitro FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombre_arbitro regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint arbitro_update_constraint violated in attribute nombre_arbitro with value ', NEW.nombre_arbitro);
        SIGNAL sqlstate '45000' SET message_text = msg;
ELSEIF (!(NEW.apellido_arbitro regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint arbitro_update_constraint violated in attribute apellido_arbitro with value ', NEW.apellido_arbitro);
        SIGNAL sqlstate '45000' SET message_text = msg;
	
	END IF;
END;
$$


DELIMITER $$
CREATE TRIGGER jugador_update_constraint BEFORE UPDATE ON jugador FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombres_jugador regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint jugador_update_constraint violated in attribute nombres_jugador with value ', NEW.nombres_jugador);
        SIGNAL sqlstate '45000' SET message_text = msg;
ELSEIF (!(NEW.apellidos_jugador regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint jugador_update_constraint violated in attribute apellidos_jugador with value ', NEW.apellidos_jugador);
        SIGNAL sqlstate '45000' SET message_text = msg;
	
	END IF;
    
  IF ((NEW.salario_jugador)<0)
  THEN
    SET msg = concat('Constraint jugador_update_constraint violated in attribute salario_jugador with value ', NEW.salario_jugador);
        SIGNAL sqlstate '45000' SET message_text = msg;
   END IF;
   
END;
$$
	
DELIMITER $$
CREATE TRIGGER tecnico_update_constraint BEFORE UPDATE ON tecnico FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombres_tecnico regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint tecnico_update_constraint violated in attribute nombres_tecnico with value ', NEW.nombres_tecnico);
        SIGNAL sqlstate '45000' SET message_text = msg;
ELSEIF (!(NEW.apellidos_tecnico regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint tecnico_update_constraint violated in attribute apellidos_tecnico with value ', NEW.apellidos_tecnico);
        SIGNAL sqlstate '45000' SET message_text = msg;
	
	END IF;
    
  IF ((NEW.salario_tecnico)<0)
  THEN
    SET msg = concat('Constraint tecnico_update_constraint violated in attribute salario_tecnico with value ', NEW.salario_tecnico);
        SIGNAL sqlstate '45000' SET message_text = msg;
   END IF;
   
END;
$$

DELIMITER $$
CREATE TRIGGER entrenador_update_constraint BEFORE UPDATE ON entrenador FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.nombres_entrenador regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint entrenador_update_constraint violated in attribute nombres_entrenador with value ', NEW.nombres_entrenador);
        SIGNAL sqlstate '45000' SET message_text = msg;
ELSEIF (!(NEW.apellidos_entrenador regexp binary '^[A-Z]'))
	THEN
		SET msg = concat('Constraint entrenador_update_constraint violated in attribute apellidos_entrenador with value ', NEW.apellidos_entrenador);
        SIGNAL sqlstate '45000' SET message_text = msg;
	
	END IF;
    
  IF ((NEW.salario_entrenador)<0)
  THEN
    SET msg = concat('Constraint entrenador_update_constraint violated in attribute salario_entrenador with value ', NEW.salario_entrenador);
        SIGNAL sqlstate '45000' SET message_text = msg;
   END IF;
   
END;
$$


DELIMITER $$
CREATE TRIGGER partido_update_constraint BEFORE UPDATE ON partido FOR EACH ROW
BEGIN
	DECLARE msg varchar(255);
	IF (!(NEW.goles_local >= 0))
	THEN 
		SET msg = concat('Constraint goles_positivos violated in attribute goles_local with value ', NEW.goles_local);
        SIGNAL sqlstate '45000' SET message_text = msg;
	ELSEIF (!(NEW.goles_visitante >= 0))
	THEN
		SET msg = concat('Constraint goles_positivos violated in attribute goles_visitante with value ', NEW.goles_visitante);
        SIGNAL sqlstate '45000' SET message_text = msg;
	END IF;
    
  IF ((select count(*) from partido where fecha_partido like new.fecha_partido)>0)
	THEN 
    
    IF((select count(*) from partido where ciudad_partido like new.ciudad_partido)>0)
    THEN
		SET msg = concat('Constraint update_partido violated: El partido ya se jugo');
        SIGNAL sqlstate '45000' SET message_text = msg;
    END IF;
    
  END IF;
  
  
  
END;
$$

-- Inserciones en historicos -- 

DELIMITER $$
CREATE TRIGGER jugador_update AFTER UPDATE ON jugador FOR EACH ROW
BEGIN
    set @Añojug = (select Year(CURDATE()));
    insert into historico_jugadores 
        values(old.id_equipo,old.id_jugador,@Añojug,old.numero_jugador,old.goles_jugador);
    
END;
$$

DELIMITER $$
CREATE TRIGGER entrenador_update AFTER UPDATE ON entrenador FOR EACH ROW
BEGIN
    set @Añoentre = (select Year(CURDATE()));
    insert into historico_entrenadores 
        values(old.id_equipo,old.id_entrenador,old.salario_entrenador,@Añoentre);
    
END;
$$

DELIMITER $$
CREATE TRIGGER tecnico_update AFTER UPDATE ON tecnico FOR EACH ROW
BEGIN
    
    set @oldequipo = (select id_equipo from equipo where id_tecnico like old.id_tecnico);
    insert into historico_entrenadores 
        values(@oldequipo,old.id_tecnico,old.telefono_tecnico,old.experiencia_tecnico,old.salario_tecnico);
    
END;
$$



