#Procedimiento para insertar jugadores (Los inserta también en el historico)
DELIMITER $$

CREATE PROCEDURE insertar_jugador (nacionalidad VARCHAR(45), edad INT, año INT, numero_c 
									INT, nombres VARCHAR(45), apellidos VARCHAR(45), nombre_equ VARCHAR(45))
	BEGIN	
		SET @id_eq = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre_equ);

		INSERT INTO jugador (nacionalidad_jugador, edad_jugador,nombres_jugador, apellidos_jugador) 
					VALUES (nacionalidad,edad,nombres,apellidos);

		SET @id_jug = (SELECT id_jugador FROM jugador 
					   WHERE nombres_jugador = nombres AND apellidos_jugador = apellidos );

		INSERT INTO historico_jugadores VALUES (@id_jug,@id_eq,año,numero_c);
	END;
$$
DELIMITER ;

#Procedimiento para insertar equipos (Los inserta también en el historico)
#DROP PROCEDURE insertar_equipo;
DELIMITER $$
CREATE PROCEDURE insertar_equipo (ciudad VARCHAR(45), nombre VARCHAR(45), año INT)
	BEGIN
		INSERT INTO equipo (ciudad_equipo, nombre_equipo) VALUES (ciudad,nombre);
		SET @id = (SELECT id_equipo FROM equipo WHERE nombre_equipo = nombre);
		INSERT INTO historico_equipo(año_historico_equipo,id_equipo) VALUES(año,@id);
	END;
$$
DELIMITER ;
#Procedimiento para insertar entrenadores (Los inserta también en el histórico)
DELIMITER $$
CREATE PROCEDURE insertar_entrenador(telefono VARCHAR(45), equipo VARCHAR(45), experiencia INT, 
									apellidos VARCHAR(45), nombres VARCHAR(45), año INT, salario DOUBLE, director BOOL)
	BEGIN
		INSERT INTO entrenador (telefono_entrenador, experiencia_entrenador, apellidos_entrenador, nombres_entrenador)
						 VALUES( telefono, experiencia, apellidos, nombres );
	
	SET @id_ent = (SELECT id_entrenador FROM entrenador WHERE nombres_entrenador = nombres);
	SET @id_equ = (SELECT id_equipo FROM equipo WHERE nombre_equipo = equipo);
	INSERT INTO historico_entrenadores (id_entrenador, id_equipo, salario_historico_entrenadores, año_historico_entrenadores, director_historico_entrenadores) 
				VALUES (@id, @id_equ, salario, año, director );
	END;
$$
DELIMITER ;

