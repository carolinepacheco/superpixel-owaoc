function [A] = regionToPixel(M, labels)
rlabels = labels(:);
numlab = max(rlabels);
%numlab =1543;
A= zeros(size(rlabels,1),1);

for k = 1:size(M,2)
  
  for t=0:numlab
    
    isfind = find(rlabels == t);
    
  %  isfind3 = find(A1 == 30);
    
     A(isfind,k) = M(t+1,k);
     
  end
  
end
end