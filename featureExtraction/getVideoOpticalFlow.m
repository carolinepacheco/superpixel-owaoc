
function  [optflow]= getVideoOpticalFlow(path,ext,pattern, n, m)
  fullpath = fullfile(path,ext); 
  list = dir(fullpath);
  name = {list.name};
  str  = sprintf('%s#', name{:});
  num  = sscanf(str, pattern);
  [dummy, index] = sort(num);
  name = name(index)';
   
  for i = 1:size(name,1)
  filename = char(name(i));
  filepath = fullfile(path,filename);
  frameS = imread(filepath);
  frame = imresize(frameS, [n m]);
 % frame = imcrop(filenameS,[68.5100 61.5100 34.9799 21.9799]);
  %frame = filenameS(rowmin:rowmax,colmin:colmax,1:3);
  mov(i).cdata = frame;
  mov(i).colormap = [];
 end 
  
movie2avi(mov, 'motion.avi', 'compression','None', 'fps',10);

hvfr = vision.VideoFileReader('motion.avi', ...
                                      'ImageColorSpace', 'Intensity', ...
                                      'VideoOutputDataType', 'uint8');
        hidtc = vision.ImageDataTypeConverter; 
        hof = vision.OpticalFlow('ReferenceFrameDelay', 1);
        hof.OutputValue = 'Horizontal and vertical components in complex form';
        hvp = vision.VideoPlayer('Name', 'Motion Vector');
        j = 1;
        while ~isDone(hvfr)
          frame = step(hvfr);
          im = step(hidtc, frame); % convert the image to 'single' precision
          of = step(hof, im);      % compute optical flow for the video
          optflow{j} = of;
%           lines = videooptflowlines(of, 20); % generate coordinate points 
%           out = insertShape(im, 'Line', lines, ...
%                      'Color', 'white'); % draw lines to indicate flow
%           step(hvp, out);               % view in video player
        j = j + 1;
        end
        release(hvp);
        release(hvfr);
end





