docker build -t balawillgetyou/multi-client:latest -t balawillgetyou/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t balawillgetyou/multi-server:latest -t balawillgetyou/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t balawillgetyou/multi-worker:latest -t balawillgetyou/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push balawillgetyou/multi-client:latest
docker push balawillgetyou/multi-server:latest
docker push balawillgetyou/multi-worker:latest

docker push balawillgetyou/multi-client:$SHA
docker push balawillgetyou/multi-server:$SHA
docker push balawillgetyou/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=balawillgetyou/multi-server:$SHA
kubectl set image deployments/client-deployment client=balawillgetyou/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=balawillgetyou/multi-worker:$SHA