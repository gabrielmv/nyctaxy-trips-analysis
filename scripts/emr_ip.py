import boto3

emr = boto3.client('emr')

cluster_id = emr.list_clusters(ClusterStates=['STARTING','BOOTSTRAPPING','RUNNING','WAITING'])['Clusters'][0]['Id']

print(emr.describe_cluster(ClusterId=cluster_id)['Cluster']['MasterPublicDnsName'])