function [F] = foregroundDetection(varargin)
 
for k = 1:size(varargin{1},1)
 label_target = 0;
 label_outlier = 0;
 re_label = 0;
 e = 0;

    X = (sprintf('Detecting foreground to superpixel: %d',k));
    disp(X);

    %%%%%%COLOR DATA TEST
    TestDataGray = varargin{1}(k,:);
    TestDataRed = varargin{2}(k,:);
    TestDataGreen = varargin{3}(k,:);
    TestDataBlue = varargin{4}(k,:);
    
    %%%%%%TEXTURE DATA TEST
    TestDataXCS = varargin{5}(k,:);
  
    %%%%%%INPORTANCE FEATURE VALUES
    impFeature =  varargin{6}{1, k};

    TestData = [TestDataGray' TestDataRed' TestDataGreen' TestDataBlue' TestDataXCS'];

    t_begin = 1;
    t_end = 5;
    time = 1;
    for i = 1:size(TestData,1) %verificando a sample individualmente

    for c= 1:size(TestData,2) %check numberfeatures/classifiers

    checkClassifier = isempty(varargin{7}{k}{c});
    %checkClassifier = isempty(W1{c});

    if checkClassifier == 0
    TestD = TestData(:, c);
    w0 = varargin{7}{k}{c};
    %w0 = W1{c};

    outColor = TestD*w0;
    %label_test{c} = outColor*labeld;
    disResult{c} = +outColor;
    end
    end %final check number features


    for c= 1:size(TestData,2) %check number features/classifier

    checkClassifier = isempty(varargin{7}{k}{c});

    if checkClassifier == 0  % classifier diferente de vazio

    e = e + 1;
    data = TestData(i,c);
    dataDist = zeros(1, size(data,2));
    distance = disResult{c};

      if distance(i,1) > distance(i,2)
          dataDist(1,1:size(data,2)) = distance(i,1);
          %euclidian distance
          D = pdist2(data,dataDist,'euclidean');

          prob =  0.5*exp(-(D)/0.5); %melhor configuracao
         % prob =  exp(-(D)/0.5); %melhor configuracao
         % prob =  0.5*exp(-(D)/0.5);
        % prob =  0.9*exp(-(D)/0.5)
       % prob =  0.3*exp(-(D)/0.5)
    %prob >= 0.95
    %%0.5
    %0.7 horrivel 0.3 0.1
          if prob >= 0.9

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
          prob =  0.5*exp(-(D)/0.5); %melhor configuracao

          if prob >= 0.9
              label_target = label_target + 1;
              label = 'target ';
              re_label = 1;

          else
              label_outlier = label_outlier + 1;
              label = 'outlier';
              re_label = -1;
          end
      end
      clabel{k}{c} = re_label;
    else
     clabel{k}{c} = [];
    end

    end
    lab_target(i) = label_target; %GUARDA A QUANTIDADE DE TARGET
    lab_outlier(i) = label_outlier; %GUARDA A QUANTIDADE DE OUTLIER
    C(k) = e; %GUARDA QUANTIDADE DE CLASSIFICADORES PARA CADA PIXEL


    THx = 0; 
    strongH = 0;  


    for c= 1:size(TestData,2) %check number features/classificadores


    checkClassifier = isempty(varargin{7}{k}{c});

    if checkClassifier == 0  % classifier diferente de vazio

    Hx = cell2mat(impFeature(c))*clabel{k}{c};
    THx = THx + Hx;
    end
    end %final check number features


    %FINAL CLASSIFICATION
    strongH = THx/c;
    % if strongH >= 0
    % strongH >= 0.5 N FUNCIONQ
    % strongH >= 0.2 N FUNCIONQ
    if strongH >= 0
    labelC = 'target ';
    label_out(i) = 0;

    else
    labelC = 'outlier';
    label_out(i) = 1;

    end

    % ATULIZAR OS MODELOS BACKGROUND

    if lab_target(i) > lab_outlier(i) %GUARDAR AS MARGENS AS POSI?OES DO FRAME PARA DEPOIS ENCONTAR A FEATURE
    valueM = [lab_target(i) lab_outlier(i)]; %to calculate the margin
    [G, I] = max(valueM);
    if I == 1
        marginTO = (lab_target(i) - lab_outlier(i))/C(k);
    else
        marginTO = (lab_outlier(i) - lab_target(i))/C(k);
    end
    B(1,i)=i; %frame index
    B(2,i)= marginTO; %margin each frame
    end 


    if (time == 1180)
    BB = zeros(2,5);
    BB(1,:) = B(1,t_begin:t_end);
    BB(2,:) = B(2,t_begin:t_end);
    [Y,I]=sort(BB(2,:)); %organiza do menor para o maior
    dataIndex = I(1:5); % pega a posicao do farme que teve menores margins

    checkClassifier = isempty(varargin{7}{k}{c});
    if checkClassifier == 0

       for t = 1:size(dataIndex,2)
            TestDM = TestData(:, c); %verificar como adicionar for frame
            TestM = TestDM(dataIndex(t),:);
            pdwc = (poissrnd(5,size(TestData,1),1));
            dwc = (pdwc - min(pdwc))/(max(pdwc) - min(pdwc));
            update = inc_add(varargin{8}{k}{1,c}{1,1},+TestM,+1,dwc(1));
            storeUpdate = inc_store(update);
            varargin{7}{k}{c} =  storeUpdate;

        end
     end 


    time = 0;
    cont = 30;
    t_begin = t_begin + cont;
    t_end = t_end + cont;
    end
    time = time + 1;
    end
    F1(k,:) = label_out;
    end
    [F] = regionToPixel(F1, varargin{9});
    
     disp('END Detecting Foreground');
    end