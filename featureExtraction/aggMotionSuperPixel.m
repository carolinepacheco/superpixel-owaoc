function [TrainOFlow] = aggMotionSuperPixel(spOpFlow, method)

% aggregation function

for k = 1:size(spOpFlow,2)
    
        X = (sprintf('************Motion to frame: %d',k));
        disp(X);
    
    for i = 1:size(spOpFlow,1)
        
        OpFlow  = spOpFlow{i,k}; % Optical Flow
        OpFlow = real(OpFlow);
       
        switch method
            
            case 'min'
                aggROpFlow = min(OpFlow); %OpFlow
                
            case 'median'
                aggROpFlow = nanmedian(OpFlow); %OpFlow
                
            case 'geom.mean'
                aggROpFlow = exp(nanmean(OpFlow));  %OpFlow
                
            case 'mean'
                aggROpFlow = nanmedian(OpFlow); %OpFlow
                
            case 'stuart'
                aggROpFlow = stuart(OpFlow); %OpFlow
                
            case 'RRA'
                aggROpFlow = rhoScores(OpFlow); %OpFlow
                
            case 'max'
                aggROpFlow = max(OpFlow);  %OpFlow
                
            case 'sum'
                aggROpFlow = sum(OpFlow); %OpFlow
                
            case 'entropy'
                aggROpFlow = entropy(OpFlow); %OpFlow
                
            otherwise
                error('Method should be one of:  "min", "geom.mean", "mean", "median", "stuart", "RRA", "max", "sum", or "entropy"');
        end
       
        OpFlowaggR(i) = aggROpFlow; %OpFlow
    end
    OpFlowaggR = OpFlowaggR';
    TrainOFlow(:,k) = OpFlowaggR;  % Optical Flow
end
end
