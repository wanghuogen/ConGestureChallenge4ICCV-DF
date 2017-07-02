# ConGestureChallenge for ICCV2017
There are the structions for using the codes.

Before using our codes, you'd better rebuild the liblinear.(Run "make" in "liblinear/matlab")

Place the Original DATASET in the folder "DATA"
####Step 1. Segment valid videos and Segment test videos
First, run `segment_videos4valid.py` and 'segment_videos4test.py'to use sliding window method to segment videos.
The output `valid_segmented.list` and 'test_segmented.list' file saved segmentation points.

####Step 2.Generate Isolate video from Continuous videos
Run 'Segment_depth_train.m','Segment_RGB_train.m','Segment_depth_valid_seg.m','Segment_RGB_valid_seg.m','Segment_depth_test_seg.m' and 'Segment_RGB_test_seg.m' in the folder 'video'

####Step 3.Generate DMM

Run 'DMM4training4Depth.m','DMM4training4Rgb.m','DMM4valid4Depth.m','DMM4valid4Rgb.m','DMM4test4Depth.m','DMM4test4Rgb.m'

####Step 3.Generate DFDI

Run 'DFDI4training4Depth.m','DFDI4training4Rgb.m','DFDI4valid4Depth.m','DFDI4valid4Rgb.m','DFDI4test4Depth.m','DFDI4test4Rgb.m'

####Step 4. Steps for training using caffe
step1. Install Caffe following the original README of Caffe.


step2. step into the every folders in "caffe4ConGD", and train the models.

 Run "sh create_imagenet_vgg.sh"
 Run "sh make_imagenet_mean_vgg.sh"
 Run "python convert_vgg.py"
 Run "sh train_caffenet_vgg.sh"

You'd better training depth-part first, and use the model of depth as the pred-trained model to train RGB part.

####Step 6.Steps for training using Tensorflow

step1. Install Tensorflow-0.11 and Tensorlayer

step2. Modify the class RNNLayer in tensorlayer/layer.py according to the tensorlayer-rnnlayer.py in the folder "LSTM"

step3.Copy the folder "image4LSTM" into "LSTM" folder.

step4. train the network
       Run "training_depth_DF.py"(about 60000 iterations)
       Run "training_depth_fullbody.py"(about 60000 iterations)
       Run "training_rgb_fullbody.py" (about 60000 iterations)
       Run "training_rgb_DF.py"(about 60000 iterations)
step5. Fine-tuning the RGB neural network using the Rgb models as the pre-trained model, and  fine-tuning the depth neural network using the Rgb models as the pre-trained model.

####Step 7.Generate the test_prediction.txt

step1.Step in LSTM, run "python test4depth.py", "test4depth_DF.py","test4rgb.py","test4rgb_DF.py"

step2. run the code "classifier4fusion10.py" in the folder. Please change caffe_root in the very beginning 

step3. run the code "main4submit.m" in the folder. And the file "test_prediction.txt" will be create.






