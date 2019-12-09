% Methods to help distance calculation
toradian(X,Y):- Y is X * pi / 180.

a(Lat1, Lon1, Lat2, Lon2, A):-
    toradian(Lat1,Lat1r),
    toradian(Lat2,Lat2r),
    toradian(Lon1,Lon1r),
    toradian(Lon2,Lon2r),
    A is (sin((Lat2r - Lat1r)/2)**2) + (cos(Lat1r) * cos(Lat2r) * (sin((Lon2r-Lon1r)/2))**2 ).

distance(Lat1, Lon1, Lat2, Lon2, D):- a(Lat1, Lon1, Lat2, Lon2, A), D is 2 * asin(sqrt(A)) * 6371.

p2pdistance(point(_, Lat1, Lon1), point(_, Lat2, Lon2), D) :- distance(Lat1, Lon1, Lat2, Lon2, D).



% Helper methods for file loading and whatnot

% Read file to list
file_to_list(List, Filename) :-
    open(Filename, read, Stream),
    read_file(Stream,List),
    close(Stream),
    nl.
    
read_file(File,[]) :-
    at_end_of_stream(File).
    
read_file(File,[X|L]) :-
    \+ at_end_of_stream(File),
    read(File,X),
    read_file(File,L).
        

% Writing a list to a file
write_file(L, Filename) :- 
    open(Filename, write, Stream), 
    print_route(Stream, L), 
    close(Stream).

print_route(Filename, [pool(Name,Lat,Lon), H|T]) :- 
    p2pdistance(point(Name, Lat, Lon), H, D), 
    write(Filename, Name), 
    write(Filename, ' 0'), 
    write(Filename, '\n'), 
    print_route(Filename, T, H, D).

print_route(Filename, [], pool(Name, _, _), D) :- 
    write(Filename, Name), 
    write(Filename, ' '), 
    write(Filename, D), 
    write(Filename, '\n').

print_route(Filename, [H|T], pool(Name, Lat, Lon), Dist) :- 
    p2pdistance(H, point(Name, Lat,Lon), D), 
    write(Filename, Name), 
    write(Filename, ' '), 
    write(Filename, Dist), 
    write(Filename, '\n'), 
    NextD is (Dist + D), 
    print_route(Filename, T, H, NextD).
% Everything above is basically appending the different things we need to when we generate the answer

% Main entry point in the program
findRoute(L) :- file_to_list(List, 'pools.pl'), treeFactory(List, L).

% Now the 'tree' is only going to have one child, because my algorithm is better, NA! :P

treeFactory(List, Tree):- 
    find_westmost(List, Point),
    remove_point(Point, List, NewL), % Removing the point from our initial list
    populate(Point, NewL, Tree).


% First let's try to get the point that is westmost
point(A, X, Y).
is_west_of(point(A, Lat1, Lon1), point(B, Lat2, Lon2), Result) :- 
    (Lon1 < Lon2), 
    Result = point(A, Lat1, Lon1). 
    % Gotta probably add the vars that I removed
is_west_of(point(A, Lat1, Lon1), point(B, Lat2, Lon2), Result) :- 
    Result = point(B, Lat2, Lon2). 
    % Gotta probably add the vars that I removed

find_westmost([H|T], Point) :- find_westmost(T, H, Point).
find_westmost([], Point, Point).
find_westmost([H|T], Point1, Point) :- 
    is_west_of(H, Point1, Point2),
    find_westmost(T, Point2, Point), !.
find_westmost([H|T], Point, A) :- find_westmost(T, Point, A), is_west_of(Point, H, Point).



% ayy let's populate the damn tree already
populate(Root, List, Tree) :-
    populate(Root, List, [Root], Tree).
populate(Root, [], Tree, Tree).
populate(Root, List, A, Answer) :-
    find_closest_to_root(List, Root, Point),
    remove_point(Point, List, NewL),
    push_point(Point, A, NewA),
    populate(Point, NewL, NewA, Answer), !.

% oh shit, code won't write itself anytime soon, this ain't java. Here goes
is_closest_to(A, B, Root, Point) :- 
    p2pdistance(A, Root, Dist1),
    p2pdistance(B, Root, Dist2),
    (Dist1 < Dist2),
    Point = A, !.
is_closest_to(A, B, Root, Point) :- Point = B.

find_closest_to_root([H|T], Root, Point) :-
    find_closest_to_root(T, Root, H, Point).
find_closest_to_root([], Root, Point, Point).
find_closest_to_root([H|T], Root, Point, Answer) :-
    is_closest_to(Point, H, Root, A),
    find_closest_to_root(T, Root, A, Answer),!.

% Finally, pushing a point to the end of a list
push_point(Point, [], [Point]).
push_point(Point, [H1|T1], [H2|T2]) :-
    push_point(Point, T1, T2).

