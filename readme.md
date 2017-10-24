## Kubernetes Setup for CSW-PROD

### Pre-requisite

- Docker

- VirtualBox

- Minikube (`brew install minikube`) : This is required to create kubernetes cluster locally.

### How to Run

- Execute `up.sh` script from shell

  This will start following:
  - Cluster Seed on Port 3552
  - Admin Http Server on Port 7878
  - Cluster Management on Port 7879
  - Config Server on Port 4000

- Run `minikube dashboard` cmd from shell to view kubernetes dashboard where you can see logs from all the applications.

- Run `minikube service config --url` cmd from shell, which will give Config server url which can be accessible from host machine

### Test

```bash
~/T/csw-kube:master$ minikube service config --url
http://192.168.99.100:32477

~/T/csw-kube:master$ curl http://192.168.99.100:32477/metadata

{
  "repoPath": "/tmp/csw-config-svn",
  "annexPath": "/tmp/csw-config-annex-files",
  "annexMinFileSize": "10 MiB",
  "maxConfigFileSize": "50 MiB"
}

~/T/csw-kube:master$ minikube ip
192.168.99.100

~/T/csw-kube:master$ curl http://192.168.99.100:7879/members

{
  "selfNode": "akka.tcp://csw-cluster@172.17.0.4:3552",
  "leader": "akka.tcp://csw-cluster@172.17.0.4:3552",
  "oldest": "akka.tcp://csw-cluster@172.17.0.4:3552",
  "unreachable": [],
  "members": [
    {
      "node": "akka.tcp://csw-cluster@172.17.0.4:3552",
      "nodeUid": "-1477558283",
      "status": "Up",
      "roles": [
        "dc-default"
      ]
    },
    {
      "node": "akka.tcp://csw-cluster@172.17.0.5:39029",
      "nodeUid": "-341604885",
      "status": "Up",
      "roles": [
        "dc-default"
      ]
    }
  ]
}

```

### Shutdown Cluster

- Execute `down.sh` script from shell, which will remove all the deployments, services and statefulsets

- Run `minikube stop` to stop minikube cluster