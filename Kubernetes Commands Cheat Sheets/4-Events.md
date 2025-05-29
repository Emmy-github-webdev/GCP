# Events
Shortcode = ev

#### _List recent events for all resources in the system_
```
kubectl get events
```
#### _List Warnings only_
```
kubectl get events --field-selector type=Warning
```
#### _List events but exclude Pod events_
```
kubectl get events --field-selector involvedObject.kind!=pod
```
#### _Pull events for a single node with a specific name_
```
kubectl get events --field-selector involvedObject.kind=Node, involvedObject.name=<node_name>
```
#### _Filter out normal events from a list of events_
```
kubectl get events --field-selector type!=Normal
```