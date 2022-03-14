docker build -t miki90014/multi-client:latest -t miki90014/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t miki90014/multi-server:latest -t miki90014/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t miki90014/multi-worker:latest -t miki90014/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push miki90014/multi-client:latest
docker push miki90014/multi-client:$SHA
docker push miki90014/multi-server:latest
docker push miki90014/multi-server:$SHA
docker push miki90014/multi-worker:latest
docker push miki90014/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=miki90014/multi-server:$SHA
kubectl set image deployments/client-deployment client=miki90014/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=miki90014/multi-worker:$SHA