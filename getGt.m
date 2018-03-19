function [superGT, name] = getGt(path,ext,pattern, labels, imgsize)

fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';

rlabels = labels(:);
numlab = max(rlabels);
n = imgsize(1);
m=  imgsize(2);

for k = 1:size(name,1)
    X = (sprintf('************GT to frame: %d',k));
    disp(X);
    
    filename = char(name(k));
    filepath = fullfile(path,filename);
    frameG = imread(filepath);
    %frame = imresize(frame, [120 160]);
   frame = imresize(frameG, [n m]);
    
    %GT
    gtframe = logical(frame);
    gtframe = im2double(gtframe);
    gtframe = gtframe(:);
    
    
    for t=0:numlab
        
        f = find(rlabels==t);
        GTSpLocal = gtframe(f(:,1));    %GT
       
        GTSPL{t+1} = GTSpLocal'; %GT   
    end
    superGT(:,k)      =  GTSPL; %GT
end
    
Z = (sprintf('Finalizing GT'));
disp(Z);
end
