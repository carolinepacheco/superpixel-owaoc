function [TrainGx, TrainGy, TrainGmag, TrainGdir] = aggEdgeSuperPixel(spGx, spGy,...
    spGmag, spGdir, method)

% aggregation function

for k = 1:size(spGx,2)
    
        X = (sprintf('************Edge to frame: %d',k));
        disp(X);
    
    for i = 1:size(spGx,1)
        
        Gx  = spGx{i,k}; %Gx
        Gy = spGy{i,k};  %Gy
        Gmag  = spGmag{i,k}; %Gmag
        Gdir  = spGdir{i,k}; % Gdir
        
        switch method
            
            case 'min'
                aggRGx = min(Gx);     %Gx
                aggRGy = min(Gy);     %Gy
                aggRGmag = min(Gmag); %Gmag
                aggRGdir = min(Gdir); %Gdir
                
            case 'median'
                aggRGx = nanmedian(Gx);     %Gx
                aggRGy = nanmedian(Gy);     %Gy
                aggRGmag = nanmedian(Gmag); %Gmag
                aggRGdir = nanmedian(Gdir); %Gdir
                
            case 'geom.mean'
                aggRGx = exp(nanmean(Gx));     %Gx
                aggRGy = exp(nanmean(Gy));     %Gy
                aggRGmag =exp(nanmean(Gmag)); %Gmag
                aggRGdir = exp(nanmean(Gdir)); %Gdir
                
            case 'mean'
                aggRGx = nanmedian(Gx);     %Gx
                aggRGy = nanmedian(Gy);     %Gy
                aggRGmag =nanmedian(Gmag); %Gmag
                aggRGdir = nanmedian(Gdir); %Gdir
                
            case 'stuart'
                aggRGx = stuart(Gx);     %Gx
                aggRGy = stuart(Gy);     %Gy
                aggRGmag =stuart(Gmag); %Gmag
                aggRGdir = stuart(Gdir); %Gdir
                
            case 'RRA'
                aggRGx = rhoScores(Gx);     %Gx
                aggRGy = rhoScores(Gy);     %Gy
                aggRGmag =rhoScores(Gmag); %Gmag
                aggRGdir = rhoScores(Gdir); %Gdir
                
            case 'max'
                aggRGx = max(Gx);     %Gx
                aggRGy = max(Gy);     %Gy
                aggRGmag =max(Gmag); %Gmag
                aggRGdir = max(Gdir); %Gdir
                
            case 'sum'
                aggRGx = sum(Gx);     %Gx
                aggRGy = sum(Gy);     %Gy
                aggRGmag =sum(Gmag); %Gmag
                aggRGdir = sum(Gdir); %Gdir
                
            case 'entropy'
                aggRGx = entropy(Gx);     %Gx
                aggRGy = entropy(Gy);     %Gy
                aggRGmag =entropy(Gmag);  %Gmag
                aggRGdir = entropy(Gdir); %Gdir
                
            otherwise
                error('Method should be one of:  "min", "geom.mean", "mean", "median", "stuart", "RRA", "max", "sum", or "entropy"');
        end
      
        GxaggR(i) = aggRGx; %Gx
        GyaggR(i) = aggRGy; %Gy
        GmagaggR(i) = aggRGmag; %Gmag
        GdiraggR(i) = aggRGdir; %Gdir
        
    end
    GxaggR = GxaggR';
    TrainGx(:,k) = GxaggR; %Gx
    
    GyaggR = GyaggR';
    TrainGy(:,k) = GyaggR; %Gy
    
    GmagaggR = GmagaggR';
    TrainGmag(:,k) = GmagaggR; %Gmag
    
    GdiraggR = GdiraggR';
    TrainGdir(:,k) = GdiraggR; %Gdir
    
end
end
