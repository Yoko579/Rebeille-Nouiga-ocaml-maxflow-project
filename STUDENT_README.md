___________________________________________________________
Student names:

Rebeille Thibault,
Nouiga Iness,
4IR Group A1 and A2.
___________________________________________________________
Description:

This project implements the Ford–Fulkerson algorithm to compute the maximum flow in a directed graph with capacities.

The program:
- Reads a graph from a file
- Computes the maximum flow between a source and a sink
- Builds the residual graph during the execution
- Reconstructs a readable flow graph where each edge is labeled as "flow/capacity"
- Exports intermediate and final graphs in DOT format for visualization
___________________________________________________________
Tests:

Several tests are executed automatically in ftest.ml to validate each part of the project:

- Tools.ml
  - clone_nodes: verifies that all nodes are correctly copied
  - gmap: verifies label transformation
  - add_arc: tests arc creation and capacity update

- Path.ml
  - find_path with and without forbidden nodes

- Fulkerson.ml
  - min_capacity on a sample path
  - update_residual and export of the updated graph
  - ford_fulkerson execution and export of the final residual graph
  - residual_to_original to produce the final flow graph

NB: Each test graph is exported to the tests/ directory.
    All exported graphs can be visualized using Graphviz.


Final test:
<!--

Here should be a description of the clean final test where we can find the original graph exported to tests/original_graph.dot and the final graph (after fulkerson application) exported to tests/solution_fulkerson.dot so that we can compare the two using conversion to svg file.


Mon fulkerson ne marche qu'avec le graphe 1, avec les autres ça veut pas, par exemple pour graphs/graph2.txt 0 3 j'ai un "Arc not found" alors que y a litteralement un arc là, je comprend pas ?

Je ne comprend pas l'utilité du fichier output_graph.txt qui est en paramètre de la commande terminal ?

Rmq: pour que ce soit plus propre, j'ai ajouté dans le dossier tests/ :
- sortie.svg que j'ai renommé en solution_fulkerson.dot
- original_graph.dot (nouveau fichier)

___________________________________________________________
Tuto to test the Fulkerson algorithm (for instance on graph1 for source 0 and sink 5):

In terminal:
./ftest.exe graphs/graph1.txt 0 5 tests/output_graph.txt

In code:
graphs/graph1.txt                -(export)->                        tests/original_graph.dot
tests/original_graph.dot         -(fulkerson application)->         tests/solution_fulkerson.dot

In terminal:
dot -Tsvg tests/original_graph.dot > tests/original.svg
dot -Tsvg tests/solution_fulkerson.dot > tests/final.svg

-->

___________________________________________________________
Command lines:

Launch the program:
./ftest.exe [input_file.txt] [src_vertex] [tgt_vertex] [output_file.txt]

Convert a DOT file to SVG for visualization:
dot -Tsvg path.dot > sortie.svg

Empty the tests folder:
make clean

Activate OCaml debugging:
export OCAMLRUNPARAM="b"

Example commands (frequently used):
./ftest.exe graphs/graph1.txt 0 5 output_graph.txt

dot -Tsvg tests/original_graph.dot > tests/original.svg
dot -Tsvg tests/solution_fulkerson.dot > tests/final.svg
___________________________________________________________
