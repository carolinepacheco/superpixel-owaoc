function [superPGx, superPGy, superPGmag, superPGdir] = regionEdgeFeatures(path,ext,pattern, labels, imgsize)

fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';
n = imgsize(1);
m=  imgsize(2);

rlabels = labels(:);
numlab = max(rlabels);
for k = 1:size(name,1)
    X = (sprintf('************Edge features to frame: %d',k));
    disp(X);
    
    filename = char(name(k));
    filepath = fullfile(path,filename);
    frameR = imread(filepath);
    frameG = rgb2gray(frameR);
    frame = imresize(frameG, [n m]);
    %frame = imcrop(frameS,[68.5100 61.5100 34.9799 21.9799]);
    %frame = frameS(rowmin:rowmax,colmin:colmax);
    
    [Gx, Gy] = imgradientxy(frame);
    [Gmag, Gdir] = imgradient(Gx, Gy);
    
    %%%%%%%%Gradients%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Gx feature
    Gxframe = (Gx)./255;
    Gxframe = Gxframe(:);
    
    %Gy feature
    Gyframe = (Gy)./255;
    Gyframe = Gyframe(:);
    
    %Gmag feature
    Gmagframe = (Gmag)./255;
    Gmagframe = Gmagframe(:);
    
    %Gdir feature
    Gdirframe = (Gdir)./255;
    Gdirframe = Gdirframe(:);
    
    
    for t=0:numlab
        
        f = find(rlabels==t);
        GxSpLocal = Gxframe(f(:,1));    %Gx
        GySpLocal = Gyframe(f(:,1));     %Gy
        GmagSpLocal = Gmagframe(f(:,1)); %Gmag
        GdirSpLocal = Gdirframe(f(:,1));  %Gmag
        
        GxSPL{t+1} = GxSpLocal'; %Gx
        GySPL{t+1} = GySpLocal'; %Gy
        GmagSPL{t+1} = GmagSpLocal'; %Gmag
        GdirSPL{t+1} = GdirSpLocal'; %Gmag
        
    end
    superPGx(:,k)      =  GxSPL; %Gx
    superPGy(:,k)      =  GySPL; %Gy
    superPGmag(:,k)    =  GmagSPL; %Gmag
    superPGdir(:,k)    = GdirSPL; %Gdir
end

Z = (sprintf('Finalizing edge features'));
disp(Z);
end