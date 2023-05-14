# terraform-eks-argocd

With this project you can provision an `AWS EKS` cluster with `Terraform`, install `ArgoCD` to deploy a configuration file which look for changes in another GitHub repo [k8-pipeline-GitOps](https://github.com/techednelson/k8-pipeline-GitOps).
 This repo keeps track of the docker image tag changes from a sample Python flask application [k8-pipeline-ci](https://github.com/techednelson/k8-pipeline-ci), triggering the `ArgoCD` agent to deploy the python flask application with the new changes. 

The main goal is to showcase the [GitOps](https://about.gitlab.com/topics/gitops/) pattern in `DevOps`

## Pre requisites

- AWS account https://repost.aws/knowledge-center/create-and-activate-aws-account
- IAM user credentials configure with `aws configure` command https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html
- Install aws cli https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- Terraform https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## Run the project

- #### Initialize terraform, downloading providers
- `terraform init`
- #### Provision infrastructure into AWS (vpc, subnets, eks, nodes, etc..) according to terraform configuration files. In can take 5 to 10 minutes to complete
- `terraform apply` or `terraform apply -auto-approve`
- #### Connect to your eks cluster deployed on AWS
- `aws eks update-kubeconfig --region <aws-region> --name testing-environment-eks` replace `<aws-region>` for your preferred one, e.g. `us-east-1`
- #### Verify your eks cluster is up & running before proceeding to the next step, you should se `service/kubernetes` listening in port `443`
- `kubectl get all`
- #### Install ArgoCD in eks cluster
- `kubectl create namespace argocd`
- `kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml`
- #### Verify all pods in argocd namespace are up & running before proceeding with next step
- `kubectl get pods -n argocd`
- #### Deploy your argocd configuration file to eks pointing to the Python flask sample app GitHub repo. the python sample app will be deployed in a namespace called flaskdemo
- `kubectl apply -f argocd-application.yml`
- #### Verify argocd has been deployed successfully
- `kubectl get svc -n argocd`
- #### Access ArgoCD UI
- `kubectl port-forward svc/argocd-server 8080:443 -n argocd`
- Go to `https://127.0.0.1:8080`
- Enter username `admin` & password, the value originated after running `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode && echo`
- #### Verify flaskdemo app has been deployed successfully
- `kubectl get pods -n flaskdemo`
