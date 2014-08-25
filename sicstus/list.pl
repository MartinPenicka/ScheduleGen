% --------------------
% List manipulation methods
% -------------------- 


% --------------------
% LEN - Get lenght of list (using Python symbolics)
% -------------------- 

len([],S):-
	S = 0.
len([_|T], S):-
	len(T,S1),
	S is S1 + 1.

% --------------------
% CONTAINS - Check if list contains value (not name member -> built in function in SICSTUS)
% contains(item, list)
% -------------------- 

contains(X,[Y,T]):-
	X = Y;
	contains(X,T).

% --------------------
% INSERT - adds new item to first place at list
% insert(list, item, list_with_item)
% -------------------- 

ins(L,X,[X|L]).

% --------------------
% ADD -  adds new item to last place at list
% -------------------- 

add(L,X,[L|X]).

% --------------------
% ADDTO - adds new item to given position at list
% add_to(list, item, position, list_with_item)
% -------------------- 

add_to([],X,_,[X]).

% --------------------
% MERGE - Create list with two items (lists) from given lists.
% -------------------- 


% --------------------
% DELETE
% -------------------- 
del([],_,[]).
del([X|T],X,T).
del([Y|T],X,[Y|NewT]):-
	X \= Y,
	del(T,X,NewT).

% --------------------
% FLATTEN - create flat list from nested list
% TEST - flatten2([[1,2,[3,4],5],6,[7]], L).
%	 flatten2([[A,B],[C,D],[E,F]],L).
% -------------------- 


flatten([],[]).

flatten([Head|InTail],Out) :-
	flatten(Head,FlatHead),
	flatten(InTail,OutTail),
	append(FlatHead,OutTail,Out).

flatten([Head|InTail], [Head|OutTail]) :-
	Head \= [],
	Head \= [_|_],
        flatten(InTail,OutTail).
        
flatten2(List, Flat) :-
        flatten2(List, Flat, []).

flatten2([], Res, Res) :- !.
flatten2([Head|Tail], Res, Cont) :-
        !,
        flatten2(Head, Res, Cont1),
        flatten2(Tail, Cont1, Cont).
flatten2(Term, [Term|Cont], Cont).

% --------------------
% NTH - nth element of list
% TEST - nth([7,6,2,4,9,11],3,E).
% -------------------- 
        
nth([],_,_).
nth([H|_],1,H).
nth([_|T],N,E):-
	N1 is N - 1,
	nth(T,N1,E).        
