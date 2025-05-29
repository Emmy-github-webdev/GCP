# StatefulSet
Shortcode = sts

#### _List StatefulSet_
```
kubectl get statefulset
```
#### _Delete StatefulSet only (not pods)_
```
kubectl delete statefulset/[stateful_set_name] --cascade=false
```