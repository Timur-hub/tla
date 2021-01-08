# tla

1.tla/pluscal

semaphoreMutex
инвариант: для любого i, k in [1..N] : (i != k) =>  ! (CriticalSection(i) и CriticalSection(k))
