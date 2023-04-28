This folder contains the MATLAB code for Greedy Gossip with Eavesdropping (GGE) algorithm. For details check the technical report at:
http://arxiv.org/PS_cache/arxiv/pdf/0909/0909.1830v1.pdf

For more information contact Deniz Ustebay at: deniz.ustebay@mail.mcgill.ca

Folders and content:

comparisons: Simulates Greedy Gossip with Eavesdropping with Randomized Gossip and Geographic Gossip for different field and network topology choices. Run main.m to generate gossip data and plot the comparison of algorithms in terms of relative error vs number of transmissions. The simulation parameters are described at the beginning of the file.


bound: Simulates bounds on GGE performance. The bound A(G) is numerically calculated using randomized incremental subgradient algorithm. Run main_AGvsnodes,m to see how bound scales with network size and run main_boundvsperf.m to see the performance of the algorithm for different fields and compare the performance with the theoretical bound. 


initialization: Simulates initialization schemes for GGE. Run main.m to plot the effect of initialization. Details of the initialization schemes can be found in the related technical report. 


multihop: Simulates Multi hop GGE with Randomized Gossip and Geographic Gossip. Run main.m to generate data for one, two, three hops GGE and plot the comparison in terms of relative error vs number of transmissions. The simulation parameters are same as /comparisons/main.m


stale information: Simulates Greedy Gossip with Eavesdropping for different levels of stale information. The simulation parameters are described at the beginning of the file GGEstale.m