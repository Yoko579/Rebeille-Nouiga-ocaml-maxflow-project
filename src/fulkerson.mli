open Graph

type path = id list

val is_id_in_list: id list -> id -> bool
val find_next_id: id graph -> id arc list -> id -> id arc list -> id arc list
val remove_last: id list -> id list
val retrieve_last_id: id list -> id
val path2s: path option -> string
val find_arc_path: int graph -> id arc list -> id -> id-> id arc list option
val find_node_path: id arc list option -> path option
