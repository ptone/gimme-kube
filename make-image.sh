#!/bin/bash

instance=image-maker
zone="${ZONE:-us-west2-a}"
project=$(gcloud config list project --format "value(core.project)" )
image_name=kubebox

gcloud compute instances create $instance \
--zone=$zone --machine-type=n1-standard-2 \
--image=ubuntu-minimal-1804-bionic-v20190429 \
--image-project=ubuntu-os-cloud \
--no-boot-disk-auto-delete \
--async \
--metadata-from-file startup-script=prep-image.sh


echo -n "installing kubeadm..."
until gcloud compute instances describe $instance --format='value("status")' --zone=$zone | grep -q "TERMINATED";
do 
  echo -n '.'
  sleep 3; 
done
echo

gcloud compute instances delete $instance --zone=$zone --quiet & > /dev/null 2>&1
echo "Creating image"
gcloud compute images create ${image_name} --source-disk $instance --source-disk-zone=$zone
echo "Removing image maker disk"
gcloud compute disks delete $instance --zone=$zone --quiet & > /dev/null 2>&1
