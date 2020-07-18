/* first_duplicate/2

Prototype: first_duplicate(+Alist,-Dup)

if succeeds, binds Dup to first duplicate in Alist,
fails otherwise (no duplicates)

Sample Use:

?- first_duplicate([1,2,3,4,5,6,7,4,5,8,9],W).
W = 4.

*/
/* CASE: Alist is empty (Alist = []) */
first_duplicate(Alist, _) :- length(Alist,0), !, fail.

/* CASE: Alist is length 1 (therefore no duplicates) */
first_duplicate(Alist, _) :- length(Alist,1), !, fail.

/* CASE: Head of Alist is a duplicate */
first_duplicate([H|T], Dup) :-
  member(H,T), Dup is H.

/* RECURSIVE CASE */
first_duplicate([_|T],Dup) :-
  first_duplicate(T,Dup).


/* first_nonrepeating/2

Prototype: first_nonrepeating(+Alist,-Which).
"Determine the first non-repeated element (Which) in the *entire* list" (Alist)
fails if no repeated elements in Alist.
*/


/* CASE: Alist is empty (Alist = []) */
first_nonrepeating(Alist,_) :- length(Alist,0), !, fail.

/* CASE: Alist is length one, therefore Which is H */
first_nonrepeating([H|T],Which) :- length([H|T],1), !, Which is H.

/* CASE: all elements in the list are the same, so fail */
first_nonrepeating([H|T],_) :- sort([H|T],[H]), !, fail.

/* CASE: head is non-repeating therefore Which is H */
first_nonrepeating([H|T],Which) :-
  not(member(H,T)), Which is H.

/* RECURSIVE CASE */
first_nonrepeating([H|T],Which) :-
  append(T,[H],Alist),
  first_nonrepeating(Alist,Which).
