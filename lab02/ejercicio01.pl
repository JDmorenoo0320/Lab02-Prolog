% --- HECHOS Y CAPACIDADES (PARÁMETROS DEL PROBLEMA) ---

% Coordenadas de las ubicaciones: ubicacion(ID, X, Y).
ubicacion(orilla_inicial, 0, 5).
ubicacion(piedra1, 2, 4).
ubicacion(piedra2, 5, 6).
ubicacion(piedra3, 8, 4).
ubicacion(piedra4, 5, 0).
ubicacion(orilla_final, 10, 5).

% Capacidad de la rana: distancia máxima de salto.
salto_maximo(4.0).

distancia((X1, Y1), (X2, Y2), D):- D is sqrt((X2-X1)**2 + (Y2-Y1)**2). %tomado de un lab anterior

siguiente_estado(pos(LugarActual), pos(LugarSiguiente)):-
    ubicacion(LugarActual, X1, Y1),
    ubicacion(LugarSiguiente, X2, Y2), LugarActual \= LugarSiguiente,
    distancia((X1, Y1), (X2, Y2), D), salto_maximo(M), D =< M.

meta(pos(orilla_final)).

dfs(pos(EstadoActual), _, [pos(EstadoActual)]) :-
    meta(pos(EstadoActual)).

dfs(pos(EstadoActual), Visitados, [pos(EstadoActual) | CaminoRestante]) :-
    siguiente_estado(pos(EstadoActual), pos(SiguienteEstado)),
    not(member(pos(SiguienteEstado), Visitados)),
    dfs(pos(SiguienteEstado),
        [pos(SiguienteEstado) | Visitados],
        CaminoRestante).

buscar_solucion(Solucion) :-
    EstadoInicial = pos(orilla_inicial),
    dfs(EstadoInicial, [EstadoInicial], Solucion). %dfs(Estado,Visitados, Solucion).

% Solucion
% buscar_solucion(Solucion).
% Solucion = [pos(orilla_inicial), pos(piedra1), pos(piedra2), pos(piedra3), pos(orilla_final)]
% profe por la estructura de siguiente_estado y buscar_solucion el pos se quedo en la solucion, no lo pude
% quitar sin dañar el codigo.
