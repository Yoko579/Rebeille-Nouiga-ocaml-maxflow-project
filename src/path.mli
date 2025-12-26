open Graph

type path = id list

val find_path: int graph -> id list -> id -> id -> path option
val path2s: path option -> string
