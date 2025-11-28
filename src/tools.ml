(* Yes, we have to repeat open Graph. *)
open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes _gr = assert false
let gmap _gr _f = assert false
(* Replace _gr and _f by gr and f when you start writing the real function. *)

(* Returns a new graph having the same nodes than gr, but no arc. *)
let clone_nodes gr = n_fold gr new_node empty_graph

(*  Maps all arcs of gr by function f. *)
let gmap gr f = e_fold gr f empty_graph

(* Adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created. *)
let add_arc g id1 id2 n =
  if not (node_exists g id1 && node_exists g id2) then raise (Graph_error "One of the nodes does not exist")
  else
    match find_arc g id1 id2 with
    | None -> new_arc g {src = id1; tgt = id2; lbl = n}
    | Some arc -> new_arc g {src = arc.src; tgt = arc.tgt; lbl = arc.lbl + n}
