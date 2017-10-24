## Openshift Setup for CSW-PROD

### Pre-requisite

- Docker

- VirtualBox

- MiniShift (`brew cask install minishift`) : This is required to create Openshift cluster locally.

### How to Run

- Execute `up.sh` script from shell

  This will start following:
  - Cluster Seed on Port 3552
  - Admin Http Server on Port 7878
  - Cluster Management on Port 7879
  - Config Server on Port 4000

### Shutdown Cluster

- Execute `down.sh` script from shell, which will remove all the deployments, services and statefulsets

- Run `minikube stop` to stop minikube cluster