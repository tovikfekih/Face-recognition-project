function [ visage ] = facedetect(img,dimension)
    img = imread(img);
    FaceDetect = vision.CascadeObjectDetector;
    visage = step(FaceDetect,img);

   
    
end

