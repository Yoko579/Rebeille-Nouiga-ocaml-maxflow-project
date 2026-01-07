___________________________________________________________
Student names:

Rebeille Thibault,
Nouiga Iness,
4IR Group A1 and A2.
___________________________________________________________
Base project for Ocaml project on Ford-Fulkerson. This project contains some simple configuration files to facilitate editing Ocaml in VSCode.

To use, you should install the *OCaml Platform* extension in VSCode.
Then open VSCode in the root directory of this repository (command line: `code path/to/ocaml-maxflow-project`).

Features :
 - full compilation as VSCode build task (Ctrl+Shift+b)
 - highlights of compilation errors as you type
 - code completion
 - view of variable types


A [`Makefile`](Makefile) provides some useful commands:

 - `make build` to compile. This creates an `ftest.exe` executable
 - `make demo` to run the `ftest` program with some arguments
 - `make format` to indent the entire project
 - `make edit` to open the project in VSCode
 - `make clean` to remove build artifacts

In case of trouble with the VSCode extension (e.g. the project does not build, there are strange mistakes), a common workaround is to (1) close vscode, (2) `make clean`, (3) `make build` and (4) reopen vscode (`make edit`).

___________________________________________________________
Description:

This project implements the Ford–Fulkerson algorithm to compute the maximum flow in a directed graph with capacities.

The program:
- Reads a graph from a file
- Computes the maximum flow between a source and a sink
- Builds the residual graph during the execution
- Reconstructs a readable flow graph where each edge is labeled as "flow/capacity"
- Exports intermediate and final graphs in DOT format for visualization (after converting it in SVG)
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
    The min_capacity test is specific to graph1, to test it on other graphs, we must change the example_path.
    The unitary tests are in comment to focus on the main test but can be uncommented quickly in ftest.ml.
___________

Explanation of how the Fulkerson algorithm test works (for instance on graph1 for source 0 and sink 5):

In terminal:
./ftest.exe graphs/graph1.txt 0 5 tests/output_graph.txt

In code:
graphs/graph1.txt                -(export)->                        tests/original_graph.dot
tests/original_graph.dot         -(fulkerson application)->         tests/solution_fulkerson.dot

In terminal:
dot -Tsvg tests/original_graph.dot > tests/original.svg
dot -Tsvg tests/solution_fulkerson.dot > tests/final.svg

We can then compare this two graphs.

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
___________________________________________________________
