open Graph


(* A path is a list of nodes. *)
type path = id list

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)

let rec find_path gr forbidden src dst =
  if src = dst then Some [dst]
  else
    if List.mem src forbidden then None
    else
    let rec try_arcs arcs =
      match arcs with
      | [] -> None
      | arc::rest ->
        if arc.lbl <= 0 then try_arcs rest
        else
        match find_path gr (src::forbidden) arc.tgt dst with
          | None -> try_arcs rest
          | Some p -> Some (src::p)
    in
    try_arcs (out_arcs gr src)


let path2s path = match path with
  | None -> "No path found"
  | Some list -> String.concat " -> " (List.map string_of_int list)
