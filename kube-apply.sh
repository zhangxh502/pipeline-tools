cd /home/jenkins/workspace/$CI_PIPELINE_NAME

if [ ! -f "$CI_DEPLOYMENT_CONFIG" ]
then
        echo "File \"$CI_DEPLOYMENT_CONFIG\" not found! "
        exit 1
fi

sed -i 's^${CI_BUILD_NUMBER}^'"$CI_BUILD_NUMBER^g" "$CI_DEPLOYMENT_CONFIG"

echo $CI_DEPLOYMENT_CONFIG
kubectl apply -f "$CI_DEPLOYMENT_CONFIG"
