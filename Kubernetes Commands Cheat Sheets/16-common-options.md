# Common Options

In Kubectl you can specify optional flags with commands. Here are some of the most common and useful ones.

#### _-o Output format. For example if you wanted to list all of the pods in ps output format with more information._
```
kubectl get pods -o wide
```
#### _-n Shorthand for --namespace. For example, if you’d like to list all the Pods in a specific Namespace you would do this command:_
```
kubectl get pods --namespace=[namespace_name]
kubectl get pods -n=[namespace_name]
```
#### _-f Filename, directory, or URL to files to use to create a resource. For example when creating a pod using data in a file named newpod.json_
```
kubectl create -f ./newpod.json
```