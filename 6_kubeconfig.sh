aws eks update-kubeconfig --name ekssetup-eksctl --region ${AWS_REGION}
STACK_NAME=$(eksctl get nodegroup --cluster ekssetup-eksctl -o json | jq -r '.[].StackName')
ROLE_NAME=$(aws cloudformation describe-stack-resources --stack-name $STACK_NAME | jq -r '.StackResources[] | select(.ResourceType=="AWS::IAM::Role") | .PhysicalResourceId')
echo "export ROLE_NAME=${ROLE_NAME}" | tee -a ~/.bash_profile

rolearn=(aws iam get-role --role-name ROLE_NAME)

eksctl create iamidentitymapping --cluster ekssetup-eksctl --arn ${rolearn} --group system:masters --username admin
kubectl describe configmap -n kube-system aws-auth
