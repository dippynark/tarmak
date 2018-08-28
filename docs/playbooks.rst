.. getting-started:

Playbooks
=========

Introduction
------------

This page contains a number of operational playbooks for carrying out common tasks against a Tarmak environment. The playbooks assume you have already spun up a single or multi-cluster Tarmak environment.

.. warning::
  Tarmak has been designed to migrate between versions successfully. However, it is important to test the following steps on a non-production system first to give greater confidence that this will work

Upgrading Kubernetes version
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Tarmak can be used to upgrade Kubernetes version. 

* Select the cluster to upgrade in your `tarmak.yaml` configuration file using `tarmak clusters set-current` or otherwise (or use the --current-cluster flag on all subsequent `tarmak` commands)
  * You can verify you have selected the correct cluster by running `tarmak clusters list`
* Run `tarmak clusters plan` to ensure no changes are currently required
* Change the version of your selected cluster in `tarmak.yaml`
  * You can only upgrade by one minor version
  * If you are running in a multi-cluster environment, note that the hub is not dependent on Kubernetes version and so this procedure should only be applied to the cluster
  * Tarmak does not consider workloads running on the cluster itself so it is important to consult the corresponding <CHANGELOG https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG.md>_ for anything that might require workload changes
* Run `tarmak clusters plan` against your Kubernetes cluster
  * The only change you should see at this point is a change to the `puppet.tar.gz` in your cluster's S3 storage bucket. If other changes are required then revert the Kubernetes version change and address the other changes first
* Run `tarmak clusters apply --infrastructure-only`
  * This will update the storage bucket to contain the latest clusters configuration
  * Existing master and worker instances will continue to run with the old Kubernetes version as desired
* Roll master instances

  a) List all master instances by running `tarmak kubectl get nodes --selector node-role.kubernetes.io/master`. If all instances are reporting the new version then you are finished, otherwise pick an instance reporting the old version
  b) Run `tarmak kubectl drain <nodeName> --ignore-daemonsets` and wait for the command to complete

    - If you have scheduled additional workloads on this node then the drain command may fail with an error stating that extra flags are needed (i.e. `--force` or `--delete-local-data`). Make sure you understand the impact of adding these flags if required
    - You should see that the node has a status `SchedulingDisabled` by inspecting the output of `tarmak kubectl get nodes`

  c) Restart the instance

    - If you are running a single master instance, the apiserver will become unreachable whilst the master is restarting and so most `tarmak kubectl` will fail during this time
    - You should see that the node's status will temporarily be `NotReady` by inspecting the output of `tarmak kubectl get nodes`
    
  d) Check all master nodes are reporting a `Ready` status and the restarted node is reporting the new version
  e) Run `tarmak kubectl uncordon <nodeName>` to mark the node as schedulable again. Verify this by inspecting the output of `tarmak kubectl get nodes`
  f) Go back to step a)
  
* Roll worker instances. For each worker instance
  * List all worker instances
