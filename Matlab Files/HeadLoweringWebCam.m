clear all;
clc


%%%%%%-------video input------%%%%%%
%{
obj = VideoReader('C:\Users\hello\Documents\MATLAB\Drowsiness-Detection-master\Drowsiness-Detection-master\dbase\head\h1.mp4','Tag','My reader object');
I = read(obj,1);
rate = obj.FrameRate;
rate;
%}
%%%%%%%----from webcam----%%%%%%%%

delete(imaqfind)
vid=videoinput('winvideo',1);
triggerconfig(vid,'manual');
set(vid,'FramesPerTrigger',1 );
set(vid,'TriggerRepeat', Inf);
set(vid,'Timeout',50); %set the Timeout property of VIDEOINPUT object 'vid' to 50 seconds
start(vid)

trigger(vid);
I=getdata(vid,1);

%%%%%-----working on 1st frame------%%%%%%%%%
figure, imshow(I)
I = imresize( I, [360 640]);
I = double(I);
[hue,s,v] = rgb2hsv(I);
cb = 0.148* I(:,:,1) - 0.291* I(:,:,2) + 0.439 * I(:,:,3) + 128;
cr = 0.439 * I(:,:,1) - 0.368 * I(:,:,2) -0.071 * I(:,:,3) + 128;
[w, h] = size(I(:,:,1));

count = 0;
for i=1:w
    for j=1:h
        if 135<=cr(i,j) && cr(i,j)<=180&& 120<=cb(i,j) && cb(i,j)<=200 && 0.01<=hue(i,j) && hue(i,j)<=0.1
            segment(i,j)=1;
            count = count + 1;
        else
            segment(i,j)=0;
        end
    end
end

im(:,:,1)=I(:,:,1).*segment;
im(:,:,2)=I(:,:,2).*segment;
im(:,:,3)=I(:,:,3).*segment;
figure,imshow(uint8(im));


%--------Calculating the percentage--------------------
count;
pixel_count = (count*5)/100;





%------------Working on rest frames

%{
num = 0;
nFrames = vid.NumberOfFrames;
nFrames;
%}

while get(vid,'FramesAvailable')>1  %Wait until at least 1 frame is available
      unavailable=1;


for t = 2:2:50
    count1 = 0;
    I = getdata(vid,t);
    I = imresize( I, [360 640]);
    I = double(I);
    [hue,s,v] = rgb2hsv(I);
    cb = 0.148* I(:,:,1) - 0.291* I(:,:,2) + 0.439 * I(:,:,3) + 128;
    cr = 0.439 * I(:,:,1) - 0.368 * I(:,:,2) -0.071 * I(:,:,3) + 128;
    [w, h] = size(I(:,:,1));

    for i=1:w
        for j=1:h
            if 135<=cr(i,j) && cr(i,j)<=180&& 120<=cb(i,j) && cb(i,j)<=200 && 0.01<=hue(i,j) && hue(i,j)<=0.1
                segment1(i,j)=1;
                count1 = count1 + 1;
            else
                segment1(i,j)=0;
            end
        end
    end 
    
    
    im(:,:,1)=I(:,:,1).*segment1;
    im(:,:,2)=I(:,:,2).*segment1;
    im(:,:,3)=I(:,:,3).*segment1;
    figure,imshow(uint8(im))
    
    
    if count - count1 > pixel_count 
        num = num+1;
    end
    
    if num > 15
        disp('generate warning');
        t/rate;
        num = 0;
        
        [y,Fs] = audioread('alarm.wav');
        sound(y,Fs);
    end
    
end
end