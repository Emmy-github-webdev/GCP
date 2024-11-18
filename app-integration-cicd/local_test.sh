#!/bin/sh

cp -r tests tests_local
export location=europe-west4
export name=$(ls -A src | sed 's/\.json'$//)
export projectId=bap-amer-west-demo1
export host=${location}-integrations.googleapis.com
export basepath=/v1/projects/${projectId}/locations/${location}/integrations/${name}:execute
export triggerId="api_trigger/${name}_API_1"
export token=$(gcloud auth application-default print-access-token)
export env=$(git rev-parse --abbrev-ref HEAD)

# update the files with the variables
sed -i "s@INTEGRATION_HOST@$host@g" ./tests_local/integration/support/init.js
sed -i "s@INTEGRATION_BASEPATH@$basepath@g" ./tests_local/integration/support/init.js

sed -i "s@TRIGGER_ID@$triggerId@g" ./tests_local/integration/demo.feature
sed -i "s@ACCESS_TOKEN@$token@g" ./tests_local/integration/demo.feature
sed -i "s@INTEGRATION_ENV@$env@g" ./tests_local/integration/demo.feature

