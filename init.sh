#!/bin/bash

aws eks update-kubeconfig --name $(terraform output cluster_name | tr '"' ' ') --region $(terraform output region | tr '"' ' ') 1>/dev/null
alias k=kubectl

echo -e "\n### CROSSYROAD ###\n\n"

url=$(kubectl get service crossyroad-ingress-nginx-controller | tr -s " " | cut -d" " -f4 | tail -1)
echo -e "The URL of the ingress nginx is: '$url'\n"

# ArgoCD
argoCD_admin_pass=$(kubectl get secrets --namespace argocd argocd-initial-admin-secret -o yaml | grep -i password | tr ':' '\n' | tail -1)
argoCD_admin_pass=$(echo $argoCD_admin_pass | base64 -d)
echo -e "to connect to ArgoCD:"
echo -e "kubectl port-forward -n argocd svc/argocd-server 8080:80\n"
echo -e "your ArgoCD user is 'admin'" 
echo -e "your ArgoCD password is '$argoCD_admin_pass'\n" 

# Kibana
echo -e "to connect to Kibana:"
echo -e "kubectl port-forward -n logging svc/elasticsearch-kibana 8081:5601\n"

# Grafana
grafana_admin_pass=$(kubectl get secrets --namespace monitoring grafana -o yaml | grep -i 'admin-password:' | tr ':' '\n' | tail -1)
grafana_admin_pass=$(echo $grafana_admin_pass | base64 -d)
echo -e "to connect to Grafana:"
echo -e "kubectl port-forward -n monitoring svc/grafana 8082:80\n"
echo -e "your Grafana user is 'admin'" 
echo -e "your Grafana password is '$grafana_admin_pass'" 
echo -e "your ArgoCD password is 'prom-operator'\n" 

# Prometheus
echo -e "to connect to Prometheus:"
echo -e "kubectl port-forward -n monitoring svc/kube-prometheus-stack-prometheus 8083:9090\n"


