DROP VIEW IF EXISTS ver_equipos_todos;

CREATE VIEW ver_equipos_todos AS
	SELECT nombre_equipo AS 'Nombre', ciudad_equipo AS 'Ciudad', rendimiento_equipo AS 'Rendimiento',
		   CONCAT(nombres_tecnico, ' ', apellidos_tecnico) AS 'Técnico' FROM equipo NATURAL JOIN tecnico;

SELECT * FROM ver_entrenadores_actuales;

-- ----------------------------
-- Muestra todos los partidos
-- ----------------------------

DROP VIEW IF EXISTS vista_partidos;
CREATE VIEW vista_partidos( fecha_partido, equipo_local, equipo_visitante, 
							goles_local, goles_visitante, ganador, año, semestre ) 
AS 
	SELECT fecha_partido, 
		   equipo_nombre(id_local), 
		   equipo_nombre(id_visitante),
		   goles_local, 
		   goles_visitante,
		   ganador_nombre( equipo_nombre(id_local),equipo_nombre(id_visitante),
					goles_local, goles_visitante),
		   año, 
		   semestre	
	FROM partido NATURAL JOIN campeonato;

-- ------------------------------------------
-- Muestra la tabla de posiciones
-- ------------------------------------------

CREATE VIEW tabla_de_posiciones( posicion, nombre_equipo, puntaje, 
								 goles_favor, goles_contra, año, semestre )
AS
	SELECT pos, nombre_equipo, puntaje, goles_favor, goles_contra, año, semestre 
	FROM posicion NATURAL JOIN equipo NATURAL JOIN campeonato ORDER BY pos ASC; 


DROP VIEW IF EXISTS goles_por_partido;
CREATE VIEW goles_por_partido( nombre_jugador, apellido_jugador, goles, 
							   equipo_local, equipo_visitante, 
							   año_camp, semestre_camp )
AS
	SELECT nombres_jugador, apellidos_jugador, SUM(id_jugador), equipo_nombre(id_local),
		   equipo_nombre(id_visitante), año, semestre	
	FROM partido NATURAL JOIN campeonato NATURAL JOIN gol NATURAL JOIN jugador
	GROUP BY nombres_jugador;


