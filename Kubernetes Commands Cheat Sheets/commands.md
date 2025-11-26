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

#### Daemonset

|Command | Description|
| :-: | :-: |
|Shortcode = ds | Daemonsets|
| kubectl get daemonset |List one or more daemonsets |
|kubectl edit daemonset <daemonset_name> |Edit and update the definition of one or more daemonset |
|kubectl delete daemonset <daemonset_name> |Delete a daemonset|
|kubectl create daemonset <daemonset_name> | Create a new daemonset|
|kubectl rollout daemonset |Manage the rollout of a daemonset |
| kubectl display ds <daemonset_name> -n <namespace_name>| Display the detailed state of daemonsets within a namespace|

#### Deployment

|Command | Description|
| :-: | :-: |
|Shortcode = deploy |Deployments |
|kubectl get deployment | List one or more deployments|
|kubectl describe deployment <deployment_name> |Display the detailed state of one or more deployments |
|kubectl edit deployment <deployment_name> |Edit and update the definition of one or more deployment on the server |
|kubectl create deployment <deployment_name> | Create one a new deployment|
|kubectl delete deployment <deployment_name> |Delete deployments |
|kubectl rollout status deployment <deployment_name> |See the rollout status of a deployment |

#### Events

|Command | Description|
| :-: | :-: |
| Shortcode = ev| Events|
|kubectl get events |List recent events for all resources in the system |
|kubectl get events --field-selector type=Warning | List Warnings only|
|kubectl get events --field-selector involvedObject.kind!=pod |List events but exclude Pod events |
|kubectl get events --field-selector involvedObject.kind=Node, involvedObject.name=<node_name> |Pull events for a single node with a specific name |
|kubectl get events --field-selector type!=Normal | Filter out normal events from a list of events|

#### Logs

|Command | Description|
| :-: | :-: |
| kubectl logs <pod_name>|Print the logs for a pod |
|kubectl logs --since=1h <pod_name> | Print the logs for the last hour for a pod|
| kubectl logs --tail=20 <pod_name>| Get the most recent 20 lines of logs|
|kubectl logs -f <service_name> [-C <$container>] | Get logs from a service and optionally select which container|
|kubectl logs -f <pod_name> |Print the logs for a pod and follow new logs |
|kubectl logs -c <container_name> <pod_name> |Print the logs for a container in a pod |
| kubectl logs <pod_name> pod.log|Output the logs for a pod into a file named ‘pod.log |
|kubectl logs --previous <pod_name> |View the logs for a previously failed pod |
| kubetail <pod_prefix>|Get logs for all pods named with pod_prefix |
|kubetail <pod_prefix> -s 5m | Include the most recent 5 minutes of logs|

#### Manifest Files
Another option for modifying objects is through Manifest Files. We highly recommend using this method. It is done by using yaml files with all the necessary options for objects configured. We have our yaml files stored in a git repository, so we can track changes and streamline changes.

|Command | Description|
| :-: | :-: |
| kubectl apply -f manifest_file.yaml|Apply a configuration to an object by filename or stdin. Overrides the existing configuration |
|kubectl create -f manifest_file.yaml |Create Objects |
|kubectl create -f ./dir |Create Objects in all manifest files in a directory |
|kubectl create -f 'url' | Create Objects from a URL|
|kubectl delete -f manifest_file.yaml |Delete Object |

#### Namespaces

|Command | Description|
| :-: | :-: |
|Shortcode = ns | Namespaces|
| kubectl create namespace <namespace_name>|Create namespace <name> |
| kubectl get namespace <namespace_name>| List one or more namespaces|
|kubectl describe namespace <namespace_name> | Display the detailed state of one or more namespace|
|kubectl delete namespace <namespace_name> |Delete a namespace |
|kubectl edit namespace <namespace_name> | Edit a namespace|
| kubectl top namespace <namespace_name>| Display Resource (CPU/Memory/Storage) usage for a namespace|

#### Nodes

|Command | Description|
| :-: | :-: |
|Shortcode = no | Nodes|
|kubectl taint node <node_name> |Update the taints on one or more nodes. Taints dedicate nodes to specific teams |
|kubectl get node |List one or more nodes |
|kubectl delete node <node_name> | Delete a node or multiple nodes|
|kubectl top node | Display Resource usage (CPU/Memory/Storage) for nodes|
|kubectl describe nodes | grep Allocated -A 5 |Resource allocation per node |
|kubectl get pods -on wide | grep <node_name> |Pods running on a node |
| kubectl annotate node <node_name>| Annotate a node|
|kubectl cordon node <node_name> |Mark a node as unschedulable |
|kubectl drain node <node_name> | Drain a node in preparation for maintenance|
|kubectl label node  | Add or update the labels of one or more node|

#### Pods

|Command | Description|
| :-: | :-: |
|Shortcode = po |Pods |
|kubectl get pod | List one or more pods|
|kubectl delete pod <pod_name> | Delete a pods|
|kubectl describe pod <pod_name> | Display the detailed state of a pods|
|kubectl create pod <pod_name> | Create a pods|
|kubectl exec <pod_name> -c <container_name> <command> |Execute a command against a container in a pod |
|kubectl exec -it <pod_name> /bin/sh | Get interactive shell on a a single-container pod|
|kubectl top pod |Display Resource usage (CPU/Memory/Storage) for pods |
|kubectl annotate pod <pod_name> <annotation> |Add or update the annotations of a pod |
|kubectl label pod <pod_name> |Add or update the label of a pod |

#### Replicaset and Replication controller

|Command | Description|
| :-: | :-: |
|Shortcode = rc |Replication Controllers |
|kubectl get rc |List the replication controllers |
|kubectl get rc --namespace="<namespace_name> | List the replication controllers by namespace|
| Shortcode = rs| ReplicaSets|
|kubectl get replicasets | _List ReplicaSets|
| kubectl describe replicasets <replicaset_name>|Display the detailed state of one or more ReplicaSets |
|kubectl scale --replicas=[x] |Scale a ReplicaSets |

#### Secrets

|Command | Description|
| :-: | :-: |
|kubectl create secret |Create secret |
|kubectl get secret |list secret |
|kubectl describe secrets | List details about secret|
|kubectl delete secret <secret_name> | Delete secret |

#### Statefulset and others

|Command | Description|
| :-: | :-: |
|Shortcode = svc |Services |
|kubectl get services | List one or more services|
|kubectl describe services | Display the detailed state of a service|
|kubectl expose deployment deployment_name |Expose a replication controller, service, deployment or pod as a new Kubernetes service |
|kubectl edit services | Edit and update the definition of one or more services|
|Shortcode = sts | StatefulSet|
|kubectl get statefulset |List StatefulSet |
|kubectl delete statefulset/stateful_set_name --cascade=false | Delete StatefulSet only (not pods)|
|kubectl get pods -o wide |-o Output format. For example if you wanted to list all of the pods in ps output format with more information |
|kubectl get pods --namespace=[namespace_name]
kubectl get pods -n=namespace_name | -n Shorthand for --namespace. For example, if you’d like to list all the Pods in a specific Namespace you would do this command|
| |-f Filename, directory, or URL to files to use to create a resource. For example when creating a pod using data in a file named newpod.json |

#### Service Account

|Command | Description|
| :-: | :-: |
|Shortcode = sa | Service Accounts|
|kubectl get serviceaccounts |List service accounts |
|kubectl describe serviceaccounts | Display the detailed state of one or more service accounts|
|kubectl replace serviceaccounts |Replace a service account |
|kubectl delete serviceaccounts <service_account_name> |Delete a service account |