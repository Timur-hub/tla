----------------------------- MODULE semaphore -----------------------------
EXTENDS Naturals

(* --algorithm semaphore

variables semaphore = 0; p1InCriticalSection = FALSE; p2InCriticalSection = FALSE;

macro semaphoreTake(n) begin
    await ( semaphore >= n );
    semaphore := semaphore - n;
end macro;

macro semaphoreGive(n) begin
    semaphore := semaphore + n;
end macro;

process p1 = 0

begin
P1_1: while (TRUE) do
P1_2:   semaphoreTake(1); 
P1_3:   p1InCriticalSection := TRUE;
P1_4:   p1InCriticalSection := FALSE;
P1_5:   semaphoreGive(1);
    end while;
    
end process;
process p2 = 1
begin
P2_1: while (TRUE) do 
P2_2:   if (semaphore > 0) then
            semaphoreTake(1);
P2_3:       p2InCriticalSection := TRUE;
P2_4:       p2InCriticalSection := FALSE;
P2_5:       semaphoreGive(1);
        else
P2_6:       semaphoreGive(1);
        end if;
    end while;
end process;

end algorithm--*)
\* BEGIN TRANSLATION (chksum(pcal) = "6ed15e58" /\ chksum(tla) = "b1d8262f")
VARIABLES semaphore, p1InCriticalSection, p2InCriticalSection, pc

vars == << semaphore, p1InCriticalSection, p2InCriticalSection, pc >>

ProcSet == {0} \cup {1}

Init == (* Global variables *)
        /\ semaphore = 0
        /\ p1InCriticalSection = FALSE
        /\ p2InCriticalSection = FALSE
        /\ pc = [self \in ProcSet |-> CASE self = 0 -> "P1_1"
                                        [] self = 1 -> "P2_1"]

P1_1 == /\ pc[0] = "P1_1"
        /\ pc' = [pc EXCEPT ![0] = "P1_2"]
        /\ UNCHANGED << semaphore, p1InCriticalSection, p2InCriticalSection >>

P1_2 == /\ pc[0] = "P1_2"
        /\ ( semaphore >= 1 )
        /\ semaphore' = semaphore - 1
        /\ pc' = [pc EXCEPT ![0] = "P1_3"]
        /\ UNCHANGED << p1InCriticalSection, p2InCriticalSection >>

P1_3 == /\ pc[0] = "P1_3"
        /\ p1InCriticalSection' = TRUE
        /\ pc' = [pc EXCEPT ![0] = "P1_4"]
        /\ UNCHANGED << semaphore, p2InCriticalSection >>

P1_4 == /\ pc[0] = "P1_4"
        /\ p1InCriticalSection' = FALSE
        /\ pc' = [pc EXCEPT ![0] = "P1_5"]
        /\ UNCHANGED << semaphore, p2InCriticalSection >>

P1_5 == /\ pc[0] = "P1_5"
        /\ semaphore' = semaphore + 1
        /\ pc' = [pc EXCEPT ![0] = "P1_1"]
        /\ UNCHANGED << p1InCriticalSection, p2InCriticalSection >>

p1 == P1_1 \/ P1_2 \/ P1_3 \/ P1_4 \/ P1_5

P2_1 == /\ pc[1] = "P2_1"
        /\ pc' = [pc EXCEPT ![1] = "P2_2"]
        /\ UNCHANGED << semaphore, p1InCriticalSection, p2InCriticalSection >>

P2_2 == /\ pc[1] = "P2_2"
        /\ IF (semaphore > 0)
              THEN /\ ( semaphore >= 1 )
                   /\ semaphore' = semaphore - 1
                   /\ pc' = [pc EXCEPT ![1] = "P2_3"]
              ELSE /\ pc' = [pc EXCEPT ![1] = "P2_6"]
                   /\ UNCHANGED semaphore
        /\ UNCHANGED << p1InCriticalSection, p2InCriticalSection >>

P2_3 == /\ pc[1] = "P2_3"
        /\ p2InCriticalSection' = TRUE
        /\ pc' = [pc EXCEPT ![1] = "P2_4"]
        /\ UNCHANGED << semaphore, p1InCriticalSection >>

P2_4 == /\ pc[1] = "P2_4"
        /\ p2InCriticalSection' = FALSE
        /\ pc' = [pc EXCEPT ![1] = "P2_5"]
        /\ UNCHANGED << semaphore, p1InCriticalSection >>

P2_5 == /\ pc[1] = "P2_5"
        /\ semaphore' = semaphore + 1
        /\ pc' = [pc EXCEPT ![1] = "P2_1"]
        /\ UNCHANGED << p1InCriticalSection, p2InCriticalSection >>

P2_6 == /\ pc[1] = "P2_6"
        /\ semaphore' = semaphore + 1
        /\ pc' = [pc EXCEPT ![1] = "P2_1"]
        /\ UNCHANGED << p1InCriticalSection, p2InCriticalSection >>

p2 == P2_1 \/ P2_2 \/ P2_3 \/ P2_4 \/ P2_5 \/ P2_6

(* Allow infinite stuttering to prevent deadlock on termination. *)
Terminating == /\ \A self \in ProcSet: pc[self] = "Done"
               /\ UNCHANGED vars

Next == p1 \/ p2
           \/ Terminating

Spec == Init /\ [][Next]_vars

Termination == <>(\A self \in ProcSet: pc[self] = "Done")

\* END TRANSLATION 
DoubleEnterCriticalSection == p1InCriticalSection = FALSE \/ p2InCriticalSection = FALSE
=============================================================================
\* Modification History
\* Last modified Fri Jan 08 00:12:39 MSK 2021 by eugenegoldyrev
\* Created Thu Jan 07 23:30:14 MSK 2021 by eugenegoldyrev
