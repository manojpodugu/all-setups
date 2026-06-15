#NOTE:
#1) argocd installation only works with "kubectl".
#2) To use kubectl, we need created cluster first.

#Installation steps

kubectl create namespace argocd  #Create the namespace for argoCD
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml  #Install ArgoCD
kubectl apply --server-side \
-n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml  # Install some dependencies, which are needed to avoid "Pod CrashLoopBackOff Error".


# Explanation for above command:  
     #1)For large CRDs such as applicationsets.argoproj.io, Kubernetes may reject them because the client-side apply mechanism stores a huge annotation "kubectl.kubernetes.io/last-applied-configuration". which exceeds the 256 KB limit.
     #2)We use server-side apply because it avoids storing the large "kubectl.kubernetes.io/last-applied-configuration" annotation, preventing large CRDs (like ApplicationSet) from failing with the Kubernetes annotation size limit.
#------------ Installation done------------


echo "=================================================================================================="
echo "change ClusterIP to LoadBalancer from immediate below command"
echo "==================================================================================================="
echo "kubectl edit svc argocd-server -n argocd # entering into service file with "ClusterIP" type."
echo "===================================================================================================="
echo "===================================================================================================="
echo "kubectl get all -n argocd   # After installing the ArgoCD, to check what resources it has created."
echo "=========================================================================================================="
echo "==========================================================================================================="
echo "kubectl get nodes -o wide  #To get ip address of worker nodes. EXTERNAL-IP are Public IP addresses. \n
kubectl get svc argocd-server -n argocd -o wide #To get k8s port number like 32076."
echo "=========================================================================================================="
echo "==========================================================================================================="
echo "kubectl get secret argocd-initial-admin-secret -n argocd -o yaml    # To get the value of the secret. \n
echo "secret value" | base64 --decode         # To decode the secret. Because, secret you see encoded using base64."
echo "=========================================================================================================="
echo "==========================================================================================================="



#reference when file is opened. Find the below pattern and change "ClusterIP" to "NodePort" or "LoadBalancer"(recommended). After save and exit.

 #selector:
 #   app.kubernetes.io/name: argocd-server
 # sessionAffinity: None
 # type: ClusterIP
#status:
#  loadBalancer: {}

#--------------------reference ends here--------------------
