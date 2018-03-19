function [TrainGray, TrainRed] = aggColorSuperPixel(spGray, spRed, spGreen, spBlue, spHue,spSaturation, spValue)

% aggregation function

for k = 1:size(dataSP,2)
    for i = 1:size(dataSP,1)
       % gray
        gray  = spGray{i,k};
        graymax = max(gray);
        grayaggR(i) = graymax; % aggregation function
        
        % red
        red  = spRed{i,k};
        redmax = max(red);
        redaggR(i) = redmax; % aggregation function
        
    end
    grayaggR = grayaggR';
    TrainGray(:,k) = grayaggR;
    
    redaggR = redaggR';
    TrainRed(:,k) = redaggR;
    
end
end
