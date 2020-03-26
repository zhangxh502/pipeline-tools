cd /home/jenkins/workspace/$CI_PIPELINE_NAME

if [ -z "$CI_DEPLOYMENT_CONFIG" ] && [ -z "$CI_DEPLOYMENT_CONTENT" ]
then
        echo "Config or content must be specified!"
        exit 1
fi

if [ -n "$CI_DEPLOYMENT_CONTENT" ]
then
CI_DEPLOYMENT_CONFIG="./.yicloud-deployment.yaml"
cat <<EOF> $CI_DEPLOYMENT_CONFIG
$YAML_CONTENT
EOF
fi

if [ ! -f "$CI_DEPLOYMENT_CONFIG" ]
then
        echo "File \"$CI_DEPLOYMENT_CONFIG\" not found! "
        exit 1
fi

sed -i 's^${CI_BUILD_NUMBER}^'"$CI_BUILD_NUMBER^g" "$CI_DEPLOYMENT_CONFIG"

kubectl apply -f "$CI_DEPLOYMENT_CONFIG"
