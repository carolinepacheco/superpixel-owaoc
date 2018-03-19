function OCLBP= oppositeColorLBP(inImg, filtDims, chnsComb, isEfficient)
%% oppositeColorLBP
% The function implements OC-LBP (Opposite COlor Local Binary Pattern analysis). 
%   See OC-LBP description in: 
%   [1] Maenpaa T. "The local binary pattern approach to texture
%       analysis{extensions and applications"; 2003. Ph.D. thesis, University of Oulu.
%   [2] Maenpaa T. Matti P. and Jaakko V."Separating Color and Pattern Information for
%       Color Texture Discrimination"; University of Oulu, Finland
%
%% Syntax
%  OCLBP= oppositeColorLBP(inImg);
%  OCLBP= oppositeColorLBP(inImg, filtDims);
%  OCLBP= oppositeColorLBP(inImg, filtDims, chnsComb);
%  OCLBP= oppositeColorLBP(inImg, filtDims, chnsComb, isEfficient);
%
%% Description
% The OCLBP tests the relation between pixel and it's neighbors, encoding this relation
% into a binary word. This allows detection of patterns/features. As opposed to the
% regular LBP, the pixel and it's neighborhood can belong to different colors, thus
% resulting in ac Opposite Color relations. This operator is proposed to identify inter
% color pattern relation, capable of achieving much richer feature space.
%
%% Input arguments (defaults exist):
%  inImg- input image, a 2D matrix (3D color images will be converted to 2D intensity
%     value images)
%  filtDims- the used filter dimensions (2D filter is supported). Utilization on filter
%     other then [3x3] will result in non UINT8 OCLBP. Both filter dimensions should be
%     odd (so filter center will be well defined). Even dimensions will be converted to
%     odd ones.
%  chnsComb- a 2D (Nx2, where N is the number of color combinations) array specifying the
%     coor channels to be used to calculate the opposite colors LBP. First column specify
%     the center pixel channel, second column specify the neighborhood pixel channel
%  isEfficent- when enabled (true by default), convolution based LBP
%     calculation is performed for same colors. When disabled, pixel-wise (non efficient)
%     implementation is used for inter-channel LBP calculations. Uses "efficientLBP"
%     function, disabled, if this function is missing from the path.
%
%% Output arguments
%   OCLBP-    OCLBP image UINT8/UINT16/UINT32/UINT64/DOUBLE of same dimentions
%     [Height x Width] as inImg.
%
%% Issues & Comments
% - Currenlty, all neigbours are treated alike. Basically, we can use wighted/shaped
%     filter.
% - Current inter color LBP calculation is implmeneted pixel-wise, wgigc is not efficient.
%   3D convolution could speed this up, but it is not immplmeneted in Matlab.
%
%% Example
% img=imread('fabric.png');
% clrChans={'R', 'G', 'B'};
% 
% % % This will result in a list of all possible combinations
% % chnsComb=perms(1:size(img,3));
% % chnsComb=chnsComb(:, 1:2);
% 
% % This is a list of relevant combinations
% chnsComb=nchoosek(1:size(img,3), 2); % Color channels combinations
% 
% % Add self color LBP on top of inter color relations
% chnsComb=cat(1, [1, 1; 2, 2; 3, 3], chnsComb);
% neighDims=[3,3];
% isEfficient=true;
% 
% OCLBP= oppositeColorLBP(img, neighDims, chnsComb, isEfficient);
% figure;
% imshow(img);
% title('Original image');
% 
% nOCLBP=size(OCLBP, 3);
% nSubPlots=nOCLBP;
% nSubPlotRows=floor( sqrt(nSubPlots) );
% nSubPlotCols=ceil(nSubPlots/nSubPlotRows);
% 
% figure;
% subplot(nSubPlotRows, nSubPlotCols, 1);
% for iOCLBP=1:nSubPlots
%     subplot(nSubPlotRows, nSubPlotCols, iOCLBP)
%     imshow( OCLBP(:, :, iOCLBP) );
%     title( strcat(' Center- ', clrChans{chnsComb(iOCLBP, 1)}, ', neigborhood-' ,...
%         clrChans{chnsComb( iOCLBP, 2 )}, ' .') );
% end
%
%
%% See also
% efficientLBP - a custom fucntion used to implement LBP via convolution, inproving run time
%   by x100 factor
% snailMatIndex- a custom fucntion used to define the neigbours order returning a
%   snail/helix indexing of a matrix.
%
%% Revision history
% First version: Nikolay S. 2012-08-27.
% Last update:   Nikolay S. 2012-05-01.
%
% *List of Changes:*

%
if nargin<4
    isEfficient=true;
    if nargin<3
        chnsComb=[];
        if nargin<2
            filtDims=[3,3];
            if nargin==0
                error('Input image matrix/file name is missing.')
            end
        end
    end
end

if isEfficient && exist('efficientLBP', 'file')~=2
    % can't use the efficient LBP implementation if no isEfficient.m file exists in the
    % path
    isEfficient=false; 
end

if ischar(inImg) && exist(inImg, 'file')==2 % In case of file name input- read graphical file
    inImg=imread(inImg);
end

nClrs=size(inImg, 3);
assert(nClrs > 1, 'Error, not enough color channels')


inImgType=class(inImg);
isDoubleInput=strcmpi(inImgType, 'double');
if ~isDoubleInput
    inImg=double(inImg);
end
imgSize=size(inImg);

% verifiy filter dimentions are odd, so a middle element always exists
filtDims=filtDims+1-mod(filtDims,2);

filt=zeros(filtDims, 'double');
nNeigh=numel(filt)-1;

if nNeigh<=8
    outClass='uint8';
elseif nNeigh>8 && nNeigh<=16
    outClass='uint16';
elseif nNeigh>16 && nNeigh<=32
    outClass='uint32';
elseif nNeigh>32 && nNeigh<=64
    outClass='uint64';
else
    outClass='double';
end

if exist('snailMatIndex', 'file')~=2
    % If snailMatIndex exists, use it as it implements LBP properly
    iHelix=snailMatIndex(filtDims);
else
    % If not, use regular Matlab column-wise ordering
    iHelix=1:prod(filtDims);
end
filtCenter=ceil((nNeigh+1)/2);
iNeight=iHelix(iHelix~=filtCenter);


%% Primitive pixelwise solution
filtDimsR=floor(filtDims/2); % Filter Radius
iNeight(iNeight>filtCenter)=iNeight(iNeight>filtCenter)-1; % update index values.

% Padding image with zeroes, to deal with the edges
zeroPadRows=zeros(filtDimsR(1), imgSize(2), nClrs);
zeroPadCols=zeros(imgSize(1)+2*filtDimsR(1), filtDimsR(2), nClrs);

inImg=cat(1, zeroPadRows, inImg, zeroPadRows);
inImg=cat(2, zeroPadCols, inImg, zeroPadCols);
imgSize=size(inImg);

neighMat=true(filtDims);

neighMat(filtCenter)=false;
weightVec= (2.^( (1:nNeigh)-1 ));

if isempty(chnsComb)
    chnsComb=nchoosek(1:nClrs, 2); % Color channles combinations
    chnsComb=cat(1, [1, 1; 2, 2; 3, 3], chnsComb);
%    chnsComb=perms(1:3);
end
nComb=size(chnsComb, 1); % Number of color channels combinations

OCLBP=zeros( cat(2, imgSize(1), imgSize(2), nComb), outClass );

for iClrComb=1:nComb
    iCurrCenterClr=chnsComb(iClrComb, 1);
    iCurrNeighClr=chnsComb(iClrComb, 2);
    
    if isequal(iCurrCenterClr,iCurrNeighClr) && isEfficient
        OCLBP(:, :, iClrComb)=efficientLBP(inImg(:, :, iCurrCenterClr), filtDims, isEfficient);
        continue;
    end
       
    for iRow=( filtDimsR(1)+1 ):( imgSize(1)-filtDimsR(1) )
        for iCol=( filtDimsR(2)+1 ):( imgSize(2)-filtDimsR(2) )
            subImg=inImg(iRow+(-filtDimsR(1):filtDimsR(1)), iCol+(-filtDimsR(2):filtDimsR(2)),...
                iCurrNeighClr);
            % find differences between current pixel, and it's neighours
            diffVec=repmat(inImg(iRow, iCol, iCurrCenterClr), [nNeigh, 1])-subImg(neighMat);
            OCLBP(iRow, iCol, iClrComb)=cast( weightVec*(diffVec(iNeight)>0),  outClass);   % convert to decimal.
        end % for iCol=(1+filtDimsR(2)):(imgSize(2)-filtDimsR(2))
    end % for iRow=(1+filtDimsR(1)):(imgSize(1)-filtDimsR(1))
end   % for iClrComb=1:nComb

% crop the margins resulting from zero padding
OCLBP=OCLBP(( filtDimsR(1)+1 ):( end-filtDimsR(1) ),...
    ( filtDimsR(2)+1 ):( end-filtDimsR(2) ), :);
