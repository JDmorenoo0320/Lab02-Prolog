power_list([
    power(logica, 100, 10),
    power(sigilo, 150, 30),
    power(fuerza, 250, 50)
]).

villain_list([
    villain(riddler, 90, [logica, sigilo]),
    villain(bane, 240, [fuerza])
]).

siguiente_estado(
    estado(Villanos, Poderes, Energia), 
    estado(NuevosVillanos, Poderes, NuevaEnergia)
):-
    member(villain(Nombre, Vida, Debilidades), Villanos),  % ver que haya un villano
    member(power(Habilidad, Daño, Costo), Poderes),		% ver que hay un poder
    member(Habilidad, Debilidades),			 	% ver que la habilidad o poder esta en las debilidades
    Energia >= Costo,
    NuevaEnergia is Energia - Costo,
    NuevaVida is Vida - Daño,
    (
        NuevaVida =< 0 ->
            select(villain(Nombre, Vida, Debilidades),
                   Villanos,
                   NuevosVillanos)
        ;
            select(villain(Nombre, Vida, Debilidades),
                   Villanos,
                   RestoVillanos),
            NuevosVillanos =
                [villain(Nombre, NuevaVida, Debilidades)
                 | RestoVillanos]
    ).
% profe lo ultimo me ayudo chat la verdad, pero entendi la idea, en si en prolog esto es un tipo "if" digamos
% donde si el villano recibe mas o igual vida de la que tiene, se le saca de la lista usando select, si no
% pasa al otro estado donde se le saca pero se vuelve a introducir con la nueva vida, y ya, profe mucho python.

dfs(estado([], _, _), _).

dfs(EstadoActual, Visitados) :-
    siguiente_estado(EstadoActual, NuevoEstado),
    not(member(NuevoEstado, Visitados)),
    dfs(NuevoEstado, [NuevoEstado | Visitados]).

batman_can_win(EnergiaMaxima) :-
    power_list(Superpoderes),
    villain_list(Villanos),
    % El estado inicial contiene todos los villanos, todos los poderes y la energía máxima.
    EstadoInicial = estado(Villanos, Superpoderes, EnergiaMaxima),
    dfs(EstadoInicial, [EstadoInicial]). %dfs(Estado,Visitados)

% caso 
% batman_can_win(100).   true, true, true, true, false
