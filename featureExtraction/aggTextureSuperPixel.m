function [TrainXCS] = aggTextureSuperPixel(spXCS, method)

% aggregation function

for k = 1:size(spXCS,2)
    
        X = (sprintf('************Texture to frame: %d',k));
        disp(X);
    
    for i = 1:size(spXCS,1)
        
        
        XCS  = spXCS{i,k}; % XCS
       
        switch method
            
            case 'min'
                aggRXCS = min(XCS); %XCS
                
                
            case 'median'
                aggRXCS = nanmedian(XCS); %XCS
                
            case 'geom.mean'
                aggRXCS = nanmedian(XCS); %XCS
               
            case 'mean'
                aggRXCS = nanmedian(XCS); %XCS
               
            case 'stuart'
                aggRXCS = stuart(XCS); %XCS
                
            case 'RRA'
                aggRXCS = rhoScores(XCS); %XCS
               
            case 'max'
                aggRXCS = max(XCS); %XCS
               
            case 'sum'
                aggRXCS = sum(XCS); %XCS
  
                
            case 'entropy'
                aggRXCS = entropy(XCS); %XCS
      
                
            otherwise
                error('Method should be one of:  "min", "geom.mean", "mean", "median", "stuart", "RRA", "max", "sum", or "entropy"');
        end
        
        XCSaggR(i) = aggRXCS; %XCS
        
    end
    XCSaggR = XCSaggR';
    TrainXCS(:,k) = XCSaggR; %XCS
    
   
end
end
