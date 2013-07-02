DROP VIEW IF EXISTS ver_equipos_todos;

CREATE VIEW ver_equipos_todos AS
	SELECT nombre_equipo AS 'Nombre', ciudad_equipo AS 'Ciudad', rendimiento_equipo AS 'Rendimiento',
		   CONCAT(nombres_tecnico, ' ', apellidos_tecnico) AS 'Técnico' FROM equipo NATURAL JOIN tecnico;

SELECT * FROM ver_equipos_todos;