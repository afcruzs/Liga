
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
DELIMITER ;
									
#####################################################################################################
#PA CON EL MODELO 'NUEVO' PASANDO COLUMNAS A EQUIPO Y ENTRENADOR
DELIMITER $$

CREATE PROCEDURE insertar_jugador (nacionalidad VARCHAR(45), edad INT, año INT, numero_c 
									INT, nombres VARCHAR(45), apellidos VARCHAR(45), nombre_equ VARCHAR(45), numero_goles INT, numero_camiseta INT)
	BEGIN	
	START TRANSACTION;
		INSERT INTO jugador (nacionalidad_jugador, edad_jugador,nombres_jugador, apellidos_jugador, numero_goles_jugador, numero_camiseta_jugador) 
					VALUES (nacionalidad,edad,nombres,apellidos, numero_goles, numero_camiseta);
	COMMIT;
	END;
$$
DELIMITER ;


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



DELIMITER $$
CREATE PROCEDURE insertar_entrenador(telefono VARCHAR(45), equipo VARCHAR(45), experiencia INT, 
									apellidos VARCHAR(45), nombres VARCHAR(45), año INT, salario DOUBLE)
	BEGIN
	START TRANSACTION;
		INSERT INTO entrenador (telefono_entrenador, experiencia_entrenador, apellidos_entrenador, nombres_entrenador, salario_entrenador)
						 VALUES( telefono, experiencia, apellidos, nombres, salario );
	COMMIT;
	END;
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE insertar_tecnico(telefono VARCHAR(45), experiencia INT, apellidos VARCHAR(45),
									nombres VARCHAR(45), equipo VARCHAR(45), salario DOUBLE)
	BEGIN
	START TRANSACTION;
	INSERT INTO tecnico (telefono_tecnico,experiencia_tecnico, apellidos_tecnico, nombres_tecnico, salario_tecnico)
				  VALUES( telefono, experiencia, apellidos, nombres, salario );
	COMMIT;	
	END;
$$
DELIMITER ;

