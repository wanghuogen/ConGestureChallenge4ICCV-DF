#!/usr/bin/env sh
# Compute the mean image from the imagenet training leveldb
# N.B. this is available in data/ilsvrc12
CAFFERoot=/home/huogen/git/caffe   #change to your caffe folder
EXAMPLE=../DMM4Depth
TOOLS=$CAFFERoot/build/tools
DATA=../DMM4Depth
$TOOLS/compute_image_mean $EXAMPLE/DepthDMM_train_lmdb_vgg $DATA/DepthDMM_mean_vgg.binaryproto

echo "Done."
