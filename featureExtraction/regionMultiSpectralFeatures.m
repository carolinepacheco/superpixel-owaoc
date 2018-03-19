function [superPMS1, superPMS2, superPMS3, superPMS4, superPMS5, superPMS6, superPMS7] = regionMultiSpectralFeatures(path,ext,pattern, labels, n, m)

fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';

rlabels = labels(:); %image reference
numlab = max(rlabels);
for k = 1:size(name,1)
   X = (sprintf('Multispectral features to pixel: %d',k));
    disp(X);
    
    filename = char(name(k));
    filepath = fullfile(path,filename);
    frameR = imread(filepath);
    frame = imresize(frameR, [n m]);
    %frame = frameS(rowmin:rowmax,colmin:colmax);
    
    for j = 1:7
     myMS(:,:,j) = frame;
    end
    
    %multispectral feature
    %01
    MS1frame = im2double(myMS(:,:,1));
    MS1frame = MS1frame(:);
    
    %02
    MS2frame = im2double(myMS(:,:,2));
    MS2frame = MS2frame(:);
    
    %03
    MS3frame = im2double(myMS(:,:,3));
    MS3frame = MS3frame(:);
  
    %04
    MS4frame = im2double(myMS(:,:,4));
    MS4frame = MS4frame(:);
    
    %05
    MS5frame = im2double(myMS(:,:,5));
    MS5frame = MS5frame(:);
    
    %06
    MS6frame = im2double(myMS(:,:,6));
    MS6frame = MS6frame(:);
 
    %07
    MS7frame = im2double(myMS(:,:,7));
    MS7frame = MS7frame(:);
 
    
    for t=0:numlab
   
    f = find(rlabels==t);
    MS1SpLocal = MS1frame(f(:,1)); %MS1
    MS2SpLocal = MS2frame(f(:,1)); %MS2
    MS3SpLocal = MS3frame(f(:,1)); %MS3
    MS4SpLocal = MS4frame(f(:,1)); %MS4
    MS5SpLocal = MS5frame(f(:,1)); %MS5
    MS6SpLocal = MS6frame(f(:,1)); %MS6
    MS7SpLocal = MS7frame(f(:,1)); %MS7
   
    
    MS1SPL{t+1} = MS1SpLocal'; %MS1
    MS2SPL{t+1} = MS2SpLocal'; %MS2
    MS3SPL{t+1} = MS3SpLocal'; %MS3
    MS4SPL{t+1} = MS4SpLocal'; %MS4
    MS5SPL{t+1} = MS5SpLocal';  %MS5
    MS6SPL{t+1} = MS6SpLocal'; %MS6
    MS7SPL{t+1} = MS7SpLocal'; %MS7
    end

    superPMS1(:,k) = MS1SPL; %gray
    superPMS2(:,k) = MS2SPL; %red
    superPMS3(:,k) = MS3SPL; %green
    superPMS4(:,k) = MS4SPL; %blue
    superPMS5(:,k) = MS5SPL; %hue
    superPMS6(:,k) = MS6SPL; %saturation
    superPMS7(:,k) = MS7SPL; %saturation
  
end
 Z = (sprintf('Finalizing color features'));
 disp(Z);
end