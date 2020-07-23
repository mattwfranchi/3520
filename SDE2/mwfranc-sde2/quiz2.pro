mystery(a,1).
mystery(b,2).

mysteryl([],0).
mysteryl([A|B],Soln) :- mystery(A,C), mysteryl(B,D), Soln is C+D.

gets_tenure(Faculty) :- publishes(Faculty), gets_research(Faculty), teaches_well(Faculty).

publishes(Professor) :- does_research(Professor), documents_research(Professor).

gets_research(Researcher) :- writes_proposals(Researcher), gets_funded(Researcher).

teaches_well(Educator) :- prepares_lectures(Educator), lectures_well(Educator),
    gets_good_evaluations(Educator).

prepares_lectures(rjs).
prepares_lectures(pw).
prepares_lectures(ts).
prepares_lectures(ak).

writes_proposals(rjs).
writes_proposals(pw).
writes_proposals(ak).
writes_propsals(ts).

gets_good_evaluations(rc).
gets_good_evaluations(pw).
gets_good_evaluations(rjs).
gets_good_evaluations(ts).

does_research(mab).
does_research(pw).
does_research(dan).
does_research(cb).
does_research(ts).

gets_funded(pw).
gets_funded(mab).
gets_funded(mab).
gets_funded(rc).
gets_funded(ts).
gets_funded(rjs).

documents_research(rjs).
documents_research(rc).
documents_research(dan).
documents_research(pw).

lectures_well(pw).
lectures_well(mab).
lectures_well(rjs).
lectures_well(rjs).
lectures_well(dan).
lectures_well(cb).
lectures_well(rc).
