﻿% Copyright

   implement main
    open core, stdio, file

domains
    id = integer.
    name = string.
    address = string.
    type = string.
    id_phone = integer.
    year = integer.
    genre = male; female.


 class facts - publications
    кинотеатр : ( Integer id, String название, String адрес, Integer id_phone, Integer количество мест) .
    кинофильм : ( Integer id, String название, Integer year, String режиссер, genre жанр) .
    показывают : ( integer id_кинотеатра, integer id_фильма, integer year, string Время, real Выручка).


  class predicates
      %список кинотеатров
       список : (String название).
       %Правила просмотра
       поиск : ( String название) nondeterm anyflow.
        %Правило "Сумма всех изданий одного жанра"
       собрать : (genre жанр) determ.
    % Правила поиска фильмов по жанрам
      поиск : (gender, Result)  nondeterm.
      %Общая стоимость
      стоимость : (String название,string Время,  integer цена).
      издание : (integer Id, string название, genre жанр, Integer количество мест) nondeterm (i,i,o,o) (o,i,o,i) (o,i,o,o) (o,o,i,o) (o,o,o,o) (o,o,o,i) (i,o,o,o).

  class facts
      s : (real Sum) single.


  clauses
    s(0).


  clauses
      издание(А, Б, В, Г) :-
          кинотеатр(А, Б, В, Г).
     издание(А, Б, В, Г) :-
        кинофильм(А, Б, В, Г).

   %список кинотеатров
       список : (название) :-
          кинотеатр : ( _, название,  адрес),
         write("название кинотеатра ", название, "адрес :", адрес),
         nl,
         fail.


 список(_) :-
        write("Все варианты выведены\n") .

        % Правила просмотра
поиск(Название) :-
    кинотеатр(_, Название, _ , _ , _),
    write("Найден кинотеатр с названием: "), write(Название),
    nl.
поиск(Название) :-
    кинофильм(_, Название, _, _, _),
    write("Найден кинофильм с названием: "), write(Название),
    nl,
    fail .


%Правило "Сумма всех изданий одного жанра"
    собрать(Жанр) :-
        assert(s(0)),
        издание(_, _, Жанр, Выручка),
        s(Sum),
        assert(s(Sum + Выручка)),
        fail.


 %Поиск фильмов по жанрам
поиск(Gender, Result) :-
    кинофильм(id , название, year, режиссер, Gender),
    Result = (id, название, year, режиссер, Gender),
    write('Фильм с ID '),
    write(id ,),
    write(': '),
    write(название),
    nl,
    fail.

     %Общая стоимость
      стоимость (название, Время, цена) :-
      показывают (название, Время, Выручка),
     Sum = цена * Выручка,
        write("Общая стоимость: ", Sum),
        nl,
        fail.



clauses
    run() :-
        consult(" ../data.txt", publications),
        fail.


    run() :-
        список(кинотеатров),
        fail.


 run() :-
        стоимость("\nСтоимость комплектующих: \n"),
        fail.
    run().


 run() :-
        write("\nЦена всех изданий по жанру: \n"),
        собрать(новостной),
        fail.


   run().


end implement main

goal
    console::runUtf8(main::run).