docker build -t mztest/multi-client:latest -t mztest/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mztest/multi-server:latest -t mztest/multi-server:$SHA -f ./client/Dockerfile ./server
docker build -t mztest/multi-worker:latest -t mztest/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push mztest/multi-client:latest
docker push mztest/multi-server:latest
docker push mztest/multi-worker:latest

docker push mztest/multi-client:$SHA
docker push mztest/multi-server:$SHA
docker push mztest/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mztest/multi-server:$SHA
kubectl set image deployments/client-deployment client=mztest/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mztest/multi-worker:$SHA
