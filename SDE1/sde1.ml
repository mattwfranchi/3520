(* Matt Franchi // CPSC 3520 // SDE 1 // Summer 2020 *)

(* Problem 1: First Duplicate in a List *)
(* Prototype: first_duplicate alist
    returns -10000 if there are no duplicates in integer list alist
            otherwise first duplicate in the integer list *)
(* Signature: val firstduplicate: int list -> int = <fun> *)
let rec first_duplicate = function alist ->
  if alist == [] then failwith "List cannot be empty." else
    if List.mem (List.hd alist) (List.tl alist) == true then List.hd alist
    else
      if List.tl alist == [] then -10000
      else
        first_duplicate (List.tl alist);;


(* Problem 2: First Non-Repeating Element in a List *)
(* Helper Function - tests to see if given list is of size 1
        a.k.a. the list is about to be empty after calling List.tl *)
let list_countdown = function alist ->
  if List.tl alist != [] then 0
    else 1;;

(* Prototype: first_nonrepeating alist
      "Find and return the first non-repeated element in the *entire* list"
      returns -10000 if no non-repeated element in integer alist
      otherwise first non-repeating element in alist *)
(* Signature: val first_nonrepeating : int list -> int = <fun> *)
let rec first_nonrepeating = function alist ->
  if alist == [] then failwith "List cannot be empty." else
    if List.mem (List.hd alist) (List.tl alist) == false then List.hd alist
    else
      if list_countdown(List.tl alist) == 1 then -10000
        else
          first_nonrepeating ((List.tl alist)@[List.hd alist]);;

(* Problem Three: The Sum of 2 Problem *)
(* Prototype: sumofTwo(a,b,v) *)
(* Signature: val sumOfTwo : int list * int list * int -> bool = <fun> *)
let rec sumOfTwo = function (a,b,v) ->
    if a == [] || b == [] then false else
      if List.hd a + List.hd b == v then true
      else sumOfTwo(List.tl a, b, v) || sumOfTwo(a, List.tl b, v);;


(* Problem Four: CYK Parsing Algorithm-Inspired Problem *)
(* Prototype: cyk_sublists n *)
(* Signature: val cyk_sublists : int -> (int * int) list = <fun> *)
let rec make_decreasing_sublist = function n ->
  if n>1 then (n-1)::make_decreasing_sublist(n-1) else [];;

let reverse =
  let rec rev_append acc alist =
    match alist with
      [] -> acc
      | h::t -> rev_append (h::acc) t in
    function alist -> rev_append [] alist;;

let rec pairwise alista alistb =
match alista, alistb with
    | [], _ -> []
    | _, [] -> []
    | hd :: tl, hd2 :: tl2 -> (hd, hd2) :: (pairwise tl tl2)

let rec cyk_sublists = function n ->
(pairwise (reverse(make_decreasing_sublist(n))) (make_decreasing_sublist(n)));;
