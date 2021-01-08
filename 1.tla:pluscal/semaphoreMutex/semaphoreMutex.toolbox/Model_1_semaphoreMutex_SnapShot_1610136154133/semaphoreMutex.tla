--------------------------- MODULE semaphoreMutex ---------------------------
EXTENDS Naturals
CONSTANT N
ASSUME N \in Nat

(**********************
--algorithm SemaphoreMutex

variables counter = 1 ; 

macro Increase(c) begin when c > 0 ;
                 c := c - 1 ;
end macro

macro Decrease(c) begin c := c + 1 ;
end macro

process Proc \in 1..N
begin
start : while TRUE
         do enter : Increase(counter) ;
            criticalsection    : skip ;
            exit  : Decrease(counter) ;
        end while ;
end process

end algorithm
***********************)
\* BEGIN TRANSLATION (chksum(pcal) = "a1d0d874" /\ chksum(tla) = "f2d78c1b")
VARIABLES counter, pc

vars == << counter, pc >>

ProcSet == (1..N)

Init == (* Global variables *)
        /\ counter = 1
        /\ pc = [self \in ProcSet |-> "start"]

start(self) == /\ pc[self] = "start"
               /\ pc' = [pc EXCEPT ![self] = "enter"]
               /\ UNCHANGED counter

enter(self) == /\ pc[self] = "enter"
               /\ counter > 0
               /\ counter' = counter - 1
               /\ pc' = [pc EXCEPT ![self] = "criticalsection"]

criticalsection(self) == /\ pc[self] = "criticalsection"
                         /\ TRUE
                         /\ pc' = [pc EXCEPT ![self] = "exit"]
                         /\ UNCHANGED counter

exit(self) == /\ pc[self] = "exit"
              /\ counter' = counter + 1
              /\ pc' = [pc EXCEPT ![self] = "start"]

Proc(self) == start(self) \/ enter(self) \/ criticalsection(self)
                 \/ exit(self)

Next == (\E self \in 1..N: Proc(self))

Spec == Init /\ [][Next]_vars

\* END TRANSLATION 

CriticalSection(i) ==  (pc[i] = "criticalsection") 
Invariant == \A i, k \in 1..N : (i # k) => ~ (CriticalSection(i) /\ CriticalSection(k))
=============================================================================
\* Modification History
\* Last modified Fri Jan 08 23:02:15 MSK 2021 by eugenegoldyrev
\* Created Fri Jan 08 20:49:21 MSK 2021 by eugenegoldyrev
