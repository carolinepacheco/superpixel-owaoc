function [superPXCS] = regionTextureFeatures(path,ext,pattern, labels, imgsize)

fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';
n = imgsize(1);
m = imgsize(2);

rlabels = labels(:);
numlab = max(rlabels);
for k = 1:size(name,1)
    X = (sprintf('************Texture features to frame: %d',k));
    disp(X);
   
    filename = char(name(k));
    filepath = fullfile(path,filename);
    frameR = imread(filepath);
    frame = imresize(frameR, [n m]);
   
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%XCS-LBP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % parameter set
    
    % 1. "FxRadius", "FyRadius" and "TInterval" are the radii parameter along X, Y and T axis; They can be 1, 2, 3 and 4. "1" and "3" are recommended.
    %  Pay attention to "TInterval". "TInterval * 2 + 1" should be smaller than the length of the input sequence "Length".
    % For example, if one sequence includes seven frames, and you set TInterval
    % to three, only the pixels in the frame 4 would be considered as central
    % pixel and computed to get theXTC-SLBP feature.
    FxRadius = 1;
    FyRadius = 1;
    
    
    % 2. "TimeLength" and "BoderLength" are the parameters for bodering parts in time and space which would not
    % be computed for features. Usually they are same to TInterval and the
    % bigger one of "FxRadius" and "FyRadius";
    BorderLength = 1;
    
    % Compute uniform patterns
    NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
    
    % double image
    I = rgb2gray(frame);
    I = double(I);
    XCS = XCSLBP(I,FxRadius, FyRadius, NeighborPoints, BorderLength);
    %XCS = XCSr(rowmin:rowmax,colmin:colmax);
    
    XCS = XCS*(255/16);
    
    %XCS-LBP feature
    XCSframe = im2double(XCS);
    XCSframe = XCSframe(:);
    
    %LBP
    
    for t=0:numlab
   
      f = find(rlabels==t);
      XCSSpLocal     = XCSframe(f(:,1)); %XCS
      
      
      XCSSPL{t+1} = XCSSpLocal';         %XCS-LBP
    end
    
    superPXCS(:,k) = XCSSPL;      %XCS-LBP
end

disp('END Finalizing texture features');
end
    