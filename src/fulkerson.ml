open Graph
open Tools
open Path


(* Find the minimum capacity along a path *)
let rec min_capacity gr path =
  match path with
  | [] | [_] -> max_int
  | u::v::rest ->
    let {lbl;_} = match find_arc gr u v with
      | Some arc -> arc
      | None -> failwith "Arc not found"
    in
    min lbl (min_capacity gr (v::rest))


(* Update residual capacities along a path by 'flow' *)
let update_residual gr path flow =
  let rec aux g p =
    match p with
    | [] | [_] -> g
    | u::v::rest ->
      let g = 
        (* subtract flow from forward edge *)
        let {lbl;_} = match find_arc g u v with
          | Some arc -> arc
          | None -> failwith "Forward arc not found"
        in
        new_arc g {src=u; tgt=v; lbl=lbl-flow}
      in
      (* add flow to backward edge *)
      let g =
        match find_arc g v u with
        | Some arc -> new_arc g {src=v; tgt=u; lbl=arc.lbl+flow}
        | None -> new_arc g {src=v; tgt=u; lbl=flow}
      in
      aux g (v::rest)
  in
  aux gr path


let ford_fulkerson gr source sink =
  let rec aux g max_flow =
    match find_path g [] source sink with
    | None -> (max_flow, g)
    | Some path ->
      let flow = min_capacity g path in
      let g = update_residual g path flow in
      aux g (max_flow + flow)
  in
  aux gr 0


  let residual_to_original original_graph residual_graph =
    let base = gmap (clone_nodes original_graph) (fun _ -> "") in 
    e_fold original_graph (fun acc_graph arc_orig -> 
      match find_arc residual_graph arc_orig.src arc_orig.tgt with
     | None -> new_arc acc_graph { arc_orig with lbl = "0/"^ (string_of_int arc_orig.lbl) }
     | Some arc_res -> let flow = arc_orig.lbl - arc_res.lbl in 
      let label = (string_of_int flow)^"/"^ (string_of_int arc_orig.lbl) in 
      if flow > 0 then new_arc acc_graph{ arc_orig with lbl = label} else acc_graph
      ) base
