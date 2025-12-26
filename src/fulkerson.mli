open Graph

val min_capacity : int graph -> Path.path -> int
val update_residual : int graph -> Path.path -> int -> int graph
val ford_fulkerson : int graph -> id -> id -> int * int graph
