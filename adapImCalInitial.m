function  [wPoolClasP, ePoolAc] = adapImCalInitial(nPool, aPool)
%function  [importance] = adapImCalInitial(nclass)
%initial feature importanc calculation
   
 
for i = 1:size(aPool,2) %10

        wPoolClasP{i} = 1/nPool; %size(newPool,2);
        ePoolAc{i} = aPool{i};
end
end
