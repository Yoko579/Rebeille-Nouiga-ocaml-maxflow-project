open Graph

type path = id list

val is_id_in_list: id list -> id -> bool
val find_next_id: graph -> id list -> id -> id -> id list
val remove_last: id list -> id list
val retrieve_last_id: id list -> id
val find_path: int graph -> id list -> id -> id -> path option
val path2s: path option -> string
