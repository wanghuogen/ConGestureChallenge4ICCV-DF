#!/usr/bin/env sh
# Compute the mean image from the imagenet training leveldb
# N.B. this is available in data/ilsvrc12
CAFFERoot=/home/huogen/git/caffe   #change to your caffe folder
EXAMPLE=../DFDIf4Rgb
TOOLS=$CAFFERoot/build/tools
DATA=../DFDIf4Rgb
$TOOLS/compute_image_mean $EXAMPLE/Rgb_DFDIf_train_lmdb_vgg $DATA/Rgb_DFDIf_mean_vgg.binaryproto

echo "Done."
