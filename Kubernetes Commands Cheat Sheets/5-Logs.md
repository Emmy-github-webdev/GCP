# Logs

#### _Print the logs for a pod_
```
kubectl logs <pod_name>
```
#### _Print the logs for the last hour for a pod_
```
kubectl logs --since=1h <pod_name>
```
#### _Get the most recent 20 lines of logs_
```
kubectl logs --tail=20 <pod_name>
```
#### _Get logs from a service and optionally select which container_
```
kubectl logs -f <service_name> [-C <$container>]
```
#### _Print the logs for a pod and follow new logs_
```
kubectl logs -f <pod_name>
```
#### _Print the logs for a container in a pod_
```
kubectl logs -c <container_name> <pod_name>
```
#### _Output the logs for a pod into a file named ‘pod.log’_
```
kubectl logs <pod_name> pod.log
```
#### _View the logs for a previously failed pod_
```
kubectl logs --previous <pod_name>
```

For logs we also recommend using a tool developed by Johan Haleby called Kubetail. This is a bash script that will allow you to get logs from multiple pods simultaneously. You can learn more about it at its ![Github repository](https://github.com/johanhaleby/kubetail). Here are some sample commands using Kubetail.

#### _Get logs for all pods named with pod_prefix_
```
kubetail <pod_prefix>
```
#### _Include the most recent 5 minutes of logs_
```
kubetail <pod_prefix> -s 5m
```