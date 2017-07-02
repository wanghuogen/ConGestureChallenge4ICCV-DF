#!/usr/bin/env sh
# Compute the mean image from the imagenet training leveldb
# N.B. this is available in data/ilsvrc12
CAFFERoot=/home/huogen/git/caffe   #change to your caffe folder
EXAMPLE=../DFDIr4Rgb
TOOLS=$CAFFERoot/build/tools
DATA=../DFDIr4Rgb
$TOOLS/compute_image_mean $EXAMPLE/Rgb_DFDIr_train_lmdb_vgg $DATA/Rgb_DFDIr_mean_vgg.binaryproto

echo "Done."
