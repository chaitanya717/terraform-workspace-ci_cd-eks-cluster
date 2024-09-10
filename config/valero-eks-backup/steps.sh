# make sure you have eks cluater and kubectl installed
aws configure

aws s3api create-bucket --bucket velero-demo-backup-eks --create-bucket-configuration LocationConstraint=eu-west-1

# installing velero
wget https://github.com/vmware-tanzu/velero/releases/download/v1.12.1/velero-v1.12.1-linux-amd64.tar.gz
tar -xvf velero-v1.12.1-linux-amd64.tar.gz
sudo mv velero-v1.12.1-linux-amd64/velero /usr/local/bin/

# Connect to Kubernetes eks Cluster

aws eks update-kubeconfig --name two-tier-eks-cluster --region us-west-1

# Install Velero on Kubernetes Cluster with backup location as S3 bucket we created in step-3

velero install --provider aws --plugins velero/velero-plugin-for-aws:v1.0.1 --bucket velero-demo-backup-eks

kubectl get ns kubectl get pods --all-namespaces
kubectl get all -n velero

kubectl create namespace eks-backup-demo
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0 -n eks-backup-demo
kubectl create deployment nginx --image=nginx -n eks-backup-demo

kubectl get deployments -n eks-backup-demo

# Create Backup

velero backup create <backupname> --include-namespaces <namespacename> 
velero backup create eks-backup --include-namespaces eks-backup-demo

# Describe Backup
velero backup describe eks-backup

# add policy in EKSNodeGroupRole
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "AllowS3VeleroBackup",
			"Effect": "Allow",
			"Action": [
				"s3:ListBucket",
				"s3:GetObject",
				"s3:PutObject",
				"s3:DeleteObject"
			],
			"Resource": [
				"arn:aws:s3:::velero-eks-backup-2tier-chetan",
				"arn:aws:s3:::velero-eks-backup-2tier-chetan/*"
			]
		}
	]
}

# We can also schedule the Velero Backups using the below command

velero schedule create firstsche --schedule="*/5 * * * *" --include-namespaces eks-backup-demo --ttl 0h15m0s

# Delete Namespace and verify the namespace and all resources inside namespace have been deleted successfully
kubectl delete ns eks-backup-demo 
kubectl get ns 
kubectl get deployments -n eks-backup-demo

# Perform restoration

velero restore create eks-restore --from-backup eks-backup

# Validate Backup has been restored successfully

kubectl get ns kubectl get deployments -n eks-backup-demo