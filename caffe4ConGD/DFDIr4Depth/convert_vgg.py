import sys
sys.path.append('/home/huogen/git/caffe/python') #change to your own folder
from caffe.proto import caffe_pb2
import caffe.io
from caffe.io import blobproto_to_array
import numpy as np

blob = caffe_pb2.BlobProto()
data = open("depth_DFDIr_mean_vgg.binaryproto", "rb").read()
blob.ParseFromString(data)
nparray = np.array(blobproto_to_array(blob))
f = file("depth_DFDIr_mean_vgg.npy","wb")
np.save(f,nparray[0])
f.close()
