function [TrainOCLBPRR, TrainOCLBPGG, TrainOCLBPBB, TrainOCLBPRG, TrainOCLBPRB, ...
    TrainOCLBPGB] = aggColorTextureSuperPixel(spOCLBPRR, spOCLBPGG, spOCLBPBB,...
    spOCLBPRG, spOCLBPRB, spOCLBPGB, method)

% aggregation function

for k = 1:size(spOCLBPRR,2)
    
        X = (sprintf('************Color+Texture to frame: %d',k));
        disp(X);
    
    for i = 1:size(spOCLBPRR,1)
        
        OCLBPRR = spOCLBPRR{i,k};  % OCLBPRR
        OCLBPGG  = spOCLBPGG{i,k}; % OCLBPGG 
        OCLBPBB  = spOCLBPBB{i,k}; % OCLBPBB
        OCLBPRG  = spOCLBPRG{i,k}; % OCLBPRG
        OCLBPRB  = spOCLBPRB{i,k}; % OCLBPRB
        OCLBPGB  = spOCLBPGB{i,k}; % OCLBPGB
        
        switch method
            
            case 'min'
                aggROCLBPRR = min(OCLBPRR); %OCLBPRR
                aggROCLBPGG = min(OCLBPGG); %OOCLBPGG
                aggROCLBPBB = min(OCLBPBB); %OCLBPBB
                aggROCLBPRG = min(OCLBPRG); %OCLBPRG
                aggROCLBPRB = min(OCLBPRB); %OCLBPRB
                aggROCLBPGB = min(OCLBPGB); %OCLBPGB
                
            case 'median'
                aggROCLBPRR = nanmedian(OCLBPRR); %OCLBPRR
                aggROCLBPGG = nanmedian(OCLBPGG); %OOCLBPGG
                aggROCLBPBB = nanmedian(OCLBPBB); %OCLBPBB
                aggROCLBPRG = nanmedian(OCLBPRG); %OCLBPRG
                aggROCLBPRB = nanmedian(OCLBPRB); %OCLBPRB
                aggROCLBPGB = nanmedian(OCLBPGB); %OCLBPGB
                
            case 'geom.mean'
                aggROCLBPRR = exp(nanmean(OCLBPRR)); %OCLBPRR
                aggROCLBPGG = exp(nanmean(OCLBPGG)); %OOCLBPGG
                aggROCLBPBB = exp(nanmean(OCLBPBB)); %OCLBPBB
                aggROCLBPRG = exp(nanmean(OCLBPRG)); %OCLBPRG
                aggROCLBPRB = exp(nanmean(OCLBPRB)); %OCLBPRB
                aggROCLBPGB = exp(nanmean(OCLBPGB)); %OCLBPGB
                
            case 'mean'
                aggROCLBPRR = nanmean(OCLBPRR); %OCLBPRR
                aggROCLBPGG = nanmean(OCLBPGG); %OOCLBPGG
                aggROCLBPBB = nanmean(OCLBPBB); %OCLBPBB
                aggROCLBPRG = nanmean(OCLBPRG); %OCLBPRG
                aggROCLBPRB = nanmean(OCLBPRB); %OCLBPRB
                aggROCLBPGB = nanmean(OCLBPGB); %OCLBPGB
                
            case 'stuart'
                aggROCLBPRR = stuart(OCLBPRR); %OCLBPRR
                aggROCLBPGG = stuart(OCLBPGG); %OOCLBPGG
                aggROCLBPBB = stuart(OCLBPBB); %OCLBPBB
                aggROCLBPRG = stuart(OCLBPRG); %OCLBPRG
                aggROCLBPRB = stuart(OCLBPRB); %OCLBPRB
                aggROCLBPGB = stuart(OCLBPGB); %OCLBPGB
                
            case 'RRA'
                aggROCLBPRR = rhoScores(OCLBPRR); %OCLBPRR
                aggROCLBPGG = rhoScores(OCLBPGG); %OOCLBPGG
                aggROCLBPBB = rhoScores(OCLBPBB); %OCLBPBB
                aggROCLBPRG = rhoScores(OCLBPRG); %OCLBPRG
                aggROCLBPRB = rhoScores(OCLBPRB); %OCLBPRB
                aggROCLBPGB = rhoScores(OCLBPGB); %OCLBPGB
                
            case 'max'
                aggROCLBPRR = max(OCLBPRR); %OCLBPRR
                aggROCLBPGG = max(OCLBPGG); %OOCLBPGG
                aggROCLBPBB = max(OCLBPBB); %OCLBPBB
                aggROCLBPRG = max(OCLBPRG); %OCLBPRG
                aggROCLBPRB = max(OCLBPRB); %OCLBPRB
                aggROCLBPGB = max(OCLBPGB); %OCLBPGB
                
            case 'sum'
                aggROCLBPRR = sum(OCLBPRR); %OCLBPRR
                aggROCLBPGG = sum(OCLBPGG); %OOCLBPGG
                aggROCLBPBB = sum(OCLBPBB); %OCLBPBB
                aggROCLBPRG = sum(OCLBPRG); %OCLBPRG
                aggROCLBPRB = sum(OCLBPRB); %OCLBPRB
                aggROCLBPGB = sum(OCLBPGB); %OCLBPGB
                
            case 'entropy'
                aggROCLBPRR = entropy(OCLBPRR); %OCLBPRR
                aggROCLBPGG = entropy(OCLBPGG); %OCLBPGG
                aggROCLBPBB = entropy(OCLBPBB); %OCLBPBB
                aggROCLBPRG = entropy(OCLBPRG); %OCLBPRG
                aggROCLBPRB = entropy(OCLBPRB); %OCLBPRB
                aggROCLBPGB = entropy(OCLBPGB); %OCLBPGB
                
            otherwise
                error('Method should be one of:  "min", "geom.mean", "mean", "median", "stuart", "RRA", "max", "sum", or "entropy"');
        end
        
        OCLBPRRaggR(i) = aggROCLBPRR; %OCLBPRR
        OCLBPGGaggR(i) = aggROCLBPGG; %OCLBPGG
        OCLBPBBaggR(i) = aggROCLBPBB; %OCLBPBB
        OCLBPRGaggR(i) = aggROCLBPRG; %OCLBPRG
        OCLBPRBaggR(i) = aggROCLBPRB; %OCLBPRB
        OCLBPGBaggR(i) = aggROCLBPGB; %OCLBPGB
        
    end
    
    OCLBPRRaggR = OCLBPRRaggR';
    TrainOCLBPRR(:,k) = OCLBPRRaggR; %OCLBPRR
    
    OCLBPGGaggR = OCLBPGGaggR';
    TrainOCLBPGG(:,k) = OCLBPGGaggR; %OCLBPGG
    
    OCLBPBBaggR = OCLBPBBaggR';
    TrainOCLBPBB(:,k) = OCLBPBBaggR; %OCLBPBB
    
    OCLBPRGaggR = OCLBPRGaggR';
    TrainOCLBPRG(:,k) = OCLBPRGaggR; %OCLBPRG
    
    OCLBPRBaggR = OCLBPRBaggR';
    TrainOCLBPRB(:,k) = OCLBPRBaggR; %OCLBPRB
    
    OCLBPGBaggR = OCLBPGBaggR';
    TrainOCLBPGB(:,k) = OCLBPGBaggR; %OCLBPGB
    
end
end
