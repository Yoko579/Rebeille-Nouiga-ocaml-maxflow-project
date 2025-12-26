___________________________________________________________
Student names:

Rebeille Thibault,
Nouiga Iness,
4IR Group A1 and A2.
___________________________________________________________
Description: <!-- TODO complete -->

This project implements the Ford-Fulkerson algorithm. <!-- more blabla... -->
___________________________________________________________
Tests: <!-- TODO complete -->

<!-- blabla... -->
___________________________________________________________
Command lines:

Launch ftest.exe:
./ftest.exe [input_file.txt] [src_vertex] [tgt_vertex] [output_file.txt]

Convert graph to schema to visualize it on sortie.svg:
dot -Tsvg [path.dot] > sortie.svg

Empty the test folder:
We added a command in the Makefile to empty the test folder with:
make clean

Activate debugging:
export OCAMLRUNPARAM="b"
___________________________________________________________


____________________________________________________________
<!-- TODO delete it before submitting the project -->
Yoyo's draft (to be deleted):
./ftest.exe graphs/graph1.txt 0 5 output_graph.txt
dot -Tsvg test/graph_test_export_ford_fulkerson.dot > sortie.svg


Minimal acceptable project: you should at least implement the Ford-Fulkerson algorithm (in a separate module) and test it on several examples.

    You all remember the 3 MIC lecture on Graphs by Marie-Jo Huguet, and the associated Moodle resources graphes2024
    An interactive presentation of the algorithm.
    A french presentation of flow problems (see "Algorithmes des graphes / Flots"). 
