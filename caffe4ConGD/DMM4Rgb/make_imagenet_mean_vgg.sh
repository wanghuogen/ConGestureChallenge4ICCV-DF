#!/usr/bin/env sh
# Compute the mean image from the imagenet training leveldb
# N.B. this is available in data/ilsvrc12
CAFFERoot=/home/huogen/git/caffe   #change to your caffe folder
EXAMPLE=../DMM4Rgb
TOOLS=$CAFFERoot/build/tools
DATA=../DMM4Rgb
$TOOLS/compute_image_mean $EXAMPLE/RgbDMM_train_lmdb_vgg $DATA/RgbDMM_mean_vgg.binaryproto

echo "Done."
