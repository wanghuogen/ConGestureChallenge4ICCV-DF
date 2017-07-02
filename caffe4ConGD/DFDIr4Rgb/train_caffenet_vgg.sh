#!/usr/bin/env sh
CAFFERoot=/home/huogen/git/caffe   #change to your caffe folder
TOOLS=$CAFFERoot/build/tools

$TOOLS/caffe train \
    --solver=solver-resnet50.prototxt\
    --weights=(the model trained on DFDIr4Depth) -gpu 0
echo "Done."
