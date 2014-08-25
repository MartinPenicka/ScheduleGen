% --------------------
% Structured output formatting (stdout).
% Contains universal methods and application specified
% -------------------- 

:-[list].

write_list([]):-
	format('',[]).
write_list([H|T]):-
	write(H),
	write('  '),
	write_list(T).
	
% --------------------
% School schedule
% -------------------- 

write_type(Num):-
	type(Num,X),
	write(X).

write_schedule_day([]):-
	format('',[]).
write_schedule_day([H|T]):-
	type(H,X),
	write(X),
	write('  '),
	write_schedule_day(T).
	
write_schedule_day_file(Stream, List):-
	(foreach(Item, List), param(Stream) do
		type(T,Item),
		write(Stream, T),
		write(Stream, '  ')
	).