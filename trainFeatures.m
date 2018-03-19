function [w, addW, mError] = trainFeatures(varargin)

w = struct([]);
wClass = struct([]);
mError = struct([]);
addW = struct([]);
addWstrore = struct([]);
classError = struct([]);
nclassifier = 10;

% KTYPE   defines the kernel type
%        'linear'       | 'l': A*B'
%        'polynomial'   | 'p': sign(A*B'+1).*(A*B'+1).^P
%        'homogeneous'  | 'h': sign(A*B').*(A*B').^P
%        'exponential'  | 'e': exp(-(||A-B||)/P)
%        'radial_basis' | 'r': exp(-(||A-B||.^2)/(P*P))
%        'sigmoid'      | 's': sigm((sign(A*B').*(A*B'))/P)
%        'distance'     | 'd': ||A-B||.^P
%        'cityblock'    | 'c': ||A-B||_1
%        'negdistance'  | 'n': -||A-B||.^P


mu = 0; sd =  0.05;    %# mean, std dev
C = 1; ktype = 'r'; kpar = 4;

for k = 1:size(varargin{1},1)
    X = (sprintf('Training superpixel: %d',k));
    disp(X);
    %%%%%%COLOR DATA TRAIN
    TrainDataGray = varargin{1}(k,:);
    TrainDataGray = TrainDataGray + randn(size(TrainDataGray))*sd + mu;
    TrainDataRed = varargin{2}(k,:);
    TrainDataRed = TrainDataRed + randn(size(TrainDataRed))*sd + mu;
    TrainDataGreen = varargin{3}(k,:);
    TrainDataGreen = TrainDataGreen + randn(size(TrainDataGreen))*sd + mu;
    TrainDataBlue = varargin{4}(k,:);
    TrainDataBlue = TrainDataBlue + randn(size(TrainDataBlue))*sd + mu;
    
    %%%%%%TEXTURE DATA TRAIN
    TrainDataXCS = varargin{5}(k,:);
    TrainDataXCS = TrainDataXCS + randn(size(TrainDataXCS))*sd + mu;
   
    %%%%%%COLOR DATA VALIDATION
    ValDataGray = varargin{6}(k,:);
    ValDataRed = varargin{7}(k,:);
    ValDataGreen = varargin{8}(k,:);
    ValDataBlue = varargin{9}(k,:);
    %%%%%%TEXTURE DATA VALIDATION
    ValDataXCS = varargin{10}(k,:);
   
    %%%GT - VALIDATION
    DataGT = varargin{11}(k,:);
    DataGT = DataGT';
    
    TrainData = [TrainDataGray' TrainDataRed' TrainDataGreen' TrainDataBlue' TrainDataXCS'];
    
    ValData = [ValDataGray' ValDataRed' ValDataGreen' ValDataBlue' ValDataXCS'];
    
    datasamples = size(TrainData);
    label_data = ones(datasamples(1),1);
    %indices = crossvalind('Kfold',DataGT,10); % data mixture
    indices = crossvalind('Kfold',DataGT,10); % data mixture

  for j = 1:size(TrainData,2) %check number features
    TrainDataS =  TrainData(:,j);
    ValDataS =   ValData(:,j);
    
    for c = 1:nclassifier %number base classifiers
      %choose the kernel
      pdwc = (poissrnd(5,size(TrainData,1),1));
      dwc = (pdwc - min(pdwc))/(max(pdwc) - min(pdwc));
      W = inc_setup('svdd',ktype,kpar,C,TrainDataS,label_data, dwc);
      w0 = inc_store(W);
      
      errorc = 0;
      for i = 1:10 % cross validation to calculate error
        test = (indices == i);
        outColor = ValDataS(test,:)*w0;
        label_test_color = outColor*labeld;
        A3 = DataGT(test,:);
        if ((size(A3,1) ~= 1)  && (isempty(A3) ~= 1))
        [error] = calc_error(label_test_color,  A3); % calcula o erro
        errorc =  errorc + error;
        end
      end % final validation to calculate error
      meanError = errorc/i;
      
      if meanError <= 0.4 % check error
        Wstore{1} = w0;
        WC{1} = W;
        CError{1} =  meanError;
        break
      else
        Wstore{1} = w0;
        WC{1} = W;
        CError{1} =  meanError;
      end
      
    end  %final number base classifiers
    wClass{j} = Wstore;
    addWstrore{j} = WC;
    classError{j} = CError;
    
  end %sfinal check number features
  
  w{k} = wClass;
  addW{k} = addWstrore;
  mError{k} = classError;
  
end

disp('END Training Superpixel');
end