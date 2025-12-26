open Graph


(* Returns a new graph having the same nodes than gr, but no arc. *)
let clone_nodes gr = n_fold gr new_node empty_graph


(*  Maps all arcs of gr by function f. *)
let gmap gr f = e_fold gr (fun graph_acc arc -> new_arc graph_acc ({arc with lbl = f arc.lbl})) (clone_nodes gr)


(* Adds n to the value of the arc between id1 and id2. If the arc does not exist, it is created. *)
(* Le graphe renvoyer n'est composé que de l'arc modifié or on veut tout le graphe*)

let add_arc g id1 id2 n =
  if not (node_exists g id1 && node_exists g id2) then raise (Graph_error "One of the nodes does not exist")
  else
    match find_arc g id1 id2 with
    | None -> new_arc g {src = id1; tgt = id2; lbl = n}
    | Some arc -> new_arc g {src = arc.src; tgt = arc.tgt; lbl = arc.lbl + n}
