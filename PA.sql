
DROP PROCEDURE IF EXISTS insertar_jugador;
DROP PROCEDURE IF EXISTS insertar_equipo;
DROP PROCEDURE IF EXISTS insertar_entrenador;
DROP PROCEDURE IF EXISTS insertar_tecnico;
DROP PROCEDURE IF EXISTS insertar_arbitro;
DROP PROCEDURE IF EXISTS insertar_partido;
DROP PROCEDURE IF EXISTS insertar_campeonato;
DROP PROCEDURE IF EXISTS asingar_partido_arbitro;
DROP PROCEDURE IF EXISTS insertar_equipo_en_campeonato;
DROP PROCEDURE IF EXISTS insertar_gol;
DROP PROCEDURE IF EXISTS cambio_jugador;
DROP PROCEDURE IF EXISTS cambio_tecnico;
DROP PROCEDURE IF EXISTS cambio_entrenador;

DELIMITER $$

CREATE PROCEDURE insertar_jugador (nacionalidad VARCHAR(45),  
								nombres VARCHAR(45), apellidos VARCHAR(45),  nombre_equ VARCHAR(45), numero_camiseta INT, fecha DATETIME, salario DOUBLE)
	BEGIN	
	DECLARE edad INT DEFAULT year(curdate()) - year(fecha);
	START TRANSACTION;		
		SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_equ);
		INSERT INTO jugador (nacionalidad_jugador, edad_jugador, nombres_jugador, apellidos_jugador, numero_jugador, fechaNacimiento_jugador, id_equipo, salario_jugador) 
					VALUES (nacionalidad,edad,nombres,apellidos, numero_camiseta, fecha, @id_equ, salario );
	COMMIT;
	END;
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE insertar_equipo (ciudad VARCHAR(45), nombre VARCHAR(45), nombre_tec VARCHAR(45), apellido_tec  VARCHAR(45))
	BEGIN
	START TRANSACTION;
		SET @id_tec = (SELECT id_tecnico FROM tecnico WHERE nombres_tecnico = nombre_tec  AND apellidos_tecnico = apellido_tec );
		INSERT INTO equipo (id_tecnico, ciudad_equipo, nombre_equipo, rendimiento_equipo) VALUES (@id_tec, ciudad, nombre, 'ESTANDAR');
	COMMIT;
	END;
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE insertar_entrenador(telefono VARCHAR(45), equipo VARCHAR(45), experiencia INT, 
									 nombres VARCHAR(45), apellidos VARCHAR(45), año INT, salario DOUBLE)
	BEGIN
	START TRANSACTION;
		SET @id_equipo = (SELECT id_equipo FROM equipo WHERE nombre_equipo = equipo);
		INSERT INTO entrenador (telefono_entrenador, experiencia_entrenador, apellidos_entrenador, nombres_entrenador, salario_entrenador, id_equipo)
						 VALUES( telefono, experiencia, apellidos, nombres, salario, @id_equipo );
	COMMIT;
	END;
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE insertar_tecnico(telefono VARCHAR(45), experiencia INT, nombres VARCHAR(45),
									apellidos VARCHAR(45), salario DOUBLE)
	BEGIN
	START TRANSACTION;
	INSERT INTO tecnico (telefono_tecnico,experiencia_tecnico, apellidos_tecnico, nombres_tecnico, salario_tecnico)
				  VALUES( telefono, experiencia, apellidos, nombres, salario );
	COMMIT;	
	END;
$$
DELIMITER ;

##########################################################################################
##########################################################################################
#Otros PA de inserción


DELIMITER $$
CREATE PROCEDURE insertar_arbitro( nombre VARCHAR(45), apellido VARCHAR(45), tipo VARCHAR(45) )
	BEGIN
	START TRANSACTION;
	INSERT INTO arbitro ( nombre_arbitro, apellido_arbitro, tipo_arbitro )VALUES( nombre, apellido, tipo );
	COMMIT;
	END;
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE insertar_partido( fecha DATETIME , ciudad VARCHAR(45), estadio VARCHAR(45), goles_loc INT, 
								   goles_vis INT, eq_local VARCHAR(45), eq_visitante VARCHAR(45), añ INT, sem INT)
	BEGIN 
	START TRANSACTION;
		SET @camp = (SELECT id_campeonato FROM campeonato WHERE semestre = sem AND año = añ);
		SET @id_loc = (SELECT id_equipo FROM equipo WHERE nombre_equipo = eq_local);
		SET @id_vis = (SELECT id_equipo FROM equipo WHERE nombre_equipo = eq_visitante);

		INSERT INTO partido (fecha_partido, ciudad_partido, estadio, goles_local, goles_visitante, id_local, id_visitante, id_campeonato  ) 
					 VALUES (fecha, ciudad, estadio, goles_loc, goles_vis, @id_loc, @id_vis, @camp);
	COMMIT;
	END;
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE insertar_campeonato(añ INT, sem INT)
	BEGIN
	START TRANSACTION;
		INSERT INTO campeonato (año, semestre) VALUES (añ, sem);
	COMMIT;
	END;
$$
DELIMITER ;




DELIMITER $$

CREATE PROCEDURE asingar_partido_arbitro(nombre VARCHAR(45), apellido VARCHAR(45), nombre_loc VARCHAR(45), 
										 nombre_vis VARCHAR(45), añ VARCHAR(45), sem VARCHAR(45))
	BEGIN
	START TRANSACTION;
	SET @id_arbitro = (SELECT id_arbitro FROM arbitro WHERE nombre_arbitro = nombre AND apellido_arbitro = apellido);
	SET @id_camp = (SELECT id_campeonato FROM campeonato WHERE semestre = sem AND año = añ);
	SET @id_local = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_loc );
	SET @id_vis = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_vis );
	SET @id_partido = (SELECT id_partido FROM partido WHERE id_local = @id_local AND id_visitante = @id_vis 
					   AND id_campeonato = @id_camp);
	
	INSERT INTO arbitro_partido VALUES(@id_arbitro, @id_partido);
	
	COMMIT;
	END;
$$
DELIMITER ;



DELIMITER $$

CREATE PROCEDURE insertar_equipo_en_campeonato(nombre_eq VARCHAR(45), añ INT, sem INT)
	BEGIN
	START TRANSACTION;
	SET @id_camp = (SELECT id_campeonato FROM campeonato WHERE año = añ AND semestre = sem);
	SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_eq);
	
	INSERT INTO posicion (id_campeonato, id_equipo)VALUES(@id_camp, @id_equ);
	COMMIT;
	END;
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE insertar_gol(minuto INT, tipo_gol VARCHAR(45), nom_jug VARCHAR(45), ape_jug VARCHAR(45),
							  nombre_loc VARCHAR(45), nombre_vis VARCHAR(45), añ INT, sem INT)
	BEGIN
	START TRANSACTION;
	SET @id_camp = (SELECT id_campeonato FROM campeonato WHERE semestre = sem AND año = añ);
	SET @id_local = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_loc );
	SET @id_vis = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_vis );
	SET @id_partido = (SELECT id_partido FROM partido WHERE id_local = @id_local AND id_visitante = @id_vis 
					   AND id_campeonato = @id_camp);
	SET @id_jug = (SELECT id_jugador FROM jugador WHERE nombres_jugador = nom_jug AND apellidos_jugador = ape_jug);

	INSERT INTO gol (tipo_gol, minuto, id_partido, id_jugador )VALUES(tipo_gol, minuto, @id_partido, @id_jug);
	COMMIT;

	END;

$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE cambio_jugador( nombres VARCHAR(45), apellidos VARCHAR(45), equipo_nuevo VARCHAR(45), numero_camiseta INT, salario DOUBLE)
	BEGIN
	START TRANSACTION;
	SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = equipo_nuevo);
	SET @id_jug = (SELECT id_jugador FROM jugador WHERE nombres_jugador = nombres AND apellidos_jugador = apellidos);
	UPDATE jugador SET id_equipo = @id_equ, numero_jugador = numero_camiseta, salario_jugador = salario WHERE id_jugador = @id_jug;
	COMMIT;
	END;
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE cambio_tecnico( nombres VARCHAR(45), apellidos VARCHAR(45), equipo_nuevo VARCHAR(45), salario DOUBLE) 
	BEGIN
	START TRANSACTION;
	SET @id_tec = (SELECT id_tecnico FROM tecnico WHERE nombres_tecnico = nombres AND apellidos_tecnico = apellidos);
	SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = equipo_nuevo);
	
	UPDATE tecnico SET salario_tecnico = salario WHERE id_tecnico = @id_tec;
	UPDATE equipo SET id_tecnico = @id_tec WHERE id_equipo = @id_equ;
	
	COMMIT;
	END;
$$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE cambio_entrenador( nombres VARCHAR(45), apellidos VARCHAR(45), equipo VARCHAR(45), salario DOUBLE )
	BEGIN 
	START TRANSACTION;
	SET @id_ent = (SELECT id_entrenador FROM entrenador WHERE nombres_entrenador = nombres AND apellidos_entrenador = apellidos);
	SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = equipo);

	UPDATE entrenador SET salario_entrenador = salario, id_equipo = @id_equ WHERE id_entrenador = @id_ent;
	COMMIT;
	END;
$$
DELIMITER ;

SELECT * FROM equipo;

/*CALL insertar_arbitro('asdasd', 'asdasd', 'pecora');
CALL insertar_tecnico('564654465', 7, 'Cruz', 'Andres', 1213213);
CALL insertar_equipo ('PecoraCity', 'PecoraTeam', 'MALO', 'Cruz', 'Andres');
CALL insertar_jugador('Cholo', 80, 'Zambrano', 'Pedro', 'PecoraTeam', 0, 10,'1985/03/03', 300000);
CALL insertar_campeonato(2013, 2);
CALL insertar_partido( curdate(), 'asdsadasd','asdasd', 8, 7, 'PecoraTeam', 'PecoraTeam', 2013, 2 );
CALL asingar_partido_arbitro('asdasd', 'asdasd', 'PecoraTeam', 'PecoraTeam', 2013, 2);
CALL insertar_gol (14, 'penal', 'Zambrano', 'Pedro', 'PecoraTeam', 'PecoraTeam', 2013, 2 );
CALL insertar_equipo_en_campeonato('PecoraTeam',2013,2);*/
