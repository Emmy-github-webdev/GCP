# Manifest Files

Another option for modifying objects is through Manifest Files. We highly recommend using this method. It is done by using yaml files with all the necessary options for objects configured. We have our yaml files stored in a git repository, so we can track changes and streamline changes.

#### _Apply a configuration to an object by filename or stdin. Overrides the existing configuration._
```
kubectl apply -f manifest_file.yaml
```
#### _Create Objects_
```
kubectl create -f manifest_file.yaml
```
#### _Create Objects in all manifest files in a directory_
```
kubectl create -f ./dir
```
#### _Create Objects from a URL_
```
kubectl create -f 'url'
```
#### _Delete Object_
```
kubectl delete -f manifest_file.yaml
```