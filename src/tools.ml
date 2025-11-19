(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes _gr = assert false
let gmap _gr _f = assert false
(* Replace _gr and _f by gr and f when you start writing the real function. *)

let clone_nodes gr = n_fold gr new_node empty_graph

let gmap gr f = resulted_graph = e_fold gr f empty_graph

let add_arc g id1 id2 n = 