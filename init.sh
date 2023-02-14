#!/bin/bash

aws eks update-kubeconfig --name $(terraform output cluster_name | tr '"' ' ') --region $(terraform output region | tr '"' ' ') 1>/dev/null
alias k=kubectl

echo -e "\n### CROSSYROAD ###\n\n"

# ArgoCD
argoCD_admin_pass=$(kubectl get secrets --namespace argocd argocd-initial-admin-secret -o yaml | grep -i password | tr ':' '\n' | tail -1)
argoCD_admin_pass=$(echo $argoCD_admin_pass | base64 -d)
echo -e "to connect to ArgoCD: 'kubectl port-forward -n argocd svc/argocd-server 8080:80'\n"
echo -e "your ArgoCD user is 'admin'" 
echo -e "your ArgoCD password is '$argoCD_admin_pass'\n\n" 

# Kibana
kibana_root_pass=$(kubectl get secrets elasticsearch-master-credentials --namespace logging -o yaml | grep -i password | head -1 | tr ':' '\n' | tail -1)
kibana_root_pass=$(echo $kibana_root_pass | base64 -d)
echo -e "to connect to Kibana: 'kubectl port-forward -n logging svc/kibana-kibana 8081:5601'\n"
echo -e "your Kibana user is 'elastic'"
echo -e "your Kibana password is '$kibana_root_pass'"

# echo -e "to connect to Grafana: 'kubectl port-forward -n monitoring svc/argocd-server 8080:80'\n"

# echo -e "to connect to Prometheus: 'kubectl port-forward -n monitoring svc/argocd-server 8080:80'\n"





url=$(kubectl get service crossyroad-ingress-nginx-controller | tr -s " " | cut -d" " -f4 | tail -1)
echo "The URL of the ingress nginx is: '$url'"