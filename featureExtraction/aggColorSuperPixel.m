function [TrainGray, TrainRed, TrainGreen, TrainBlue] = aggColorSuperPixel(spGray, spRed, spGreen,...
    spBlue, method)


% aggregation function
for k = 1:size(spGray,2)
    
        X = (sprintf('************Color to frame: %d',k));
        disp(X);
    
    for i = 1:size(spGray,1)
        
        gray  = spGray{i,k}; % gray
        red  = spRed{i,k}; % red
        green  = spGreen{i,k}; % green
        blue  = spBlue{i,k};% blue
        
        switch method
            
            case 'min'
                aggRgray = min(gray); %gray
                aggRred = min(red); %red
                aggRgreen = min(green); %green
                aggRblue = min(blue); %blue
                
            case 'median'
                aggRgray = nanmedian(gray); %gray
                aggRred = nanmedian(red); %red
                aggRgreen = nanmedian(green); %green
                aggRblue = nanmedian(blue); %blue
                
            case 'geom.mean'
                aggRgray = exp(nanmean(gray)); %gray
                aggRred = exp(nanmean(red)); %red
                aggRgreen = exp(nanmean(green)); %green
                aggRblue = exp(nanmean(blue)); %blue
                
            case 'mean'
                aggRgray = nanmean(gray); %gray
                aggRred = nanmean(red); %red
                aggRgreen = nanmean(green); %green
                aggRblue = nanmean(blue); %blue
                
            case 'stuart'
                aggRgray = stuart(gray); %gray
                aggRred = stuart(red); %red
                aggRgreen = stuart(green); %green
                aggRblue = stuart(blue); %blue
                
            case 'RRA'
                aggRgray = rhoScores(gray); %gray
                aggRred = rhoScores(red); %red
                aggRgreen = rhoScores(green); %green
                aggRblue = rhoScores(blue); %blue
              
            case 'max'
                aggRgray = max(gray); %gray
                aggRred = max(red); %red
                aggRgreen = max(green); %green
                aggRblue = max(blue); %blue
              
            case 'sum'
                aggRgray = sum(gray); %gray
                aggRred = sum(red); %red
                aggRgreen = sum(green); %green
                aggRblue = sum(blue); %blue
               
            case 'entropy'
                aggRgray = entropy(gray); %gray
                aggRred = entropy(red); %red
                aggRgreen = entropy(green); %green
                aggRblue = entropy(blue); %blue
                
            otherwise
                error('Method should be one of:  "min", "geom.mean", "mean", "median", "stuart", "RRA", "max", "sum", or "entropy"');
        end

        grayaggR(i) = aggRgray; % gray
        redaggR(i) = aggRred; % red
        greenaggR(i) = aggRgreen; % agreen
        blueaggR(i) = aggRblue; % blue
      
    end
    grayaggR = grayaggR';
    TrainGray(:,k) = grayaggR; %gray
    
    redaggR = redaggR';
    TrainRed(:,k) = redaggR; %red
    
    greenaggR = greenaggR';
    TrainGreen(:,k) = greenaggR; %green
    
    blueaggR = blueaggR';
    TrainBlue(:,k) = blueaggR; %blue
end
end
