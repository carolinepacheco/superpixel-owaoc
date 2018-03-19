function [TrainGT] = aggGTSuperPixel(spGtVal)

% aggregation function

for k = 1:size(spGtVal,2)
    
        X = (sprintf('************GT to frame: %d',k));
        disp(X);
    
    for i = 1:size(spGtVal,1)
      
        % GT
        GT  = spGtVal{i,k};
        %GT = real(GT);
        aggRGT = max(GT);  %GT
       
        GTaggR(i) = aggRGT; % aggregation function
    end
    GTaggR = GTaggR';
    TrainGT(:,k) = GTaggR;  % GT
end
end
