%BASE DE CONOCIMIENTOS
%(Estos son solo ejemplos, no es información verídica)

frame(peliculas,subclase_de(top),
      propiedades([necesita(contar_historia_graficamente)]),
      descripcion('Expresión artística que combina imágenes en movimiento, sonido y narrativa para contar historias con el objetivo de entretener a la gente.')).

frame(accion,subclase_de(peliculas),
      propiedades([tiene(persecuciones),tiene(batallas)]),
      descripcion('Busca mantener al expectador en tensión y adrenalina')).

frame(comedia,subclase_de(peliculas),
      propiedades([tiene(humor)]),
      descripcion('Busca divertir y provocar en el espectador una risa contagiosa que les lleve a evadirse del mundo real.')).

frame(drama,subclase_de(peliculas),
      propiedades([tiene(conflicto)]),
      descripcion('Presenta historias serias, en las que prevalece el dialogo ')).

frame(terror,subclase_de(peliculas),
      propiedades([causa(miedo)]),
      descripcion('Exploran a menudo temas obscuros y pueden ocuparse de temas transgresores.')).

frame(ciencia_ficcion,subclase_de(peliculas),
      propiedades([tiene(fenomenos_ficticios)]),
      descripcion('Representan espacios futuristas y con elementos no creados o irreales en la actualidad.')).

frame(romantico,subclase_de(peliculas),
      propiedades([tiene(romance)]),
      descripcion('Los protagonistas son una pareja y su relación el centro del argumento.')).

frame(documental,subclase_de(peliculas),
      propiedades([es(informativo)]),
      descripcion('Intenta expresar la realidad de forma objetiva.')).

frame(superheroes,subclase_de(accion),
      propiedades([tiene(superheroes),tiene(villanos)]),
      descripcion('La trama gira alrededor de los esfuerzos de los superhéroes para frustrar graves amenazas globales')).

frame(artes_marciales,subclase_de(accion),
      propiedades([tiene(lucha_acrovatica), tiene(combate_oriental)]),
      descripcion('El personaje principal realiza un viaje físico o psicológico para lograr algún objetivo.')).

frame(parodia,subclase_de(comedia),
      propiedades([tiene(imitaciones),tiene(ironia)]),
      descripcion('Se trata de una imitación burlesca de una persona, una obra de arte o una cierta temática. ')).

frame(paranormal,subclase_de(terror),
      propiedades([tiene(fantasmas),tiene(demonios)]),
      descripcion('Se centra más en el terror a lo desconocido, ya que muchas veces la fuerza maligna de estas películas no suele ser visible')).

frame(terror_psicologico,subclase_de(terror),
      propiedades([tiene(suspenso), tiene(traumas_psicologicos)]),
      descripcion('Enfoca en los miedos de sus personajes')).

frame(tragica,subclase_de(drama),
      propiedades([tiene(desgracias), tiene(injusticias)]),
      descripcion('Los personajes protagónicos se ven enfrentados de manera misteriosa, invencible e inevitable, a causa de un error fatal o condición de carácter contra un destino fatal')).

frame(melodrama,subclase_de(drama),
      propiedades([tiene(crisis), tiene(traiciones)]),
      descripcion('Se desarrollan situaciones en las que se apela a las emociones aumentadas de la audiencia')).

frame(distopia,subclase_de(ciencia_ficcion),
      propiedades([tiene(crueldad), tiene(criticismo_encubierto)]),
      descripcion('Representación de una sociedad ficticia que agrupa todo tipo de características indeseables ')).

frame(viajes_tiempo,subclase_de(ciencia_ficcion),
      propiedades([tiene(maquinas_del_tiempo), tiene(problematicas)]),
      descripcion('Los personajes viajan en el tiempo para lograr un propósito ya sea personal o para el bien de la humanidad')).

frame(romance_LGBT,subclase_de(romantico),
      propiedades([tiene(critica_social), tiene(inclusividad)]),
      descripcion('Busca incorporar y normalizar el amor entre iguales')).

frame(biografico,subclase_de(documental),
      propiedades([es_una(historia_real), es(cronologico)]),
      descripcion('Busca reflejar la vida de personajes historicos')).

frame(politico,subclase_de(documental),
      propiedades([tiene(temas_politicos), tiene(doctrinas)]),
      descripcion('Trata temas políticos, unas veces para suscitar la reflexión o para denunciar injusticias sobre problemas políticos o sociales ')).














