% Frutas
fruta(papaya, 45).
fruta(melon, 31).
fruta(platano, 89).

% Cereales
cereal(pan_centeno, 241).
cereal(pan_blanco, 255).
cereal(avena, 389).

% Jugos
jugo(jugo_naranja, 42).
jugo(jugo_pina, 50).

% Huevo
huevo(huevo_entero, 147).
huevo(clara_huevo, 17).

% Carnico
carnico(chuleta_cerdo, 330).
carnico(chicharron, 601).
carnico(pollo_asado, 239).
% Pastas
pasta(pasta_huevo, 368).
pasta(pasta_semola, 361).
pasta(pasta_integral, 180).

% Postre
postre(flan_vainilla, 102).
postre(flan_huevo, 126).
postre(pastel_manzana, 311).

% Lacteo
lacteo(leche_entera, 68).
lacteo(leche_semidescremada, 49).
lacteo(yogurt_natural, 61). lacteo(yogurt_frutas, 59).

% Colacion
colacion(donut, 456).
colacion(galletas_mantequilla, 397).
colacion(barra_cereal, 127).

% Ensalada
ensalada(ensalada_pepino, 85).
ensalada(ensalada_tomate, 72).

% Reglas para armar las comidas
desayuno(D1, D2, D3, D4, KCal) :-
    fruta(D1, K1), cereal(D2, K2), jugo(D3, K3), huevo(D4, K4),
    KCal is K1 + K2 + K3 + K4.

almuerzo(A1, A2, KCal) :-
    ensalada(A1, K1), lacteo(A2, K2),
    KCal is K1 + K2.

comida(C1, C2, C3, KCal) :-
    carnico(C1, K1), pasta(C2, K2), postre(C3, K3),
    KCal is K1 + K2 + K3.

merienda(M1, M2, KCal) :-
    lacteo(M1, K1), colacion(M2, K2),
    KCal is K1 + K2.

cena(C11, C22, C33, KCal) :-
    fruta(C11, K1), lacteo(C22, K2), ensalada(C33, K3),
    KCal is K1 + K2 + K3.

% Regla para calcular el gasto calorico basal segun el sexo, el peso y
% la edad
gasto_calorico_basal(Sexo, Peso, Edad, Gasto) :-
    (Sexo = 1 -> GastoBasal is Peso * 21.6; GastoBasal is Peso * 24),
    (
        Edad < 25 -> Ajuste = 300;
        Edad > 45 -> Ajuste is -100 * ((Edad - 45) // 10);
        Ajuste = 0
    ),
    Gasto is GastoBasal + Ajuste.


% Regla de dieta que ajusta segun el gasto calorico
dieta(Gasto) :-

    desayuno(D1, D2, D3, D4, K1),
    almuerzo(A1, A2, K2),
    comida(C1, C2, C3, K3),
    merienda(M1, M2, K4),
    cena(C11, C22, C33, K5),
    KCal is K1 + K2 + K3 + K4 + K5,
    Inferior is Gasto - (Gasto * 0.1),
    Superior is Gasto + (Gasto * 0.1),
    KCal >= Inferior, KCal =< Superior,
    format("\nDesayuno: ~w, ~w, ~w, ~w", [D1, D2, D3, D4]),
    format("\nAlmuerzo: ~w, ~w", [A1, A2]),
    format("\nComida  : ~w, ~w, ~w", [C1, C2, C3]),
    format("\nMerienda: ~w, ~w", [M1, M2]),
    format("\nCena: ~w, ~w, ~w", [C11, C22, C33]),
    format("\nTotal de KCalor�as: ~d", KCal),
    nl,write('<<Press any key>>'),get_single_char(_),                                     fail.



% Ciclo principal
iniciar :-
    repeat,
    pinta_menu,
    read(Opcion),
    (
        (Opcion = 1, doImc, fail);
        (Opcion = 2, doDieta, fail);
        (Opcion = 3, write('Gracias por utilizar mi programa')) ).


% Muestra el menu
pinta_menu :-
    nl, nl,
    writeln('===================================='),
    writeln('         DRA. MIKU HATSUNE'),
    writeln('          Medica Virtual'),
    writeln('   <<  Experta en Nutricion  >>'),
    writeln('===================================='),
    nl, writeln('       MENU PRINCIPAL'),
    nl, write('1 Calcular indice de masa corporal'),
    nl, write('2 Recomendar una dieta saludable'),
    nl, write('3 Salir'),
    nl, write('================================='),
    nl, write('Indique una opcion valida:').

% Regla para calcular IMC
doImc :-
    nl, write('================================='), nl,
    write('Elegiste: Calculo del Indice de Masa Corporal\n'), nl,
    write('Indique su peso en Kilogramos:'), read(Peso),
    write('Indique su estatura en Metros:'), read(Estatura), Estatura > 0,
    write('Indique su genero (1/Male, 2/Female):'), read(Sexo),
    IND is Peso / (Estatura * Estatura),
    nl, format('Su indice de masa corporal es: ~g', IND),
    get_single_char(_),
    get_single_char(_),
    nl, write('DIAGNOSTICO: '),
    (
        (Sexo = 1, IND < 17, write('USTED PADECE DESNUTRICION!'));
        (Sexo = 1, IND >= 17, IND < 20, write('USTED TIENE BAJO PESO!'));
        (Sexo = 1, IND >= 20, IND < 25, write('USTED TIENE PESO NORMAL!'));
        (Sexo = 1, IND >= 25, IND < 30, write('USTED TIENE SOBREPESO!'));
        (Sexo = 1, IND >= 30, write('USTED PADECE OBESIDAD!'));
        (Sexo = 2, IND < 16, write('USTED PADECE DESNUTRICION!'));
        (Sexo = 2, IND >= 16, IND < 18.5, write('USTED TIENE BAJO PESO!'));
        (Sexo = 2, IND >= 18.5, IND < 24, write('USTED TIENE PESO NORMAL!'));
        (Sexo = 2, IND >= 24, IND < 29, write('USTED TIENE SOBREPESO!'));
        (Sexo = 2, IND >= 29, write('USTED PADECE OBESIDAD!'))
    ).

% Regla para recomendar dietas
doDieta :-
    nl, write('================================='), nl,
    write('Elegiste: Nutriologo Artificial'), nl,
    write('Indique su peso en Kilogramos:'), read(Peso),
    write('Indique su genero (1/Male, 2/Female):'), read(Sexo),
    write('Indique su edad:'), read(Edad),
    gasto_calorico_basal(Sexo, Peso, Edad, Gasto),
    dieta(Gasto).
