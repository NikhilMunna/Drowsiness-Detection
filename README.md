# Drowsiness-Detection

INSTRUCTONS TO RUN CODE

1)INSTALL mini-conda

2)RUN THE FOLLOWING COMMANDS IN CONDA CMD
conda update conda
conda update anaconda
conda create -n env_dlib
conda activate env_dlib
conda install -c conda-forge dlib
pip install opencv-python
pip install scipy
pip install playsound
pip install imutils
pip install argparse

3)COMMANDS TO ACTIVATE YOUR ENVIRONMENT
#TO activate 
conda activate env_dlib

#to deactivate
conda deactivate env_dlib

#to list
conda env list

4)RUN THE FOLLOWING COMMAND IN CONDA-CMD
python detect_drowsiness.py --shape-predictor shape_predictor_68_face_landmarks.dat --alarm alarm.wav


#Approach

HeadLowering.m
It contains code for monitoring head movement.

Steps Involved :-
1) Firstly, used 'Voila Jones' algorithm for detecting face in each frames.
2) Used 'Color Space' conversion technique, converted image from RGB into YCbCr format.
3) Used 'Skin Segmentation' to find out the exposed face (facing forward). Calculated the percentage of skin using the defined skin color range.  
4) On the basis of percentage of skin exposed, decided if the head is bent or facing sideways.