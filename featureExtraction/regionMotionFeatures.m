function [superPOFlow] = regionMotionFeatures(path,ext,pattern, optflow, labels)

fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';

rlabels = labels(:);
numlab = max(rlabels);
for k = 1:size(name,1)
    X = (sprintf('************Motion features to frame: %d',k));
    disp(X);
    
    %opticalFlow
    filename = optflow{k};
    frame = im2double(filename);
    opticalFlow = frame(:);
    
    for t=0:numlab
        
        f = find(rlabels==t);
        opticalFlowSpLocal = opticalFlow(f(:,1)); %Optical Flow
        opticalFlowSPLR = opticalFlowSpLocal'; %Optical Flow
        opticalFlowSPL{t+1} = real(opticalFlowSPLR); %Optical Flow
        
    end
    superPOFlow(:,k) = opticalFlowSPL; %Optical Flow
end

Z = (sprintf('Finalizing motion features'));
disp(Z);
end