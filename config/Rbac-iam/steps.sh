#################### EKS Cluster RBACs #############################################################################
## first create the Devloper namespace, and then install nginx into it
kubectl create namespace Devloper

## Deploy nginx pod on clsuster
kubectl create deploy nginx --image=nginx -n Devloper

## To verify the test pods were properly installed
kubectl get all -n Devloper

## Create IAM user and create access key
aws iam create-user --user-name rbac-user
aws iam create-access-key --user-name rbac-user

## We will use these set onther context with using above credentials
AWS configure.

## MAP AN IAM USER TO K8S
kubectl apply -f .\aws-auth.yaml

## Verify newly created user after login AND it should throw below errors
kubectl get pods -n Devloper

## Create a role and role binding from Admin access
kubectl apply -f .\clusterRole.yaml
kubectl apply -f .\clusterRoleBinding.yaml

## login with Kubernetes user again

## Verify newly created user after login AND it should Not throw any errors
kubectl get pods -n Devloper

## Verify newly created user after login AND it should throw errors
kubectl get pods -n kube-system