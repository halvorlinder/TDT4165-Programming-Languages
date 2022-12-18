% 1 

:- use_module(library(clpfd)).

payment(0, []).
payment(Sum, [coin(Quantity, Value, Available)|Tail]) :-
    Quantity #> -1,
    Quantity #< Available + 1,
    Sum #= Value*Quantity + TailTotal,
    payment(TailTotal, Tail).


% 2.1

distance(c1, c2, 10, 1). distance(c1, c3, 0, 0). distance(c1, c4, 7, 1).
distance(c1, c5, 5, 1). distance(c2, c3, 4, 1). distance(c2, c4, 12, 1).
distance(c2, c5, 20, 1). distance(c3, c4, 0, 0). distance(c3, c5, 0, 0).
distance(c4, c5, 0, 0). distance(c2, c1, 10, 1). distance(c3, c1, 0, 0).
distance(c4, c1, 7, 1). distance(c5, c1, 5, 1). distance(c3, c2, 4, 1).
distance(c4, c2, 12, 1). distance(c5, c2, 20, 1). distance(c4, c3, 0, 0).
distance(c5, c3, 0, 0). distance(c5, c4, 0, 0).

plan(Start, End, Path, Distance) :-
    planInternal(Start, End, Path, Distance, []).

planInternal(End, End, [End], 0 , Seen) :-
    \+ member(End, Seen).

planInternal(Start, End, Path, Distance, Seen) :-
    distance(Start, Next, D, HasEdge), 
    HasEdge = 1,
    \+ member(Start, Seen),
    Distance #= TailDistance + D,
    Path = [Start|TailPath],
    TailSeen = [Start|Seen],
    planInternal(Next, End, TailPath, TailDistance, TailSeen).

% 2.2

bestPlan(Start, End, Path, Distance) :- 
    plan(Start, End, Path, Distance), 
    forall(plan(Start, End, _, Distance2), Distance #=< Distance2).
