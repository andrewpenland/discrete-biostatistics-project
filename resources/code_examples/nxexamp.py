import networkx as nx
import matplotlib.pyplot as plt
G3 = nx.MultiGraph()
G3.add_nodes_from([1,2,3,4])
G3.add_edge(1,2,3)
nx.draw(G3)
# G1 = nx.cycle_graph(4)
# nx.draw(G1, node_color=['red', 'red', 'green', 'green'])
plt.savefig('path_graph1.png')
plt.show()
