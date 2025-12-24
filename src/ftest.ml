open Gfile
open Tools 
open Fulkerson

    
let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("      infile  : input file containing a graph\n" ^
         "      source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "      sink    : identifier of the sink vertex (ditto)\n" ^
         "      outfile : output file in which the result should be written.\n\n") ;
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

  
  (* __________TESTS __________ *)
  
  (* Test gmap and implicitly clone_nodes *)
  let graphe_test_gmap = gmap graph (fun x -> x) in
  Printf.printf "All arc are concatenate with 'a'.\n";
  
  (* Test export *)
  export graphe_test_gmap "graphe_test_gmap.dot";
  Printf.printf "Graph exported to graphe_test_gmap.dot\n";
  
  (* Test add_arc *)
  let graph_test_add_arc = add_arc (gmap graph (int_of_string)) 1 2 10 in
  Printf.printf "Arc 1 -> 2 with label 10 added.\n";

  let graph_test_export_add_arc = (gmap graph_test_add_arc (string_of_int)) in
  export graph_test_export_add_arc "graph_test_export_add_arc.dot";

  (*Test find_path*)
  let path_test = find_arc_path (gmap graph (int_of_string)) [] 0 10 in
  Printf.printf "%s\n%!" (path2s (find_node_path path_test));


  let all_paths =find_all_node_paths(gmap graph (int_of_string)) 0 10 in 
  Printf.printf "%d chemin(s) trouvé(s)\n%!" (List.length all_paths);

  List.iter (fun p -> Printf.printf "- %s\n%!" (path2s(Some p))) all_paths;
  (* Rewrite the graph that has been read. *)

  let all_paths_with_min = find_min_paths(gmap graph (int_of_string)) 0 10 in 
  Printf.printf "%d chemin(s) trouvé(s)\n%!" (List.length all_paths_with_min);

  List.iter (fun (p, f) -> Printf.printf "- %s pour valeur %d \n%!" (path2s(Some p)) f) all_paths_with_min;
  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph in

  ()

  


(*
Commandes terminal:

Convert graph to schema:
dot -Tsvg graphe_test_gmap.dot > sortie.svg

./ftest.exe graphs/graph1.txt 0 2 output_graph.txt

To activate debugging:
export OCAMLRUNPARAM="b"
*)
