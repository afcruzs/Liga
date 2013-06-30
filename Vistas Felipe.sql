##Vistas FELIPE

#Vista que muestra los atributos de los entrenadores actuales y su equipo
DROP VIEW IF EXISTS ver_entrenadores_actuales;
CREATE VIEW ver_entrenadores_actuales AS
	SELECT nombre_equipo AS 'Equipo' , nombres_entrenador AS 'Nombres', apellidos_entrenador AS 'Apellidos',
		   salario_entrenador AS 'Salario', telefono_entrenador AS 'Número telefónico', experiencia_entrenador AS 'Experiencia'
		   FROM entrenador JOIN equipo;

#Vista para ver jugadores actuales y su equipo
DROP VIEW IF EXISTS ver_jugadores_actuales;
CREATE VIEW ver_jugadores_actuales AS
	SELECT nombre_equipo AS 'Equipo', nombres_jugador AS 'Nombres', apellidos_jugador 'Apellidos', nacionalidad_jugador AS 'Nacionaliad',
		   fechaNacimiento_jugador AS 'Fecha Nacimiento', edad_jugador AS 'Edad', numero_jugador AS 'Número Camiseta', salario_jugador AS 'Salario',
		   goles_jugador AS 'Goles' FROM jugador NATURAL JOIN equipo;

SELECT * FROM ver_jugadores_actuales;



