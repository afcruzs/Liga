CALL insertar_equipo('Bogotá','santa fe',2003);
CALL insertar_jugador('Colombiano',18, 2013, 7, 'Andrés Felipe', 'Cruz pécora', 'millos');
SELECT * FROM historico_equipo;
SELECT * FROM equipo;
SELECT * FROM historico_jugadores;

CALL insertar_entrenador( '457 4577', 'santa fe', 10, 'Cagua Hernandez', 'Milder Pécora', 2003, 100000, false );
SELECT * FROM entrenador;
