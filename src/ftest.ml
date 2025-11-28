open Gfile
open Tools
    
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
  
  (* __________TESTS __________ *)

  (* Test clone_nodes *)
  let cloned_graph = clone_nodes graph in
  Printf.printf "Cloned graph created.\n";

  (* Test add_arc *)
  let graph_with_arc = add_arc cloned_graph 1 2 10 in
  Printf.printf "Arc 1 -> 2 with label 10 added.\n";

  (* Test gmap *)
  let doubled_graph = gmap graph_with_arc (fun arc -> {arc with lbl = arc.lbl * 2}) in
  Printf.printf "All arc labels doubled.\n";

  (* Test export *)
  export doubled_graph "doubled_graph.dot";
  Printf.printf "Graph exported to doubled_graph.dot\n";

  (* Rewrite the graph that has been read. *)
  let () = write_file outfile graph_test in

  ()

