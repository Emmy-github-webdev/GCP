# Pods
Shortcode = po

#### _List one or more pods_
```
kubectl get pod 
```
#### _Delete a pods_
```
kubectl delete pod <pod_name>
```
#### _Display the detailed state of a pods_
```
kubectl describe pod <pod_name>
```
#### _Create a pods_
```
kubectl create pod <pod_name>
```
#### _Execute a command against a container in a pod_
```
kubectl exec <pod_name> -c <container_name> <command>
```
#### _Get interactive shell on a a single-container pod_
```
kubectl exec -it <pod_name> /bin/sh
```
#### _Display Resource usage (CPU/Memory/Storage) for pods_
```
kubectl top pod
```
#### _Add or update the annotations of a pod_
```
kubectl annotate pod <pod_name> <annotation>
```
#### _Add or update the label of a pod_
```
kubectl label pod <pod_name>
```