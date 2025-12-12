open Graph

(* A path is a list of nodes. *)
type path = id list

(* find_path gr forbidden id1 id2 
 *   returns None if no path can be found.
 *   returns Some p if a path p from id1 to id2 has been found. 
 *
 *  forbidden is a list of forbidden nodes (they have already been visited)
 *)

let rec is_id_in_list l id = match l with
  | [] -> false
  | x::rest -> if x = id then true else is_id_in_list rest id

let rec find_next_id gr forbidden actual_id id_list = match (out_arcs gr actual_id) with
  | [] -> []
  | x::rest -> if (is_id_in_list forbidden x) then find_next_id gr forbidden actual_id rest else [x]

let remove_last l = match List.rev l with
  | [] -> []
  | _::rest -> List.rev rest

let retrieve_last_id l = match List.rev l with
  | [] -> raise Not_found
  | x::rest -> x

let path2s path = match path with
  | None -> "No path."
  | Some path_list -> let string_path = List.map string_of_int path_list in
    String.concat ", " string_path

let find_path gr forbidden id1 id2 =
  match (out_arcs gr id1) with
    | [] -> None
    | _ ->
      let rec aux graph result forbidden actual_id dest_id =
        if is_id_in_list (out_arcs gr actual_id) dest_id then Some (result @ [dest_id])
        else match find_next_id gr forbidden actual_id (out_arcs gr actual_id) with
          | [] -> match remove_last result with
                | [] -> None
                | _ -> aux graph updated_list (forbidden @ [actual_id]) (retrieve_last_id result) dest_id
          | x::rest -> aux graph (result @ [x]) (forbidden @ [actual_id]) x dest_id
        in aux gr [id1] forbidden id1 id2

    (*faut ajouter le cas où on renvoit None
    réfléchir au cas de terminaison*)