/* SHARED HELPER FUNCTIONS */

/* is_member, recreation of member/2 built-in predicate */
is_member([],[]).
is_member(H,[H|_]).
is_member(N,[_|T]) :-
    is_member(N,T).

/* get_length, manual recreation of length/2 built-in predicate */
/* user calls get_length/2, gets fed to get_length/3 which has an index value */
get_length(Alist, get_length) :-
    get_length(Alist,0,get_length).


get_length([],get_length,get_length).
get_length([_|Alist], N, get_length) :-
    Next is N+1,
    get_length(Alist,Next,get_length).


/* first_duplicate/2

Prototype: first_duplicate(+Alist,-Dup)

if succeeds, binds Dup to first duplicate in Alist,
fails otherwise (no duplicates)

Sample Use:

?- first_duplicate([1,2,3,4,5,6,7,4,5,8,9],W).
W = 4.

*/
/* CASE: Alist is empty (Alist = []) */
first_duplicate(Alist, _) :-
    get_length(Alist,0), !, fail.

/* CASE: Alist is get_length 1 (therefore no duplicates) */
first_duplicate(Alist, _) :-
    get_length(Alist,1), !, fail.

/* CASE: Head of Alist is a duplicate */
first_duplicate([H|T], Dup) :-
    is_member(H,T),
    Dup is H.

/* RECURSIVE CASE */
first_duplicate([_|T],Dup) :-
    first_duplicate(T,Dup).


/* first_nonrepeating/2

Prototype: first_nonrepeating(+Alist,-Which).
"Determine the first non-repeated element (Which) in the *entire* list" (Alist)
fails if no repeated elements in Alist.
*/

/* helper function remove_all/3 - remove all instances of N from Alist, put
    sorted list in Sorted.
    Prototype: remove_all(N,Alist,Sorted). */

remove_all(_,[],[]).
remove_all(N,[N|T],L) :-
    remove_all(N,T,L), !.
remove_all(N,[H|T],[H|L]) :-
    remove_all(N,T,L).

/* CASE: Alist is empty (Alist = []) */
first_nonrepeating(Alist,_) :-
    get_length(Alist,0), !, fail.

/* CASE: Alist is get_length one, therefore Which is H */
first_nonrepeating([H|T],Which) :-
    get_length([H|T],1), !,
    Which is H.

/* CASE: head is non-repeating therefore Which is H */
first_nonrepeating([H|T],Which) :-
    \+ is_member(H,T),
    Which is H.

/* RECURSIVE CASE */
first_nonrepeating([H|T],Which) :-
  remove_all(H,[H|T],Filtered),
  first_nonrepeating(Filtered,Which).


/* sum_of_two/3

Two arrays contain numbers able to produce a given sum.
Prototype: sum_of_two(+A,+B,+V)

*/

/* CASE: A is [] therefore fail, no backtracking */
sum_of_two(A,_,_) :-
    get_length(A,0), !, fail.

/* CASE: B is [] therefore fail, no backtracking */
sum_of_two(_,B,_) :-
    get_length(B,0), !, fail.

/* CASE: Success - Head of A + Head of B = V */
sum_of_two([AH|_],[BH|_],V) :-
    Sum is AH + BH, Sum =:= V.

/* RECURSIVE CASE: retry without head of A */
sum_of_two([_|AT],B,V) :-
    sum_of_two(AT,B,V).

/* RECURSIVE CASE: retry without head of B */
sum_of_two(A,[_|BT],V) :-
    sum_of_two(A,BT,V).


/* cyk_sublists/2

Given N, return a list of lists (Decompositions), where each sublist
indicates how a string of get_length N could be formed from 2 strings.
[(1,n-1)],[2,n-2],...,[n-1,1]] is returned as a Prolog list

Prototype: cyk_sublists(+N, -Decompositions)

*/

/* FACTS */
cyk_sublists(0,[[]]).
cyk_sublists(1,[[]]).

/* BASE CASE: feed into recgen */
cyk_sublists(N,D) :-
    Next is N-1,
    recgen([1,Next],D).

/* recgen - recursively generates list of lists according to cyk algorithm */

/* if given empty list of lists, return empty list of lists */
recgen([[]],[[]]).

/* generate the list recursively while Y is greater than 1 */
recgen([X|Y],[[X|Y]|T]) :-
    Y > 1,
    X1 is X+1, Y1 is Y-1,
    Next = [X1,Y1],
    recgen(Next,T).

/* FINAL CASE: if Y is 1, then [[X,1]] */
recgen([X,1],[[X,1]]).
