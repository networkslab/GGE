Greedy Gossip with Eavesdropping
  	

Researchers: Deniz Ustebay (Ph.D. Student), Boris Oreshkin (Ph.D. Student), Prof. Mark Coates & Prof. Mike Rabbat

Description:

Distributed consensus has been identified as a canonical problem in both the distributed signal processing and control communities. The prototypical example of a consensus problem is computation of the average consensus: in a network, initially each node has a scalar data value and the goal is to find a distributed algorithm that asymptotically computes the average at every node. Such an algorithm can further be used for computing linear functions of the data and can be generalized for averaging vectorial data.

In this study we propose a new randomized gossip algorithm, greedy gossip with eavesdropping (GGE), for the computation of average consensus. Unlike previous randomized gossip algorithms, which perform updates completely at random, GGE takes advantage of the broadcast nature of wireless communications and implements a greedy neighbor selection procedure. We assume a broadcast transmission model such that all neighbors within range of a transmitting node receive the message. Thereby, in addition to keeping track of its own value, each node tracks its neighbors values by eavesdropping on their transmissions. At each iteration, the activated node uses this information to greedily choose the neighbor with which it will gossip, selecting the neighbor whose value is most different from its own. Accelerating convergence in this myopic way does not bias computation and does not rely on geographic location information, which may change in networks of mobile nodes.

Although GGE is a powerful yet simple variation on gossip-style algorithms, analyzing its convergence behavior is non-trivial. The main reason is that each GGE update depends explicitly on the values at each node (via the greedy decision of with which neighbor to gossip). Thus, the standard approach to proving convergence to the average consensus solution (i.e., expressing updates in terms of a linear recursion and then imposing properties on this recursion) cannot be applied to guarantee convergence of GGE. To prove convergence, we demonstrate that GGE updates correspond to iterations of a distributed randomized incremental subgradient optimization algorithm. Similarly, analysis of the convergence rate of GGE requires a different approach than the standard approach of examining the mixing time of a related Markov chain. We develop a bound relating the rate of convergence of GGE to the rate of standard randomized gossip. The bound indicates that GGE always converges faster than randomized gossip, a finding supported by simulation results. We also provide a worst-case bound on the rate of convergence of GGE. For other gossip algorithms the rate of convergence is generally characterized as a function of the second largest eigenvalue of a related stochastic matrix. In the case of GGE, our worst-case bound characterizes the rate of convergence in terms of a constant that is completely determined by the network topology. We investigate the behavior of this constant empirically for random geometric graph topologies and derive lower bounds that provide some characterization of its scaling properties.

We also show that the improvement achieved using GGE over standard randomized gossip (i.e., exchanging information equally often with all neighbors) is proportional to the maximum node degree. Thus, for network topologies such as random geometric graphs, where node degree grows with the network size, the improvements of GGE scale with network size, but for grid-like topologies, where the node degree remains constant, GGE yields limited improvement. We propose an extension to GGE, which is called multi-hop GGE, that improves the rate of convergence for grid-like topologies. Multi-hop GGE relies on increasing artificially neighborhood size by performing greedy updates with nodes beyond one hop neighborhoods. We show that multi-hop GGE converges to the average consensus and illustrate via simulation that multi-hop GGE improves the performance of GGE for different network topologies. 

______________________________________________________________________________________________________________________________________________________________________________

This folder contains the MATLAB code for Greedy Gossip with Eavesdropping (GGE) algorithm. For details check the technical report at:
http://arxiv.org/PS_cache/arxiv/pdf/0909/0909.1830v1.pdf

For more information contact Deniz Ustebay at: deniz.ustebay@mail.mcgill.ca

Folders and content:

comparisons: Simulates Greedy Gossip with Eavesdropping with Randomized Gossip and Geographic Gossip for different field and network topology choices. Run main.m to generate gossip data and plot the comparison of algorithms in terms of relative error vs number of transmissions. The simulation parameters are described at the beginning of the file.


bound: Simulates bounds on GGE performance. The bound A(G) is numerically calculated using randomized incremental subgradient algorithm. Run main_AGvsnodes,m to see how bound scales with network size and run main_boundvsperf.m to see the performance of the algorithm for different fields and compare the performance with the theoretical bound. 


initialization: Simulates initialization schemes for GGE. Run main.m to plot the effect of initialization. Details of the initialization schemes can be found in the related technical report. 


multihop: Simulates Multi hop GGE with Randomized Gossip and Geographic Gossip. Run main.m to generate data for one, two, three hops GGE and plot the comparison in terms of relative error vs number of transmissions. The simulation parameters are same as /comparisons/main.m


stale information: Simulates Greedy Gossip with Eavesdropping for different levels of stale information. The simulation parameters are described at the beginning of the file GGEstale.m
