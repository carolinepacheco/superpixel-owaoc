function [superPOCLBPRR, superPOCLBPGG, superPOCLBPBB, superPOCLBPRG, ...
    superPOCLBPRB, superPOCLBPGB] = regionColorTextureFeatures(path,ext,pattern, labels, n, m)

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
    X = (sprintf('************Color+Texture features to frame: %d',k));
    disp(X);
    
    
    filename = char(name(k));
    filepath = fullfile(path,filename);
    frameR = imread(filepath);
    frame= imresize(frameR, [n m]);
  %  frame = frameS(rowmin:rowmax,colmin:colmax,1:3);
   
    
    clrChans={'R', 'G', 'B'};
    
    % % % This will result in a list of all possible combinations
    chnsComb=perms(1:size(frame,3));
    chnsComb=chnsComb(:, 1:2);
    
    % % This is a list of relevant combinations
    chnsComb=nchoosek(1:size(frame,3), 2); % Color channels combinations
    
    % % Add self color LBP on top of inter color relations
    chnsComb=cat(1, [1, 1; 2, 2; 3, 3], chnsComb);
    neighDims=[3,3];
    isEfficient=true;
    
    OCLBP= oppositeColorLBP(frame, neighDims, chnsComb, isEfficient);
    
    %OCLBP feature
    OCLBPframe = im2double(OCLBP);
    
    %%% Center-R, neighborhood-R
    OCLBPRR = OCLBPframe(:,:,1);
    OCLBPRR = OCLBPRR(:);
    
    %%% Center-G, neighborhood-G
    OCLBPGG = OCLBPframe(:,:,2);
    OCLBPGG = OCLBPGG(:);
    
    %%% Center-B, neighborhood-B
    OCLBPBB = OCLBPframe(:,:,3);
    OCLBPBB = OCLBPBB(:);
    
    %%% Center-R, neighborhood-G
    OCLBPRG = OCLBPframe(:,:,4);
    OCLBPRG = OCLBPRG(:);
    
    %%% Center-R, neighborhood-B
    OCLBPRB = OCLBPframe(:,:,5);
    OCLBPRB = OCLBPRB(:);
    
    %%% Center-G, neighborhood-B
    OCLBPGB = OCLBPframe(:,:,6);
    OCLBPGB = OCLBPGB(:);
    
    for t=0:numlab
   
      f = find(rlabels==t);
      OCLBPRRSpLocal = OCLBPRR(f(:,1)); %OCLBPRR
      OCLBPGGSpLocal = OCLBPGG(f(:,1)); %OCLBPGG
      OCLBPBBSpLocal = OCLBPBB(f(:,1)); %OCLBPBB
      OCLBPRGSpLocal = OCLBPRG(f(:,1)); %OCLBPRG
      OCLBPRBSpLocal = OCLBPRB(f(:,1)); %OCLBPRB
      OCLBPGBSpLocal = OCLBPGB(f(:,1)); %OCLBPGB
      
      OCLBPRRSPL{t+1} = OCLBPRRSpLocal'; %OCLBPRR
      OCLBPGGSPL{t+1} = OCLBPGGSpLocal'; %OCLBPGG
      OCLBPBBSPL{t+1} = OCLBPBBSpLocal'; %OCLBPBB
      OCLBPRGSPL{t+1} = OCLBPRGSpLocal'; %OCLBPRG
      OCLBPRBSPL{t+1} = OCLBPRBSpLocal'; %OCLBPRB
      OCLBPGBSPL{t+1} = OCLBPGBSpLocal'; %OCLBPGB
     
    end
    
    superPOCLBPRR(:,k)  =  OCLBPRRSPL;  %OCLBPRR
    superPOCLBPGG(:,k)  =  OCLBPGGSPL;  %OCLBPGG
    superPOCLBPBB(:,k)  = OCLBPBBSPL;   %OCLBPBB
    superPOCLBPRG(:,k)  = OCLBPRGSPL;   %OCLBPRG
    superPOCLBPRB(:,k)  = OCLBPRBSPL;   %OCLBPRB
    superPOCLBPGB(:,k)  = OCLBPGBSPL;   %OCLBPGB
                
end

Z = (sprintf('Finalizing texture features'));
disp(Z);
end
    