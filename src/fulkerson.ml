open Graph
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
