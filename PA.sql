/*
##PA CON EL MODELO 'VIEJO'
#Procedimiento para insertar jugadores (Los inserta también en el historico)
DELIMITER $$

CREATE PROCEDURE insertar_jugador (nacionalidad VARCHAR(45), edad INT, año INT, numero_c 
									INT, nombres VARCHAR(45), apellidos VARCHAR(45), nombre_equ VARCHAR(45), numero_goles INT)
	BEGIN	
	START TRANSACTION;
		SET @id_eq = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_equ);

		INSERT INTO jugador (nacionalidad_jugador, edad_jugador,nombres_jugador, apellidos_jugador) 
					VALUES (nacionalidad,edad,nombres,apellidos);

		SET @id_jug = (SELECT id_jugador FROM jugador 
					   WHERE nombres_jugador = nombres AND apellidos_jugador = apellidos );

		INSERT INTO historico_jugadores VALUES (@id_jug,@id_eq,año,numero_c, numero_goles);
	COMMIT;
	END; 
$$
DELIMITER ;

#Procedimiento para insertar equipos (Los inserta también en el historico)
#DROP PROCEDURE insertar_equipo;
DELIMITER $$
CREATE PROCEDURE insertar_equipo (ciudad VARCHAR(45), nombre VARCHAR(45), año INT, rendimiento VARCHAR(45))
	BEGIN
	START TRANSACTION;
		INSERT INTO equipo (ciudad_equipo, nombre_equipo) VALUES (ciudad,nombre,rendimiento);
		SET @id = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre);
	COMMIT;
	END;
$$
DELIMITER ;
#Procedimiento para insertar entrenadores (Los inserta también en el histórico)
DELIMITER $$
CREATE PROCEDURE insertar_entrenador(telefono VARCHAR(45), equipo VARCHAR(45), experiencia INT, 
									apellidos VARCHAR(45), nombres VARCHAR(45), año INT, salario DOUBLE)
	BEGIN
	START TRANSACTION;
		INSERT INTO entrenador (telefono_entrenador, experiencia_entrenador, apellidos_entrenador, nombres_entrenador)
						 VALUES( telefono, experiencia, apellidos, nombres );
	
	SET @id_ent = (SELECT id_entrenador FROM entrenador WHERE nombres_entrenador = nombres);
	SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = equipo);
	INSERT INTO historico_entrenadores (salario_historico_entrenadores, año_historico_entrenadores, entrenador_id_entrenador, id_equipo) 
				VALUES (salario, año, @id_ent, @id_equ);
	COMMIT;
	END;
$$
DELIMITER ;

##NEW STUFFF

DELIMITER $$
CREATE PROCEDURE insertar_tecnico(telefono VARCHAR(45), experiencia INT, apellidos VARCHAR(45),
									nombres VARCHAR(45), equipo VARCHAR(45) )
	BEGIN
	START TRANSACTION;
	INSERT INTO tecnico (telefono_tecnico,experiencia_tecnico, apellidos_tecnico, nombres_tecnico)
				  VALUES( telefono, experiencia, apellidos, nombres );

	SET @id_tec = (SELECT COUNT(*) FROM tecnico);
	SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = equipo);

	UPDATE equipo SET tecnico_id_tecnico = @id_tec WHERE  id_equipo = @id_equ;	
	COMMIT;	
	END;
$$
DELIMITER ; */
									
#####################################################################################################
#PA CON EL MODELO 'NUEVO' PASANDO COLUMNAS A EQUIPO Y ENTRENADOR
DROP PROCEDURE insertar_jugador;
DELIMITER $$

CREATE PROCEDURE insertar_jugador (nacionalidad VARCHAR(45), edad INT,  
								apellidos VARCHAR(45), nombres VARCHAR(45), nombre_equ VARCHAR(45), numero_goles INT, numero_camiseta INT, fecha DATETIME, salario DOUBLE )
	BEGIN	
	START TRANSACTION;
		SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_equ);
		INSERT INTO jugador (nacionalidad_jugador, edad_jugador,nombres_jugador, apellidos_jugador, goles_jugador, numero_jugador, fechaNacimiento_jugador, id_equipo, salario_jugador) 
					VALUES (nacionalidad,edad,nombres,apellidos, numero_goles, numero_camiseta, fecha, @id_equ, salario );
	COMMIT;
	END;
$$
DELIMITER ;

DROP PROCEDURE insertar_equipo;
DELIMITER $$
CREATE PROCEDURE insertar_equipo (ciudad VARCHAR(45), nombre VARCHAR(45), rendimiento VARCHAR(45), apellido_tec VARCHAR(45), nombre_tec VARCHAR(45))
	BEGIN
	START TRANSACTION;
		SET @id_tec = (SELECT id_tecnico FROM tecnico WHERE nombres_tecnico = nombre_tec  AND apellidos_tecnico = apellido_tec );
		INSERT INTO equipo (ciudad_equipo, nombre_equipo, rendimiento_equipo, id_tecnico) VALUES (ciudad,nombre,rendimiento, @id_tec);
		SET @id = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre);
	COMMIT;
	END;
$$
DELIMITER ;

DROP PROCEDURE insertar_entrenador;

DELIMITER $$
CREATE PROCEDURE insertar_entrenador(telefono VARCHAR(45), equipo VARCHAR(45), experiencia INT, 
									apellidos VARCHAR(45), nombres VARCHAR(45), año INT, salario DOUBLE)
	BEGIN
	START TRANSACTION;
		SET @id_equipo = (SELECT id_equipo FROM equipo WHERE nombre_equipo = equipo);
		INSERT INTO entrenador (telefono_entrenador, experiencia_entrenador, apellidos_entrenador, nombres_entrenador, salario_entrenador, id_equipo)
						 VALUES( telefono, experiencia, apellidos, nombres, salario, @id_equipo );
	COMMIT;
	END;
$$
DELIMITER ;

DROP PROCEDURE insertar_tecnico;
DELIMITER $$
CREATE PROCEDURE insertar_tecnico(telefono VARCHAR(45), experiencia INT, apellidos VARCHAR(45),
									nombres VARCHAR(45), salario DOUBLE)
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

DROP PROCEDURE insertar_arbitro;
DELIMITER $$
CREATE PROCEDURE insertar_arbitro( nombre VARCHAR(45), apellido VARCHAR(45), tipo VARCHAR(45) )
	BEGIN
	START TRANSACTION;
	INSERT INTO arbitro ( nombre_arbitro, apellido_arbitro, tipo_arbitro )VALUES( nombre, apellido, tipo );
	COMMIT;
	END;
$$
DELIMITER ;
DROP PROCEDURE insertar_partido;
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
DROP PROCEDURE insertar_campeonato;
DELIMITER $$
CREATE PROCEDURE insertar_campeonato(añ INT, sem INT)
	BEGIN
	START TRANSACTION;
		INSERT INTO campeonato (año, semestre) VALUES (añ, sem);
	COMMIT;
	END;
$$
DELIMITER ;
DROP PROCEDURE asingar_partido_arbitro;
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

DROP PROCEDURE insertar_equipo_en_campeonato;
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
DROP PROCEDURE insertar_gol;
DELIMITER $$
CREATE PROCEDURE insertar_gol(minuto INT, tipo_gol VARCHAR(45), ape_jug VARCHAR(45), nom_jug VARCHAR(45),
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

CALL insertar_arbitro('asdasd', 'asdasd', 'pecora');
CALL insertar_tecnico('564654465', 7, 'Cruz', 'Andres', 1213213);
CALL insertar_equipo ('PecoraCity', 'PecoraTeam', 'MALO', 'Cruz', 'Andres');
CALL insertar_jugador('Cholo', 80, 'Zambrano', 'Pedro', 'PecoraTeam', 0, 10,'1985/03/03', 300000);
CALL insertar_campeonato(2013, 2);
CALL insertar_partido( curdate(), 'asdsadasd','asdasd', 8, 7, 'PecoraTeam', 'PecoraTeam', 2013, 2 );
CALL asingar_partido_arbitro('asdasd', 'asdasd', 'PecoraTeam', 'PecoraTeam', 2013, 2);
CALL insertar_gol (14, 'penal', 'Zambrano', 'Pedro', 'PecoraTeam', 'PecoraTeam', 2013, 2 );
CALL insertar_equipo_en_campeonato('PecoraTeam',2013,2);
