function [TrainMS1, TrainMS2, TrainMS3, TrainMS4, TrainMS5, TrainMS6, TrainMS7] = aggMultiSuperPixel(spMS1, spMS2, spMS3, spMS4, spMS5, spMS6, spMS7, method)
  
% function [TrainGray, TrainRed, TrainGreen, TrainBlue, TrainHue, TrainSaturation, TrainValue] = aggColorSuperPixel(spGray, spRed, spGreen,...
%     spBlue, spHue,spSaturation, spValue, method)


% aggregation function
for k = 1:size(spMS1,2)
    
        X = (sprintf('************Multispectral to frame: %d',k));
        disp(X);
    
    for i = 1:size(spMS1,1)
        
        ms1  = spMS1{i,k}; % MS1
        ms2  = spMS2{i,k}; % MS2
        ms3  = spMS3{i,k};% MS3
        ms4  = spMS4{i,k}; % MS4
        ms5  = spMS5{i,k}; % MS5
        ms6  = spMS6{i,k};% MS6
        ms7  = spMS7{i,k};% MS7

        
        switch method
            
        case 'min'
        aggRMS1 = min(ms1); %MS1
        aggRMS2 = min(ms2); %MS2
        aggRMS3 = min(ms3); %MS3
        aggRMS4 = min(ms4); %MS4
        aggRMS5 = min(ms5); %MS5
        aggRMS6 = min(ms6); %MS6
        aggRMS7 = min(ms7); %MS7
                
        case 'median'
        aggRMS1 = nanmedian(ms1); %MS1
        aggRMS2 = nanmedian(ms2); %MS2
        aggRMS3 = nanmedian(ms3); %MS3
        aggRMS4 = nanmedian(ms4); %MS4
        aggRMS5 = nanmedian(ms5); %MS5
        aggRMS6 = nanmedian(ms6); %MS6
        aggRMS7 = nanmedian(ms7); %MS7
   
                
        case 'geom.mean'
        aggRMS1 = exp(nanmean(ms1)); %MS1
        aggRMS2 = exp(nanmean(ms2)); %MS2
        aggRMS3 = exp(nanmean(ms3)); %MS3
        aggRMS4 = exp(nanmean(ms4)); %MS4
        aggRMS5 = exp(nanmean(ms5)); %MS5
        aggRMS6 = exp(nanmean(ms6)); %MS6
        aggRMS7 = exp(nanmean(ms7)); %MS7
                
        case 'mean'
        aggRMS1 = nanmean(ms1); %MS1
        aggRMS2 = nanmean(ms2); %MS2
        aggRMS3 = nanmean(ms3); %MS3
        aggRMS4 = nanmean(ms4); %MS4
        aggRMS5 = nanmean(ms5); %MS5
        aggRMS6 = nanmean(ms6); %MS6
        aggRMS7 = nanmean(ms7); %MS7
 
       case 'stuart'
        aggRMS1 = stuart(ms1); %MS1
        aggRMS2 = stuart(ms2); %MS2
        aggRMS3 = stuart(ms3); %MS3
        aggRMS4 = stuart(ms4); %MS4
        aggRMS5 = stuart(ms5); %MS5
        aggRMS6 = stuart(ms6); %MS6
        aggRMS7 = stuart(ms7); %MS7
                
        case 'RRA'
        aggRMS1 = rhoScores(ms1); %MS1
        aggRMS2 = rhoScores(ms2); %MS2
        aggRMS3 = rhoScores(ms3); %MS3
        aggRMS4 = rhoScores(ms4); %MS4
        aggRMS5 = rhoScores(ms5); %MS5
        aggRMS6 = rhoScores(ms6); %MS6
        aggRMS7 = rhoScores(ms7); %MS7
                
        case 'max'
        aggRMS1 = max(ms1); %MS1
        aggRMS2 = max(ms2); %MS2
        aggRMS3 = max(ms3); %MS3
        aggRMS4 = max(ms4); %MS4
        aggRMS5 = max(ms5); %MS5
        aggRMS6 = max(ms6); %MS6
        aggRMS7 = max(ms7); %MS7
              
        case 'sum'
        aggRMS1 = sum(ms1); %MS1
        aggRMS2 = sum(ms2); %MS2
        aggRMS3 = sum(ms3); %MS3
        aggRMS4 = sum(ms4); %MS4
        aggRMS5 = sum(ms5); %MS5
        aggRMS6 = sum(ms6); %MS6
        aggRMS7 = sum(ms7); %MS7
                
        case 'entropy'
        aggRMS1 = entropy(ms1); %MS1
        aggRMS2 = entropy(ms2); %MS2
        aggRMS3 = entropy(ms3); %MS3
        aggRMS4 = entropy(ms4); %MS4
        aggRMS5 = entropy(ms5); %MS5
        aggRMS6 = entropy(ms6); %MS6
        aggRMS7 = entropy(ms7); %MS7
            otherwise
                error('Method should be one of:  "min", "geom.mean", "mean", "median", "stuart", "RRA", "max", "sum", or "entropy"');
        end

        MS1aggR(i) = aggRMS1; %MS1 
        MS2aggR(i) = aggRMS2; %MS2 
        MS3aggR(i) = aggRMS3; %MS3 
        MS4aggR(i) = aggRMS4; %MS4 
        MS5aggR(i) = aggRMS5; %MS5 
        MS6aggR(i) = aggRMS6; %MS6 
        MS7aggR(i) = aggRMS7; %MS7 
 
    end
    MS1aggR = MS1aggR';
    TrainMS1(:,k) = MS1aggR; %MS1
    MS2aggR = MS2aggR';
    TrainMS2(:,k) = MS2aggR; %MS2
    MS3aggR = MS3aggR';
    TrainMS3(:,k) = MS3aggR; %MS3
    MS4aggR = MS4aggR';
    TrainMS4(:,k) = MS4aggR; %MS4
    MS5aggR = MS5aggR';
    TrainMS5(:,k) = MS5aggR; %MS5
    MS6aggR = MS6aggR';
    TrainMS6(:,k) = MS6aggR; %MS6 
    MS7aggR = MS7aggR';
    TrainMS7(:,k) = MS7aggR; %MS7   
end
end
