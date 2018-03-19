function [FGF] = featureGroupImp(impFeatureTime, sfeatures)

%saber o grupo de features mais utilizada na imagem

% = im2double(zeros(120, 160));

for i = 1:size(sfeatures,2)
    
    for k = 1:size(impFeatureTime,2)
        
        
        X = (sprintf('creating feature image: %d',k));
        disp (X);
        
        greaImportance = cell2mat(impFeatureTime{k}{1,i});
        [g, gi] = max(greaImportance);% g(valor da importancia) e gi (o indice das features)
        groupF = sfeatures{1,1}(gi,:);
        
        for n = 1:size(size(sfeatures{1,1},2))
            
            if groupF(n) == 1  || groupF(n) == 2 || groupF(n) == 3 || groupF(n) == 4 ||  groupF(n) == 5 ||  groupF(n) == 6 ||  groupF(n) == 7
                FG(k) = 1; %GRAY
            end
            
            %XCS-LBP
            if groupF(n) == 8
                FG(k) = 2; %GRAY
            end
            
            
            if groupF(n) == 9  || groupF(n) == 10 || groupF(n) == 11 || groupF(n) == 12 ||  groupF(n) == 13 ||  groupF(n) == 6 ||  groupF(n) == 14
                FG(k) = 3; %GRAY
            end
            
            if groupF(n) == 15  || groupF(n) == 16 || groupF(n) == 17 || groupF(n) == 18
                FG(k) = 4; %GRAY
            end
            
            %OCLBPGG
            if groupF(n) == 19
                FG(k) = 5; %ORANGE
            end  
            
        end
        
    end
    FGF(i,:) = FG;
end
end
