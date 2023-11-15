# :fire:-Graphs: Graph Analysis in Mojo

**Mojo-Graphs** is a graph analysis library written in the mojo programming
language

## About
This library aims to be _container_-agnostic in the sense that it should be
possible to use graph algorithms regardless of what underlying graph
representation (e.g. Adjacency List, Adjacency Matrix (symmetric,
non-symmetric)) has been chosen [^1].

To make this possible all container structures need to have some common
functions, e.g.

- `add_node()`
- `add_edge()`
- `get_neighbors(node)`
- etc.

[^1]: I got this nice idea from the boost library

## Roadmap

__Basic Datastructures for representing Graphs__
- [x] Symmetric Matrix ( _simple graphs_ )
- [ ] Matrix ( _directed graphs_ )
- [ ] Adjacency Lists 


