open Graph

val min_capacity : int graph -> Path.path -> int
val update_residual : int graph -> Path.path -> int -> int graph
val ford_fulkerson : int graph -> id -> id -> int * int graph
val residual_to_original : id graph -> id graph -> string graph
val residual_to_original_money_sharing : id graph -> id graph -> string graph