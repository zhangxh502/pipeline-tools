
if [ -z "$CI_DEPLOYMENT_CONFIG" ] && [ -z "$CI_DEPLOYMENT_CONTENT" ]
then
        echo "Config or content must be specified!"
        exit 1
fi

if [ -n "$CI_DEPLOYMENT_CONTENT" ]
then
YAML_PATH="./deployment.yaml"
cat <<EOF> $YAML_PATH
$YAML_CONTENT
EOF
fi

if [ ! -f "$CI_DEPLOYMENT_CONFIG" ]
then
        echo "File \"$CI_DEPLOYMENT_CONFIG\" not found! "
        exit 1
fi

sed -i 's^${CI_BUILD_NUMBER}^'"$CI_BUILD_NUMBER^g" "$YAML_PATH"

kubectl apply -f "$YAML_PATH"
