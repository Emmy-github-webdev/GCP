# Deployments
Shortcode = deploy

#### _List one or more deployments_
```
kubectl get deployment
```
#### _Display the detailed state of one or more deployments_
```
kubectl describe deployment <deployment_name>
```
#### _Edit and update the definition of one or more deployment on the server_
```
kubectl edit deployment <deployment_name>
```
#### _Create one a new deployment_
```
kubectl create deployment <deployment_name>
```
#### _Delete deployments_
```
kubectl delete deployment <deployment_name>
```
#### _See the rollout status of a deployment_
```
kubectl rollout status deployment <deployment_name>
```

