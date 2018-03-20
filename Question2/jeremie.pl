%
% Read file to list
%
file_to_list(L, Name) :-
        open(Name, read, File),
        read_file(File,L),
        close(File), nl.
    
read_file(File,[]) :-
        at_end_of_stream(File).
    
read_file(File,[X|L]) :-
        \+ at_end_of_stream(File),
        read(File,X),
        read_file(File,L).
        
%
% Write to file
%
saveRoute(L, Name) :- 
    open(Name, write, File), 
    write_route(File, L), 
    close(File).
    
write_route(File, [point(Name,ValX,ValY), Y|L]) :- getdistance(point(Name,ValX,ValY), Y, D), 
        write(File, Name), write(File, ' 0'), write(File, '\n'), write_route(File, L, Y, D).

write_route(File, [], point(Name, X1, Y1), D) :-
    write(File, Name),
    write(File, ' '),
    write(File, D),
    write(File, '\n').
    
write_route(File, [X|L], point(Name, X1, Y1), Distance) :- 
    getdistance(X, point(Name, X1, Y1), D), 
    write(File, Name),
    write(File, ' '),
    write(File, Distance),
    write(File, '\n'),
    D2 is (Distance + D),
    write_route(File, L, X, D2).
    
%
% Main program
%
findRoute(L) :- file_to_list(L1, 'JsonTree.txt'), createTree(L1, L).

%
% Create tree
%
createTree(L, T) :- 
    westmost(L, West), 
    delete_point(West, L, LL),
    fillTree(West, LL, T).
    
fillTree(CurrentRoot, L, T) :- fillTree(CurrentRoot, L, [CurrentRoot], T).
fillTree(CurrentRoot, [], T, T).
fillTree(CurrentRoot, L, Acc, Solution) :- 
    shortestdistance(L, CurrentRoot, Closest),
    delete_point(Closest, L, LL),
    addPointLast(Closest, Acc, NewAcc),
    fillTree(Closest, LL, NewAcc, Solution),!.

addPointLast(Point, [], [Point]).
addPointLast(Point, [X|L], [X|LL]) :- addPointLast(Point, L,LL).

delete_point(Point, [], []).
delete_point(point(Name1, X1, Y1), [point(Name2, X2, Y2)|L], LL) :- Name1 == Name2, X1 == X2, Y1 == Y2, delete_point(Point, L, LL),!.
delete_point(Point, [X|L], [X|LL]) :- delete_point(Point, L, LL).
    
%
% Westmost point
%
point(_name, X, Y).	

west(point(Name1, X1, Y1), point(Name2, X2, Y2), Small) :- (X1 < X2), Small = point(Name1, X1, Y1),!.
west(point(Name1, X1, Y1), point(Name2, X2, Y2), Small) :- Small = point(Name2, X2, Y2).

westmost([X|Xs], West) :- westmost(Xs, X, West).

westmost([], West, West).
westmost([X|Xs], West0, West) :- 
    west(X, West0, West1),
    westmost(Xs, West1, West),!.
westmost([X|L], West, Acc) :- westmost(L, West, Acc), west(West, X, West).

%
% Distance
%
toradian(Val, ValR) :- ValR is (Val * pi/180).

dradians(Lat1, Lat2, Lon1, Lon2, D) :- D is (asin(sqrt( (((sin((Lat2 - Lat1)/2)) ** 2) + (((cos(Lat2)) * (cos(Lat1))) * ((sin((Lon1 - Lon2)/2)) ** 2)))))).

distance(Lat1, Lat2, Lon1, Lon2, D) :- 
        toradian(Lat1, Lat1R),
        toradian(Lat2, Lat2R),
        toradian(Lon1, Lon1R),
        toradian(Lon2, Lon2R),
        dradians(Lat1R, Lat2R, Lon1R, Lon2R, D1),
        D is (6371.0 * 2 * D1).

getdistance(point(Name1, X1, Y1), point(Name2, X2, Y2), D) :- distance(Y1, Y2, X1, X2, D).


%
% Closest Point
%
closestpoint(P1, P2, Origin, Closest) :- getdistance(P1, Origin, D1), getdistance(P2, Origin, D2), (D1 < D2), Closest = P1,!.
closestpoint(P1, P2, Origin, Closest) :- Closest = P2.

shortestdistance([X|L], Origin, Closest) :- shortestdistance(L, Origin, X, Closest).

shortestdistance([], Origin, Point, Point).
shortestdistance([P|Ps], Origin, Point, Closest) :- 
    closestpoint(Point, P, Origin, C1),
    shortestdistance(Ps, Origin, C1, Closest),!.