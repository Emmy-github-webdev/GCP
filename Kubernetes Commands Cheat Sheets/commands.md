#### Deployment Yaml

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app1-nginx-deployment
  labels:
    app: app1-nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: app1-nginx
  strategy: 
    rollingUpdate:
      maxUnavailable: 2
  template:
    metadatahttps://gitlab.com/Emmy-gitlab-webdev:
      labels:
        app: app1-nginx
    spec:
      containers:
        - name: app1-nginx
          image: stacksimplify/kube-nginxapp1:1.0.0
          imagePullPolicy: Always
          ports:
            - containerPort: 80
```

#### Service Yaml file

```
apiVersion: v1
kind: Service
metadata:
  name: app1-nginx-clusterip-service
  labels:
    app: app1-nginx
spec:
  type: LoadBalancer
  selector:
    app: app1-nginx
  ports:
    - port: 80
      targetPort: 80
```
#### Common Errors
- _CrashLoopBackOff_: Kubernetes was unable to schedule a the pod on a node because of lacks the necessary resources to run the pod. Identify this error by using the kubectl get pods command. The affected pod show a CrashLoopBackOff status
- _OOMKilled (Out Of Memory Killed)_: The container used more memory than its memory limit, and the kernel killed it. Pod status shows _Terminated_. Fixed by increase memory limits/requests.

```
resources:
  requests:
    memory: "512Mi"
  limits:
    memory: "1Gi"
```
- _Pending due to Unschedulable (Insufficient memory)_: Caused by cluster nodes do not have enough free memory. It can be fixed by reducing memory requests or Add more nodes (cluster autoscaler).

```
0/5 nodes are available: insufficient memory.
```
- _Throttling / High CPU throttling_: Fixed by Use HPA (Horizontal Pod Autoscaling).

- _ImagePullBackOff_: Indicates that the pod could not start on the specified node and Kubernetes was unable to pull the container image. It will continue to try and pull the image. To troubleshoot the ImagePullBackOff error, run the kubectl describe pod. This error can be resolved by checking the pod’s specification and ensuring that the image and repository are correctly defined.

- _Exit Code 1_: This error indicates that the container was terminated due an application error or invalid reference

#### Cluster Management

|Command | Description|
| :-: | :-: |
| kubectl cluster-info | Display endpoint information about the master and services in the cluster |
| kubectl version | Display the Kubernetes version running on the client and server|
| kubectl config view  | Get the configuration of the cluster |
|kubectl api-resources  |List the API resources that are available |
| kubectl api-version | List the API versions that are available|
| kubectl get all --all-namespaces |List everything |