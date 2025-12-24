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

let rec find_next_id gr forbidden actual_id id_list = match id_list with
  | [] -> []
  | x::rest -> if (is_id_in_list forbidden x) then find_next_id gr forbidden actual_id rest else [x] (*le rest n'est pas prit en compte dans la fct, on fait une boucle sur la meme chose x sera toujours là*)

let remove_last l = match List.rev l with
  | [] -> []
  | _::rest -> List.rev rest

let retrieve_last_id l = match List.rev l with
  | [] -> raise Not_found
  | x::_ -> x

(* let path2s path = match path with
  | None -> "No path."
  | Some path_list -> let string_path = List.map string_of_int path_list in
    String.concat ", " string_path *)

let path2s path = match path with
  | None -> "No path."
  | Some path_list -> match path_list with
    | [] -> "Already in destination."
    | x::rest -> let string_path = List.map (fun id -> string_of_int id) (x::rest) in
      String.concat " -> " string_path

let find_arc_path gr forbidden id1 id2 =
  match (out_arcs gr id1) with
    | [] -> None
    | _ ->
      let rec aux result forbidden actual_id =
        match find_next_id gr forbidden actual_id (out_arcs gr actual_id) with
          | x::_ -> if x.tgt==id2 then Some (result @ [x])
                    else aux (result @ [x]) (forbidden @ [x]) x.tgt
          | [] -> match remove_last result with
                | [] -> None
                | updated_list -> aux updated_list forbidden (retrieve_last_id result).tgt 
          
        in aux [] forbidden id1
(* ajouter l element en debut de list *)
(* ne pas faire le travail d'une fonction récursive et utiliser le resultat de: aux (result @ [x]) (forbidden @ [x]) x.tgt, si on trouve rien on appelle aux result (forbidden @ [x]) ?.tgt sinon ?*)

let find_node_path arc_path =
  match arc_path with
    | None -> None
    | Some qqchose -> match qqchose with
        | [] -> None
        | x::_ -> Some (x.src :: (List.map (fun arc -> arc.tgt) qqchose))


let find_all_node_paths gr id1 id2 =
  let rec aux current_path forbidden actual_id accu =
    if actual_id = id2 then (List.rev (actual_id :: current_path)) :: accu
    else
      let voisins = out_arcs gr actual_id in 
      List.fold_left (fun current_accu arc -> if List.mem arc.tgt forbidden then current_accu
      else 
        aux (actual_id :: current_path) (actual_id :: forbidden) arc.tgt current_accu)
    accu voisins

      in aux [] [] id1 []   

let find_min_paths gr id1 id2 =
  let rec aux current_path current_min forbidden actual_id accu =
    if actual_id = id2 then 
      let final_path = (List.rev (actual_id :: current_path)) in (final_path, current_min):: accu
    else
      let voisins = out_arcs gr actual_id in 
      List.fold_left (fun current_accu arc -> if List.mem arc.tgt forbidden then current_accu
      else 
        let new_min= min current_min arc.lbl in
        aux (actual_id :: current_path) new_min (actual_id :: forbidden) arc.tgt current_accu)
    accu voisins

      in aux [] max_int [] id1 []   
