function [E,importancetE] = pruningEnsemble(w,impFeatureTime)

%%% PRUNING ENSEMBLE

importancetE = struct([]);
E = struct([]);

lastimportance=  impFeatureTime{1, size(impFeatureTime,2)};

for i=1:size(lastimportance,2)

 greaImportance =  cell2mat(lastimportance{1, i});
 %[g, gi] = max(greaImportance);

 for k=1:size(greaImportance,2)  %quantidade de classificadores

   w0 = w{1,i}{1,k}{1,1};
   if  (greaImportance(k) >= 0.6)
      E{i}{k} = w0; 
      importancetE{i}{k} =  greaImportance(k);
   else
      E{i}{k} = [];
      importancetE{i}{k}= [];
   end 

 end

 % all classifiers have greater importance than <= 0.6
 % therefore I select the one with better importance
 tf = find(~cellfun(@isempty,E{i}), 1); 
 checkVector = isempty(tf);

 if checkVector == 1
   [g, gi] = max(greaImportance);
    w0 = w{1,i}{1,gi}{1,1};
    E{i}{gi} = w0;
    importancetE{i}{gi} = g;

 end 
end

disp('END Pruning Ensemble');
end