%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Universite de La Rochelle
% Date: 05/12/2016
% Copyright 2014 by Caroline Pacheco do E.Silva
%  If you have any problem, please feel free to contact Caroline Pacheco do E.Silva.
%  lolyne.pacheco@gmail.com

%  If you have used this code in a scientific publication, we would appreciate citations to
%  the following paper: Silva, C. and Bouwmans, T. and Frélicot, C. ?Superpixel-based incremental wagging one-class ensemble for feature selection in foreground/background separation?. Pattern Recognition Letters (PRL), 2017 

%  You can found more details at: ....

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
addpath('prtools_5.2.3/prtools')
addpath('dd_tools_2.1.1')

libpath = 'featureExtraction/';
libpath2 = 'SLIC/';
% move mylib to the end of the path
addpath(libpath, '-end');
addpath(libpath2, '-end');

clear;clc;
%% REFERENCE IMAGE
rimage = imread('reference_image.jpg');
imgsize = [120 160];
img = imresize(rimage, [imgsize]);


[labels, numlabels] = slicmex(img, 4600,50);

%FUNCTION AGGREGATION

%       method      rank aggregation method. Could be one of the following:
%                   'min', 'median', 'mean', 'geom.mean', 'stuart', 'RRA', 
%                    'max, 'sum' or 'entropy''.
%jA TESTSTADOS max, median, entropy
method = 'max'; 


%% TRAIN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% LOADING DATA FOR TRAIN

path = 'Train'; ext = '*.jpg'; pattern = '%d.jpg#';
[spGray, spRed, spGreen, spBlue] = regionColorFeatures(path,ext,pattern, labels, ...
  imgsize);%color features

[spXCS] = regionTextureFeatures(path,ext,pattern, labels, imgsize); %texture features#

% %%% FUNCTION AGGREGATION
[TrainGray, TrainRed, TrainGreen, TrainBlue] = aggColorSuperPixel(spGray, spRed, spGreen, ...
    spBlue, method); 

[TrainXCS] = aggTextureSuperPixel(spXCS, method);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% LOADING DATA TO VALIDATION
path = 'Validation'; ext = '*.jpg'; pattern = '%d.jpg#';

[spValGray, spValRed, spValGreen, spValBlue] = regionColorFeatures(path,ext,pattern, labels, ...
   imgsize);%color features

[spValXCS] = regionTextureFeatures(path,ext,pattern, labels, imgsize); %texture features#

%%% LOADING GT TO VALIDATION  
path = 'GTValidation'; ext = '*.png'; pattern = '%d.png#';
[spValGtVal] = getGt(path,ext,pattern, labels, imgsize);

% %%% FUNCTION AGGREGATION
[ValGray, ValRed, ValGreen, ValBlue] = aggColorSuperPixel(spValGray, spValRed, spValGreen, spValBlue, ...
    method); 
  
[ValXCS] = aggTextureSuperPixel(spValXCS, method);
  
[Valgt] = aggGTSuperPixel(spValGtVal);
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% LOADING DATA TO FEATURE IMPORTANCE ADAPTATION
path = 'AdapImp'; ext = '*.jpg'; pattern = '%d.jpg#';

[spAdapGray, spAdapRed, spAdapGreen, spAdapBlue] = regionColorFeatures(path,ext,pattern, labels, ...
   imgsize);%color features

[spAdapXCS] = regionTextureFeatures(path,ext,pattern, labels, imgsize); %texture features#


%%% LOADING GT TO VALIDATION  
path = 'GTAdapImp'; ext = '*.png'; pattern = '%d.png#';
[spGtAdap] = getGt(path,ext,pattern, labels, imgsize);

% %%% FUNCTION AGGREGATION
[AdapGray, AdapRed, AdapGreen, AdapBlue] = aggColorSuperPixel(spAdapGray, spAdapRed, spAdapGreen, spAdapBlue, ...
    method); 
  
[AdapXCS] = aggTextureSuperPixel(spAdapXCS, method);
    
[Adapgt] = aggGTSuperPixel(spGtAdap);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% %%% LOADING DATA TO TEST

%%% LOADING COLOR DATA TO TEST 
path = 'Test'; ext = '*.jpg'; pattern = '%d.jpg#';

[spTestGray, spTestRed, spTestGreen, spTestBlue] = regionColorFeatures(path,ext,pattern, labels, ...
   imgsize);%color features

[spTestXCS] = regionTextureFeatures(path,ext,pattern,labels, imgsize); %texture features#
  
% %%% FUNCTION AGGREGATION
[TestGray, TestRed, TestGreen, TestBlue] = aggColorSuperPixel(spTestGray, spTestRed, spTestGreen, spTestBlue, ...
    method); 
  
[TestXCS] = aggTextureSuperPixel(spTestXCS, method);
  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TRAIN CLASSIFIER/FEATURES
[w, addW, mError] = trainFeatures(TrainGray, TrainRed, TrainGreen, TrainBlue,TrainXCS,...
  ValGray, ValRed, ValGreen, ValBlue, AdapXCS, Valgt);

%ADAPTATION FEATURES IMPORTANCES 
%[impFeatureTime2] = adapImpTrain_new(AdapGray, AdapXCS, AdapD, Adapgt, w); %APENAS PARA PEGAR IMPORTANCIA
[M, impFeatureTime] = adapImpTrain(AdapGray, AdapRed, AdapGreen, AdapBlue, AdapXCS,...
  Adapgt, w, labels);

%%% PRUNING CLASSIFIERS
[E,importanceE] = pruningEnsemble(w,impFeatureTime);

[F] = foregroundDetection(TestGray, TestRed, TestGreen, TestBlue, TestXCS,...
  importanceE, E, addW, labels);

%%
origimgsize = [240 320];
show_2dvideo(F,imgsize, origimgsize);

%%
%%M%%%%%%%%%%%%%%%%M%%%%%%%%%%%%%%%%M%%%%%%%%%%%%%%%%M%%%%%%%%%%%%%%%%M%%%%%%%%%%%%%%%%M%%%%%%%%%%%%
%%% EXPERIMENTAL RESULTS

%%%%%%%SHOW HISTOGRAM%%%%%%%%%%%%%%%%
%[FGF] = impFeatures2(impFeatureTime, labels); %group features
[FGF] = impFeatures(impFeatureTime, labels); %group features
show_all_histogram(FGF,imgsize);

%%%%%%%SHOW FEATURE MAPS%%%%%%%%%%%%%%%%
%escolha a imagem que vc quer mostar e seu mapa de features
rimg = imread('AdapImp/1.jpg');
rimg = imresize(rimg, [imgsize]);

AD = FGF(:,1); %mote que deve-se escolher a mesma imagem da instrucao acima neste caso 51
showIFeature(AD, rimg, 5); % 3 parametro é a quantidade de features utilizadas (see function impFeatures)