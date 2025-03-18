cd ..
git clone https://github.com/aws-containers/ecsdemo-frontend.git
git clone https://github.com/aws-containers/ecsdemo-nodejs.git
git clone https://github.com/aws-containers/ecsdemo-crystal.git
aws kms create-alias --alias-name alias/ekssetup --target-key-id $(aws kms create-key --query KeyMetadata.Arn --output text)
export MASTER_ARN=$(aws kms describe-key --key-id alias/ekssetup --query KeyMetadata.Arn --output text)
echo "export MASTER_ARN=${MASTER_ARN}" | tee -a ~/.bash_profile


echo account=${ACCOUNT_ID}
echo region=${AWS_REGION}
echo az=${AZS[0]}
echo key=${MASTER_ARN}
