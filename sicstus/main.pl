% --------------------
% Main file for school schedule application
% --------------------  

:-[param_input,schedule].

% All parameters are inserted here to code (INITIAL mode).
run_h:-
	write('----------\n'),
	write('Generating schedule...\n'),
	write('----------\n'),
	schedule(4,12,[5,5,2,2,2,2,2,1,1,1,1,1],[[1,3,1,1],[2,3,3,5]]).

% Interactive mode - all parameters are inserted in runtime.	
run_i:-
	get_class_num(ClassNum),
	get_sub_amount(SubTypeNum),
	get_sub_type_list(SubCountList),
	
	write('----------\n'),
	write('Generating schedule...\n'),
	write('----------\n'),
	schedule(ClassNum,SubTypeNum,SubCountList,[[1,1,3,1],[2,3,3,5]]).

% Set mode
%:-run_h.

%:-abort.
% Test different parameters
:-schedule(4,12,[5,5,2,2,2,2,2,1,1,1,1,1],[[1,3,1,1],[2,3,3,5]]).
:-write('----------'),nl.
:-schedule(3,12,[5,5,2,2,2,2,2,1,1,1,1,1],[[1,3,1,1],[2,3,3,5]]).
:-write('----------'),nl.
:-schedule(4,8,[5,5,2,2,2,1,1,2],[]).
:-write('----------'),nl.
:-schedule(5,12,[4,2,2,2,2,2,2,2,2,2,2,1],[[1,3,1,1],[2,3,3,5]]).