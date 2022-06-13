# this is a helm repo for a single node kafka and zookeeper deployment
# The namespace used is kafkahelm, the service type used is nodePort
# the broker advertised listner is configured with the pre fetched ip address of the kubernetes node
# in case the kubernetes cluster has multiple node then, the nodes needs to be labeled and the deployments needs to have a nodeSelector with the proper node label.
