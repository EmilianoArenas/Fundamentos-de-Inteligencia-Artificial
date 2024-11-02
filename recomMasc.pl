% Base de conocimiento sobre mascotas y sus características
mascota(perro, pequeno, jugueton, requiere_espacios_abiertos).
mascota(gato, pequeno, tranquilo, no_requiere_espacios_abiertos).
mascota(pajaro, pequeno, activo, no_requiere_espacios_abiertos).
mascota(conejo, pequeno, amigable, no_requiere_espacios_abiertos).
mascota(tortuga, pequeno, tranquilo, no_requiere_espacios_abiertos).
mascota(iguana, mediano, tranquilo, no_requiere_espacios_abiertos).
mascota(huron, mediano, jugueton, requiere_espacios_abiertos).
mascota(loro, mediano, activo, no_requiere_espacios_abiertos).
mascota(perico, mediano, activo, no_requiere_espacios_abiertos).
mascota(pinguino, mediano, tranquilo, no_requiere_espacios_abiertos).
mascota(oveja, grande, tranquilo, requiere_espacios_abiertos).
mascota(cabra, grande, jugueton, requiere_espacios_abiertos).
mascota(caballo, grande, activo, requiere_espacios_abiertos).

% Hechos sobre mascotas adecuadas para principiantes
adecuada_para_principiantes(perro).
adecuada_para_principiantes(gato).
adecuada_para_principiantes(conejo).
adecuada_para_principiantes(tortuga).

% Hechos sobre mascotas compatibles con niños
compatible_con_ninos(perro).
compatible_con_ninos(gato).
compatible_con_ninos(conejo).
compatible_con_ninos(tortuga).
compatible_con_ninos(huron).

% Regla principal para recomendar una mascota
recomendar_mascota :-
    write('**************************************'), nl,
    write('*  Bienvenido al recomendador de mascotas  *'), nl,
    write('**************************************'), nl,
    pedir_tamano(Tamano),
    pedir_personalidad(Personalidad),
    pedir_espacios(Espacios),
    pedir_experiencia(Experiencia),
    buscar_mascota_recomendada(Tamano, Personalidad, Espacios, Recomendacion),
    mostrar_recomendacion(Recomendacion),
    mostrar_consejo(Recomendacion),
    verificar_compatibilidad_ninos(Recomendacion),
    verificar_adecuacion_para_principiantes(Recomendacion, Experiencia).

% Reglas para pedir la información al usuario
pedir_tamano(Tamano) :-
    write('1. ¿Qué tamaño de mascota prefieres? (pequeno, mediano, grande): '),
    read(Tamano).

pedir_personalidad(Personalidad) :-
    write('2. ¿Qué personalidad buscas en una mascota? (jugueton, tranquilo, activo, amigable): '),
    read(Personalidad).

pedir_espacios(Espacios) :-
    write('3. ¿Tienes espacios abiertos para la mascota? (si, no): '),
    read(Espacios).

pedir_experiencia(Experiencia) :-
    write('4. ¿Tienes experiencia cuidando mascotas? (si, no): '),
    read(Experiencia).

% Reglas para buscar la mascota recomendada
buscar_mascota_recomendada(Tamano, Personalidad, si, Recomendacion) :-
    mascota(Recomendacion, Tamano, Personalidad, requiere_espacios_abiertos).
buscar_mascota_recomendada(Tamano, Personalidad, no, Recomendacion) :-
    mascota(Recomendacion, Tamano, Personalidad, no_requiere_espacios_abiertos).
buscar_mascota_recomendada(_, _, _, 'No pudimos encontrar una recomendación para ti. Consulta a un experto en mascotas.').

% Regla para mostrar la recomendación
mostrar_recomendacion('No pudimos encontrar una recomendación para ti. Consulta a un experto en mascotas.') :-
    write('Lo sentimos, no encontramos una mascota que cumpla con tus requisitos.').
mostrar_recomendacion(Recomendacion) :-
    write('¡Te recomendamos adoptar un(a) '), write(Recomendacion), write('!'), nl.

% Regla para mostrar un consejo sobre la mascota
mostrar_consejo(perro) :-
    write('Consejo: Asegúrate de pasear a tu perro todos los días para mantenerlo feliz y saludable.'), nl.
mostrar_consejo(gato) :-
    write('Consejo: Proporciona juguetes y un lugar cómodo para tu gato.'), nl.
mostrar_consejo(conejo) :-
    write('Consejo: Dale suficiente espacio para moverse y mantén su jaula limpia.'), nl.
mostrar_consejo(tortuga) :-
    write('Consejo: Asegúrate de que la tortuga tenga un lugar seco y otro con agua.'), nl.
mostrar_consejo(_) :-
    write('Recuerda informarte bien sobre los cuidados específicos de esta mascota.'), nl.

% Regla para verificar la compatibilidad con niños
verificar_compatibilidad_ninos(Recomendacion) :-
    compatible_con_ninos(Recomendacion),
    write('Esta mascota es compatible con niños.'), nl.
verificar_compatibilidad_ninos(_) :-
    write('Esta mascota puede requerir supervisión cerca de niños.'), nl.

% Regla para verificar si es adecuada para principiantes
verificar_adecuacion_para_principiantes(_, si) :-
    write('¡Genial! Con tu experiencia, podrás cuidar de cualquier mascota recomendada.'), nl.
verificar_adecuacion_para_principiantes(Recomendacion, no) :-
    adecuada_para_principiantes(Recomendacion),
    write('Esta mascota es adecuada para principiantes.'), nl.
verificar_adecuacion_para_principiantes(_, no) :-
    write('Nota: Esta mascota puede requerir más experiencia para cuidarla adecuadamente.'), nl.
