function [FGF] = impFeatures(impFeatureTime, labels)


for i = 1:size(impFeatureTime{1},2) % quantidade de regioes
  
for k = 1:size(impFeatureTime,2) % quantidade de imagens


    X = (sprintf('Creating feature image: %d',k));
    disp (X);

  greaImportance = cell2mat(impFeatureTime{k}{1,i});
  [g, gi] = max(greaImportance);% g(valor da importancia) e gi (o indice das features)
  %groupF = sfeatures{1,1}(gi,:);

  if gi  == 1
      FG(k) = 1; %Gray
  end

  if gi  == 2
      FG(k) = 2; %XCS-LBP
  end  

    if gi  == 3
      FG(k) = 3; %MULTISPECTRAL
    end 

    if gi  == 4
      FG(k) = 3; %MULTISPECTRAL
    end 

    if gi  == 5
      FG(k) = 3; %MULTISPECTRAL
    end 

     if gi  == 6
      FG(k) = 3; %MULTISPECTRAL
     end 

      if gi  == 7
      FG(k) = 3; %MULTISPECTRAL
      end
      
      if gi  == 8
      FG(k) = 3; %MULTISPECTRAL
      end
      
      if gi  == 9
      FG(k) = 3; %MULTISPECTRAL
      end


end
FGA(i,:) = FG;
end
[FGF] = regionToPixel(FGA, labels);
end