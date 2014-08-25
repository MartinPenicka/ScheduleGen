% ####################
% Prolog - school schedule)
% --------------------
% Input :
% ---
% Class     -> number of classes.
% Subjects  -> number of subjects, type(name, number) must be imported.
% SubCounts -> list
% ---
% Output :
% Structured output to stdout.
% ####################

:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-[exactly,school_db,print,list].

% --------------------
% Definitions
% --------------------

single_schedule(_, []) :- !.
single_schedule(L, [Dim|Dims]) :-
	length(L, Dim),
	( foreach(X,L),param(Dims) do 
	single_schedule(X, Dims)
	).
	
sum([],0).
sum([H|T], Sum):-
	sum(T, Rest),
	Sum is H + Rest.
	
%alternating2([1,2,3,4,5]).
%alternating2([1,2,2,3,3]).
alternating2([]).
alternating2([H|T]):-
	alternating2(T,H).
	
alternating2([],_):-!.
alternating2([H|T],X):-
	X #\= H,
	alternating2(T,H).

% --------------------
% Main function
% --------------------

schedule(Class, Subjects, SubCounts, Permanent):-

	sum(SubCounts, TMP_CLASS),
	Hours is round(TMP_CLASS / 5),
	(Hours * 5 #= TMP_CLASS ->
		write('Sum of all hour is divisible by 5, countinue..');
		write('Sum of all hours counts is NOT divisible by 5. Exiting.'),abort
	
	),
	nl,
	
	% ----------
	% Generate variables
	% ----------
	single_schedule(MONDAY, [Class, Hours]),
	single_schedule(TUESDAY, [Class, Hours]),
	single_schedule(WEDNESDAY, [Class, Hours]),
	single_schedule(THURSDAY, [Class, Hours]),
	single_schedule(FRIDAY, [Class, Hours]),
	DAYS      = [MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY],
	% ----------
	
	append(DAYS, TMP_ALL),
	append(TMP_ALL, ALL_VARIABLES),
	domain(ALL_VARIABLES , 1, Subjects),
	
	% Testing subjects permanently assigned to time.
	(foreach(P,Permanent),param(DAYS) do
		nth(P,1,P1),
		nth(P,2,P2),
		nth(P,3,P3),
		nth(P,4,P4),
		
		nth(DAYS,P1,PermDay),
		nth(PermDay,P2,PermClass),
		nth(PermClass,P3,PermHour),
		PermHour #= P4
	),

	%In one day, only one type of subject per class
	(foreach(D,DAYS) do maplist(all_distinct, D)),
	% In single hour, only one subject can be taught -> only one teacher per subject
	(foreach(DD,DAYS) do transpose(DD,TD), maplist(all_distinct, TD)),

	% Test, if schedule for every class contains subject only in given amounts and create list with all hours in week per class
	length(ALL_SEP, Class),
	(foreach(M,MONDAY), foreach(T,TUESDAY), foreach(W,WEDNESDAY), foreach(H,THURSDAY), foreach(F,FRIDAY), foreach(SEP, ALL_SEP), param(Subjects,SubCounts) do
		SEP = [M,T,W,H,F],
		append(SEP, SCH_CLASS),
		(for(CC,1,Subjects), foreach(X,SubCounts), param(SCH_CLASS) do exactly(CC,SCH_CLASS,X))
	),
	
	(foreach(SEP_DAY, ALL_SEP), param(Subjects) do 
		transpose(SEP_DAY, TSEP_DAY),
		(foreach(TSEP,TSEP_DAY) do
		alternating2(TSEP)
		)
	),
		
	labeling([],ALL_VARIABLES),
	
	%Structured output to stdout & file
	DayNames = ['Mo', 'Tu', 'We', 'Th', 'Fr'],
	
	(foreach(DAY_SEP, ALL_SEP), for(I,1,Class), param(DayNames,Hours) do
		write('Class : '),write(I),nl,
		write('     '),
		(for(J,1,Hours) do write(J), write('   ')),nl,
		(foreach(SCHDay, DAY_SEP), foreach(DN, DayNames) do
			write(DN),write(' : '),
			write_schedule_day(SCHDay),nl
		),nl
	).
	