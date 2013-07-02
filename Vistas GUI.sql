DROP VIEW IF EXISTS ver_equipos_todos;
DROP VIEW IF EXISTS  ver_historico_jugadores;
DROP VIEW IF EXISTS  ver_partidos_jugados;
DROP VIEW IF EXISTS vista_partidos;
DROP VIEW IF EXISTS tabla_de_posiciones;
DROP VIEW IF EXISTS goles_por_partido;
DROP VIEW IF EXISTS ver_historico_jugadores;
DROP VIEW IF EXISTS ver_partidos_jugados;


CREATE VIEW ver_equipos_todos AS
	SELECT nombre_equipo AS 'Nombre', ciudad_equipo AS 'Ciudad', rendimiento_equipo AS 'Rendimiento',
		   CONCAT(nombres_tecnico, ' ', apellidos_tecnico) AS 'Técnico' FROM equipo NATURAL JOIN tecnico;

SELECT * FROM ver_entrenadores_actuales;

-- ----------------------------
-- Muestra todos los partidos
-- ----------------------------


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



CREATE VIEW goles_por_partido( nombre_jugador, apellido_jugador, goles, 
							   equipo_local, equipo_visitante, 
							   año_camp, semestre_camp )
AS
	SELECT nombres_jugador, apellidos_jugador, SUM(id_jugador), equipo_nombre(id_local),
		   equipo_nombre(id_visitante), año, semestre	
	FROM partido NATURAL JOIN campeonato NATURAL JOIN gol NATURAL JOIN jugador
	GROUP BY nombres_jugador;

SHOW FULL TABLES IN liga WHERE TABLE_TYPE LIKE 'VIEW';

-- Muestra el historico de Jugadores:

CREATE  VIEW ver_historico_jugadores AS
	SELECT nombres_jugador AS 'Nombres', apellidos_jugador 'Apellidos', año_historico_jugadores AS 'Año', 
		numero_historico_jugadores AS 'Número de Camiseta', goles_historico AS 'Goles', historico_jugadores.salario_jugador AS 'Salario'
		FROM historico_jugadores NATURAL JOIN jugador;

SELECT * FROM goles_por_partido;





CREATE VIEW ver_partidos_jugados AS
	(SELECT nombres_jugador AS 'Nombres', apellidos_jugador AS 'Apellidos', nombre_equipo AS 'Equipo', fecha_partido AS 'Fecha', ciudad_partido AS 'Ciudad', estadio AS 'Estadio', goles_local AS 'Goleslocal'
			,goles_visitante AS 'GolesVisitante', año AS 'Año', semestre AS 'Semestre' 
			FROM partido NATURAL JOIN campeonato NATURAL JOIN equipo NATURAL JOIN jugador);

SELECT * FROM ver_partidos_jugados;
	


