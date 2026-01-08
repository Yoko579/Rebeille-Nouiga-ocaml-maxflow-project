open Graph

let diffs_list paid_list =
  let amount = List.fold_left (+.) 0.0 paid_list in
  let n = List.length paid_list in
  let due_per_person = amount /. (float_of_int n) in
  List.map (fun paid -> paid -. due_per_person) paid_list


let graph_of_names names diffs =

  (* Add nodes: source (0), sink (1), then persons starting at id=2 *)
  let rec add_nodes g id names = match names with
    | [] -> g
    | _::rest ->
      let g = new_node g id in
      add_nodes g (id+1) rest
    in
    let g = empty_graph in
    let g = new_node g 0 in
    let g = new_node g 1 in
    let g = add_nodes g 2 names in

  (* Add infinite capacity edges between all persons *)
  let n = (List.length names + 2) in
  let rec add_edges g i j =
    if i >= n then g
    else if j >= n then add_edges g (i+1) 2
    else let g = if i <> j then new_arc g {src = i; tgt = j; lbl = 10000.} else g
    in
    add_edges g i (j+1)
  in
  let g = add_edges g 2 2 in

  (* Add edges from source or to sink based on diffs *)
  let rec add_diff_edges g index diffs =
    if index > (List.length names + 2) then g
    else match diffs with
    | [] -> g
    | diff::rest ->
      let g =
        if diff < 0. then new_arc g {src = 0; tgt = index; lbl = (-1.)*.diff}
        else if diff > 0. then new_arc g {src = index; tgt = 1; lbl = diff}
        else g
        in
        add_diff_edges g (index + 1) rest
  in add_diff_edges g 2 diffs
