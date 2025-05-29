# Nodes
Shortcode = no

#### _Update the taints on one or more nodes_
```
kubectl taint node <node_name>
```
#### _List one or more nodes_
```
kubectl get node
```
#### _Delete a node or multiple nodes_
```
kubectl delete node <node_name>
```
#### _Display Resource usage (CPU/Memory/Storage) for nodes_
```
kubectl top node
```
#### _Resource allocation per node_
```
kubectl describe nodes | grep Allocated -A 5
```
#### _Pods running on a node_
```
kubectl get pods -on wide | grep <node_name>
```
#### _Annotate a node_
```
kubectl annotate node <node_name>
```
#### _Mark a node as unschedulable_
```
kubectl cordon node <node_name>
```
#### _Mark a node as schedulable_
```
kubectl uncordon node <node_name>
```
#### _Drain a node in preparation for maintenance_
```
kubectl drain node <node_name>
```
#### _Add or update the labels of one or more nodes_
```
kubectl label node 
```