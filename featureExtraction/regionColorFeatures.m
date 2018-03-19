function [superPGray, superPRed, superPGreen, superPBlue, superPHue, superPSaturation, superPValue] = regionColorFeatures(path,ext,pattern, labels, imgsize)

fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';
n = imgsize(1);
m=  imgsize(2);

rlabels = labels(:); %image reference
numlab = max(rlabels);
for k = 1:size(name,1)
    X = (sprintf('************Color features to frame: %d',k));
    disp(X);
    
    filename = char(name(k));
    filepath = fullfile(path,filename);
    frameR = imread(filepath);
    frame = imresize(frameR, [n m]);
    %frame = frameS(rowmin:rowmax,colmin:colmax,1:3);
    
    
    hsv_frame = rgb2hsv(frame);
   % hsv_frame = hsv_frameT(rowmin:rowmax,colmin:colmax,1:3);
    
    %gray feature
    grayframe = rgb2gray(frame);
    grayframe = im2double(grayframe);
    grayframe = grayframe(:);
    
    %red feature
    redframe = frame(:,:,1);
    redframe = im2double(redframe);
    redframe = redframe(:);
    
      %green feature
    greenframe = frame(:,:,2);
    greenframe = im2double(greenframe);
    greenframe = greenframe(:);
    
    %blue feature
    blueframe = frame(:,:,3);
    blueframe = im2double(blueframe);
    blueframe = blueframe(:);
    
    %hue feature
    hueframe = hsv_frame(:,:,1);
    hueframe = hueframe(:);
    
    %saturation feature
    saturationframe = hsv_frame(:,:,2);
    saturationframe = saturationframe(:);
    
    %value feature
    valueframe = hsv_frame(:,:,3);
    valueframe = valueframe(:);
    
    for t=0:numlab
   
    f = find(rlabels==t);
    graySpLocal = grayframe(f(:,1));%gray
    redSpLocal = redframe(f(:,1));%red
    greenSpLocal= greenframe(f(:,1)); %green
    blueSpLocal= blueframe(f(:,1)); %blue
    hueSpLocal = hueframe(f(:,1)); %hue
    saturationSpLocal = saturationframe(f(:,1)); %saturation
    valueSpLocal = valueframe(f(:,1)); %valuE
   
    
    graySPL{t+1} = graySpLocal'; %gray
    redSPL{t+1} = redSpLocal'; %red
    greenSPL{t+1} = greenSpLocal'; %green
    blueSPL{t+1} = blueSpLocal'; %blue
    hueSPL{t+1} = hueSpLocal'; %hue
    saturationSPL{t+1} = saturationSpLocal'; %saturation
    valueSPL{t+1} = valueSpLocal'; %saturation
    end

    superPGray(:,k) =  graySPL; %gray
    superPRed(:,k)  =  redSPL; %red
    superPGreen(:,k)= greenSPL; %green
    superPBlue(:,k)= blueSPL; %blue
    superPHue(:,k)= hueSPL; %hue
    superPSaturation(:,k)= hueSPL; %saturation
    superPValue(:,k)= valueSPL; %saturation
  
end
 disp('END Color features');
end