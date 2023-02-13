#!/bin/bash

aws eks update-kubeconfig --name $(terraform output cluster_name | tr '"' ' ') --region $(terraform output region | tr '"' ' ') 1>/dev/null

alias k=kubectl

echo -e "\nCROSSYROAD\n\n"

echo -e "to connect to ArgoCD: 'kubectl port-forward -n argocd svc/argocd-server 8080:80'\n"

argoCD_admin_pass=$(kubectl get secrets --namespace argocd argocd-initial-admin-secret -o yaml | grep -i password | tr ':' '\n' | tail -1)
argoCD_admin_pass=$(echo $argoCD_admin_pass | base64 -d)

echo -e "your ArgoCD user is 'admin'" 
echo -e "your ArgoCD password is '$argoCD_admin_pass'\n\n" 

url=$(kubectl get service crossyroad-ingress-nginx-controller | tr -s " " | cut -d" " -f4 | tail -1)
echo "The URL of the ingress nginx is: '$url'"