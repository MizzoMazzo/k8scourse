#!/bin/bash
docker build -t mizzomazzo/dockercourse-client:latest -t mizzomazzo/dockercourse-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t mizzomazzo/dockercourse-server:latest -t mizzomazzo/dockercourse-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t mizzomazzo/dockercourse-worker:latest -t mizzomazzo/dockercourse-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push mizzomazzo/dockercourse-client:latest
docker push mizzomazzo/dockercourse-client:$GIT_SHA

docker push mizzomazzo/dockercourse-server:latest
docker push mizzomazzo/dockercourse-server:$GIT_SHA

docker push mizzomazzo/dockercourse-worker:latest
docker push mizzomazzo/dockercourse-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mizzomazzo/dockercourse-server:$GIT_SHA
kubectl set image deployments/client-deployment client=mizzomazzo/dockercourse-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=mizzomazzo/dockercourse-worker:$GIT_SHA
