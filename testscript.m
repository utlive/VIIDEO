clc
clear
close all


width            = 176;
height           = 144;


blocksizerow     = 18;
blocksizecol     = 18;
filtlength1      = 7;
filtlength2      = 7;
filtlength       = [filtlength1 filtlength2];
blockrowoverlap  = 8;
blockcoloverlap  = 8;


% Compute the score for a distorted video

vidname          = 'foreman_dst_qcif.yuv';
filep            = dir(vidname); 
fileBytes        = filep.bytes; %Filesize
fwidth           = 0.5;
fheight          = 0.5;
clear filep
framenumber      = fileBytes/(width*height*(1+2*fheight*fwidth)); %Framenumber


VIIDEOscoreDist   =  computeVIIDEOscore(vidname,height,width, ...
                     framenumber,blocksizerow,blocksizecol,...
                     blockrowoverlap,blockcoloverlap,filtlength);
                 
                 
disp(sprintf('Video quality for distorted video: %f', VIIDEOscoreDist));                   

% Compute the score for a pristine video

                 
vidname          = 'foreman_org_qcif.yuv';
filep            = dir(vidname); 
fileBytes        = filep.bytes; %Filesize
fwidth           = 0.5;
fheight          = 0.5;
clear filep
framenumber      = fileBytes/(width*height*(1+2*fheight*fwidth)); %Framenumber


VIIDEOscorePris  =  computeVIIDEOscore(vidname,height,width, ...
                     framenumber,blocksizerow,blocksizecol,...
                     blockrowoverlap,blockcoloverlap,filtlength);    
                 
disp(sprintf('Video quality for pristine video: %f', VIIDEOscorePris)) ;                   
