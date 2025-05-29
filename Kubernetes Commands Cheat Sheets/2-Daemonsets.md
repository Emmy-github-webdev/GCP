# Daemonsets
Shortcode = ds

#### _List one or more daemonsets_
```
kubectl get daemonset
```
#### _Edit and update the definition of one or more daemonset_
```
kubectl edit daemonset <daemonset_name>
```
#### _Delete a daemonset_
```
kubectl delete daemonset <daemonset_name>
```
#### _Create a new daemonset_
```
kubectl create daemonset <daemonset_name>
```
#### _Manage the rollout of a daemonset_
```
kubectl rollout daemonset
```
#### _Display the detailed state of daemonsets within a namespace_
```
kubectl display ds <daemonset_name> -n <namespace_name>
```