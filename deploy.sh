docker build -t azurerathalos/multi-client:latest -t azurerathalos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t azurerathalos/multi-server:latest -t azurerathalos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t azurerathalos/multi-worker:latest -t azurerathalos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push azurerathalos/multi-client:latest
docker push azurerathalos/multi-server:latest
docker push azurerathalos/multi-worker:latest

docker push azurerathalos/multi-client:$SHA
docker push azurerathalos/multi-server:$SHA
docker push azurerathalos/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=azurerathalos/multi-server:$SHA
kubectl set image deployments/client-deployment client=azurerathalos/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=azurerathalos/multi-worker:$SHA
