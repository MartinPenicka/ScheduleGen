

get_class_num(ClassNum):-
	write('Inser number of classes :'),
	read(ClassNum),
	write('\nNumber of classes :'),
	write(ClassNum),
	write('\n').

get_sub_per_day(SubPerDay):-
	write('Subjects number in single day (every day has same number of subjects) :'),
	read(SubPerDay),
	write('\nNumber of subjects per day : '),
	write(SubPerDay),
	write('\n').

get_sub_amount(SubTypeNum):-
	write('Insert amount of subject types : '),
	read(SubTypeNum),
	write('Number of subjects : '),
	write(SubTypeNum),
	write('\n').

get_sub_type_list(SubCountList):-
	write('Insert list with count of subject types in week (3* math, 4* language,.. -> in form [3,4,..]) :'),
	read(SubCountList),
	write('Subject list : '),
	write(SubCountList),
	write('\n').
