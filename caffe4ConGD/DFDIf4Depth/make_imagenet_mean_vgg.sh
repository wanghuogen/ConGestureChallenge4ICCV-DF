#!/usr/bin/env sh
# Compute the mean image from the imagenet training leveldb
# N.B. this is available in data/ilsvrc12
CAFFERoot=/home/huogen/git/caffe   #change to your caffe folder
EXAMPLE=../DFDIf4Depth
TOOLS=$CAFFERoot/build/tools
DATA=../DFDIf4Depth
$TOOLS/compute_image_mean $EXAMPLE/depth_DFDIf_train_lmdb_vgg $DATA/depth_DFDIf_mean_vgg.binaryproto

echo "Done."
