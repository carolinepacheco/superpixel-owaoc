function [A, impFeatureTime] = adapImpTrain(varargin)

label_test = struct([]);
impF = struct([]);
aPool = struct([]);
impFeatureTime  = struct([]);
clabel = struct([]);
disResult  = struct([]);

for k = 1:size(varargin{1},1)
    X = (sprintf('Adaptation features to superpixel: %d',k));
    disp(X);

    %%%%%%COLOR DATA ADPAT
    TestDataGray = varargin{1}(k,:);
    TestDataRed = varargin{2}(k,:);
    TestDataGreen = varargin{3}(k,:);
    TestDataBlue = varargin{4}(k,:);   
    
    %%%%%%TEXTURE DATA ADPAT
    TestDataXCS = varargin{5}(k,:);
  
    %%%%%%GT DATA ADPAT
    dataGT = varargin{6}(k,:);
    dataGT = dataGT';
    
    TestData = [TestDataGray' TestDataRed' TestDataGreen' TestDataBlue' TestDataXCS'];

   for i = 1:size(TestData,1) %verificando o sample individualmente

   for c= 1:size(TestData,2) %check number features/clqssificadores

      TestD = TestData(:, c);
      w0 = varargin{7}{k}{1,c}{1,1};
      outColor = TestD*w0;
      label_test{c} = outColor*labeld;
      disResult{c} = +outColor;
   end %final check number features

   label_target = 0;
   label_outlier = 0;
   label = 0;
   re_label = 0;

for c= 1:size(TestData,2) %check number features/clqssificadores 2

  data = TestData(i,c);
  dataDist = zeros(1, size(data,2));
  distance = disResult{c};

            if distance(i,1) > distance(i,2)
                dataDist(1,1:size(data,2)) = distance(i,1);
                %euclidian distance
                D = pdist2(data,dataDist,'euclidean');

                prob =  exp(-(D)/0.5); %melhor configuracao

                if prob >= 0.95

                    label_outlier = label_outlier + 1;
                    label = 'outlier';
                    re_label = -1;
                else
                    label_target = label_target + 1;
                    label = 'target ';
                    re_label = 1;
                end
            end

            if distance(i,1) < distance(i,2)
                dataDist(1,1:size(data,2)) = distance(i,2);
                D = pdist2(data,dataDist,'euclidean');
                prob =  exp(-(D)/0.5); %melhor configuracao

                if prob >= 0.95
                    label_target = label_target + 1;
                    label = 'target ';
                    re_label = 1;

                else
                    label_outlier = label_outlier + 1;
                    label = 'outlier';
                    re_label = -1;
                end
            end
            [accuracyClassPool] = calc_accuracy(label,dataGT(i));
            aPool{k}{c} = accuracyClassPool; %accuracy calculation each base classifier
            clabel{k}{c} = re_label;

      end

        if (i == 1)
           [impFeature] = adapImCalInitial(size(TestData,2),aPool{k}); 
        end


   THx = 0; 
   strongH = 0;    
   for c= 1:size(TestData,2) %check number features/classificadores

      Hx = impFeature{c}*clabel{k}{c};
      THx = THx + Hx;
   end %final check number features


      %FINAL CLASSIFICATION
      strongH = THx/c;
      if strongH >= 0
          labelC = 'target ';
          label_out(i) = 0;

      else
          labelC = 'outlier';
          label_out(i) = 1;

      end


      [accuracyClas] = calc_accuracy(labelC,dataGT(i));

      %adaptative feature importanc calculation
      [impFeature]= adapImpCal(size(TestData,2), aPool{k}, accuracyClas, impFeature);

      %guarda para cada amostra
      impF{k} = impFeature;
       impFeatureTime{i} = impF;

  end
  clearvars impFeature
  clearvars aPool
  clearvars sPool
  clearvars accuracyPool
  M(k,:) = label_out;
end

%[A] = regionToPixel2(M, varargin{14});%checar essas variavei
[A] = regionToPixel(M, varargin{8});

disp('END Adaptation Features');
end
