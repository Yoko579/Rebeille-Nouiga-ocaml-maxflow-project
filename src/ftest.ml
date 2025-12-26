open Gfile
open Tools 
open Path
open Fulkerson


let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)
  
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)
  
  (* These command-line arguments are not used for the moment. *)
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  let int_graph = gmap graph int_of_string in
  
  (* __________TESTS TOOLS.ML __________ *)
  
  (* Test clone_nodes and export *)
  let graph_test_clone_nodes = clone_nodes graph in
  Printf.printf "[TEST CLONE_NODES] All nodes of the graph have been cloned into a new graph.\n";

  export graph_test_clone_nodes "tests/graph_test_export_clone_nodes.dot";
  Printf.printf "[TEST EXPORT CLONE_NODES] Graph exported to graph_test_export_clone_nodes.dot\n";

  (* Test gmap and export *)
  let graphe_test_gmap = gmap graph (fun x -> x ^ "a") in
  Printf.printf "[TEST GMAP & CLONE_NODES] All arc are concatenate with 'a'.\n";

  export graphe_test_gmap "tests/graph_test_export_gmap.dot";
  Printf.printf "[TEST EXPORT GMAP] Graph exported to graph_test_export_gmap.dot\n";
  
  (* Test add_arc and export *)
  let graph_test_add_arc_1 = add_arc (gmap graph (int_of_string)) 1 2 10 in
  Printf.printf "[TEST ADD_ARC] Arc 1 -> 2 's label passed from non-existent to '10'\n";

  let graph_test_export_add_arc_1 = (gmap graph_test_add_arc_1 (string_of_int)) in
  export graph_test_export_add_arc_1 "tests/graph_test_export_add_arc_1.dot";
  Printf.printf "[TEST EXPORT ADD_ARC] Graph exported to graph_test_export_add_arc_1.dot\n";


  let graph_test_add_arc_2 = add_arc (gmap graph int_of_string) 3 4 10 in
  Printf.printf "[TEST ADD_ARC] Arc 3 -> 4 's label passed from '5' to '15'.\n";
  
  let graph_test_export_add_arc_2 = (gmap graph_test_add_arc_2 string_of_int) in
  export graph_test_export_add_arc_2 "tests/graph_test_export_add_arc_2.dot";
  Printf.printf "[TEST EXPORT ADD_ARC] Graph exported to graph_test_export_add_arc_2.dot\n";

  (* __________TESTS PATH.ML __________ *)

  (* Test find_path *)
  let path_test = find_path int_graph [] 0 5 in
  Printf.printf "[TEST PATH] Path from 0 to 5 with no initial constraint: %s\n" (path2s path_test);
  let path_test = find_path int_graph [2; 4] 0 5 in
  Printf.printf "[TEST PATH] Path from 0 to 5 with nodes 2 and 4 forbidden: %s\n" (path2s path_test);

  (* __________TESTS FULKERSON.ML __________ *)

  (* Test min_capacity *)
  let example_path = [0; 3; 1; 5] in
  let min_cap = min_capacity int_graph example_path in
  Printf.printf "[TEST MIN_CAPACITY] Minimum capacity along path %s is %d.\n" (path2s (Some example_path)) min_cap;

  (* Test update_residual and export *)
  let updated_graph = update_residual int_graph example_path min_cap in
  Printf.printf "[TEST UPDATE_RESIDUAL] Updated graph after pushing flow %d along path %s:\n" min_cap (path2s (Some example_path));

  let graph_test_export_update_residual = gmap updated_graph string_of_int in
  export graph_test_export_update_residual "tests/graph_test_export_update_residual.dot";
  Printf.printf "[TEST EXPORT UPDATE_RESIDUAL] Graph exported to graph_test_export_update_residual.dot\n";

  (* Test Ford-Fulkerson Algorithm and export *)
  Printf.printf "\n\n\n[FORD FULKERSON TEST]\n\n";

  let (max_flow, residual_graph) = ford_fulkerson int_graph _source _sink in
  Printf.printf "[TEST FULKERSON] Maximum flow from %d to %d: %d\n" _source _sink max_flow;

  let graph_test_export_ford_fulkerson = gmap residual_graph string_of_int in
  export graph_test_export_ford_fulkerson "tests/graph_test_export_ford_fulkerson.dot";
  Printf.printf "[TEST EXPORT FULKERSON] Graph exported to tests/graph_test_export_ford_fulkerson.dot\n";
  
  let solution_fulkerson = residual_to_original int_graph residual_graph in 
  export solution_fulkerson "tests/solution_fulkerson.dot"; 
  Printf.printf "[TEST EXPORT RESIDUAL_TO_ORIGINAL] Final graph exported to tests/solution_fulkerson.dot\n";
  
  export graph "tests/original_graph.dot";

  Printf.printf "\n[INFO] Original graph exported to tests/original_graph.dot\n[INFO] Final graph exported to tests/solution_fulkerson.dot\n\n";


  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

  ()
