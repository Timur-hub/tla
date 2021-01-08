# tla

1.tla/pluscal

semaphoreMutex
инвариант: для любого i, k in [1..N] : (i != k) =>  ! (CriticalSection(i) и CriticalSection(k)) 
выполнился без ошибок, скрин по ссылке -> 

deadlockEmpire Solutions tla+/pluscal

Simple Counter
/\  counter = 0
/\  pc = (0 :> "L1" @@ 1 :> "R1")

/\  counter = 0
/\  pc = (0 :> "L1" @@ 1 :> "R2")

/\  counter = 0
/\  pc = (0 :> "L2" @@ 1 :> "R2")

/\  counter = 1
/\  pc = (0 :> "L3" @@ 1 :> "R2")

/\  counter = 1
/\  pc = (0 :> "L1" @@ 1 :> "R2")

/\  counter = 2
/\  pc = (0 :> "L1" @@ 1 :> "R3")

/\  counter = 2
/\  pc = (0 :> "L2" @@ 1 :> "R3")

/\  counter = 3
/\  pc = (0 :> "L3" @@ 1 :> "R3")

/\  counter = 3
/\  pc = (0 :> "L1" @@ 1 :> "R3")

/\  counter = 3
/\  pc = (0 :> "L2" @@ 1 :> "R3")

/\  counter = 3
/\  pc = (0 :> "L2" @@ 1 :> "R4")

/\  counter = 4
/\  pc = (0 :> "L3" @@ 1 :> "R4")

/\  counter = 4
/\  pc = (0 :> "L1" @@ 1 :> "R4")

/\  counter = 4
/\  pc = (0 :> "L2" @@ 1 :> "R4")

/\  counter = 5
/\  pc = (0 :> "L3" @@ 1 :> "R4")

/\  counter = 5
/\  pc = (0 :> "L4" @@ 1 :> "R4")
FINISHED

Confused Counter
/\  first = 0
/\  pc = (0 :> "L1" @@ 1 :> "R1a")
/\  second = 0
/\  temp = 0
/\  temp_ = 0

/\  first = 0
/\  pc = (0 :> "L1" @@ 1 :> "R1b")
/\  second = 0
/\  temp = 1
/\  temp_ = 0

/\  first = 0
/\  pc = (0 :> "L2a" @@ 1 :> "R1b")
/\  second = 0
/\  temp = 1
/\  temp_ = 0

/\  first = 0
/\  pc = (0 :> "L2b" @@ 1 :> "R1b")
/\  second = 0
/\  temp = 1
/\  temp_ = 1

/\  first = 1
/\  pc = (0 :> "L3a" @@ 1 :> "R1b")
/\  second = 0
/\  temp = 1
/\  temp_ = 1

/\  first = 1
/\  pc = (0 :> "L3a" @@ 1 :> "R2a")
/\  second = 0
/\  temp = 1
/\  temp_ = 1

/\  first = 1
/\  pc = (0 :> "L3b" @@ 1 :> "R2a")
/\  second = 0
/\  temp = 1
/\  temp_ = 1

/\  first = 1
/\  pc = (0 :> "L4" @@ 1 :> "R2a")
/\  second = 1
/\  temp = 1
/\  temp_ = 1

/\  first = 1
/\  pc = (0 :> "L4" @@ 1 :> "R2b")
/\  second = 1
/\  temp = 2
/\  temp_ = 1

/\  first = 1
/\  pc = (0 :> "L4" @@ 1 :> "Done")
/\  second = 2
/\  temp = 2
/\  temp_ = 1

/\  first = 1
/\  pc = (0 :> "L5" @@ 1 :> "Done")
/\  second = 2
/\  temp = 2
/\  temp_ = 1
FINISHED
