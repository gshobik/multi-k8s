docker build -t gshobik/multi-client:latest -t gshobik/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gshobik/multi-server:latest -t gshobik/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gshobik/multi-worker:latest -t gshobik/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gshobik/multi-client:latest
docker push gshobik/multi-server:latest
docker push gshobik/multi-worker:latest

docker push gshobik/multi-client:$SHA
docker push gshobik/multi-server:$SHA
docker push gshobik/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=gshobik/multi-server:$SHA
kubectl set image deployments/client-deployment server=gshobik/multi-client:$SHA
kubectl set image deployments/worker-deployment server=gshobik/multi-worker:$SHA