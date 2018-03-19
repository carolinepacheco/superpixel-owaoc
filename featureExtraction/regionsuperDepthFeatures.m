function [superD] = regionsuperDepthFeatures(path,ext,pattern, labels, n, m)

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
   X = (sprintf('Depth features to frame: %d',k));
    disp(X);
    
    filename = char(name(k));
    filepath = fullfile(path,filename);
    frameR = imread(filepath);
    frame = imresize(frameR, [n m]);
    frame = im2double(frame);
    
    for t=0:numlab
   
    f = find(rlabels==t);
    DpLocal = frame(f(:,1)); %Depth
    
    DSPL{t+1} = DpLocal'; %Depth
    end

    superD(:,k) = DSPL; %depth
  
end
 Z = (sprintf('Finalizing depth features'));
 disp(Z);
end