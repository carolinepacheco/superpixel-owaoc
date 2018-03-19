function [labelsNumbs] = slicImages(path,ext,pattern)
fullpath = fullfile(path,ext);
list = dir(fullpath);
name = {list.name};
str  = sprintf('%s#', name{:});
num  = sscanf(str, pattern);
[dummy, index] = sort(num);
name = name(index)';


for i = 1:1%size(name,1)
    
    X = (sprintf('Image: %d',i));
    disp(X);
    
    filename = char(name(i));
    filepath = fullfile(path,filename);
    frame = imread(filepath);
    frame = imresize(frame, [160 120]);
    [labels, numlabels] = slicmex(frame,200,25);
   % [labels, numlabels] = slicmex(frame,100,20);
    
    BW1 = edge(double(labels),'Canny');
    BWoutline = BW1;
    Segout = frame; %original image
    
    labelsNumbs(i) = numlabels;
    Segout(BWoutline) = 255;
    % figure, imshow(Segout), title('outlined original image');
    imshow(Segout);
   
end

    Y = (sprintf('Finalizing color features'));
    disp(Y);
end
