#!/bin/bash

# assumes ./initialize_k8s.sh has been run,
# which creates the blue deployment as well as
# config maps for both blue and green deployments

# Deploy Green
kubectl apply -f green.yml

# Check deployment rollout status every 3 seconds until complete.
ATTEMPTS=0
ROLLOUT_STATUS_CMD="kubectl rollout status deployment/green -n udacity"
until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 20 ]; do
  $ROLLOUT_STATUS_CMD
  ATTEMPTS=$((attempts + 1))
  sleep 3
done

echo "Green deployment successful!"