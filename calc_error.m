function  [error] = calc_error_new(label_test_hat, GT)
 % quantidade de frame
 
 %0 -  background
 %1 -  foregroubd  

 %i_end = size(GrouthData,2);
 %lambda = 1;
 lambdaWrong = 1;
 lambdaCorrect = 1;


        % se classificou como background
        for i = 1:size(label_test_hat,1)
         name = label_test_hat(i,:); %disp(name);
          if(strcmp(name,'target ') && (GT(i) == 0))
            %label_test_out(i) = 1;
            %acertou
            lambdac = 1;
            lambdaCorrect = lambdaCorrect + lambdac;
           % error = (lambdaWrong)/(lambdaCorrect + lambdaWrong);
            %label_test_out(i) = 0;
          end
          
          if(strcmp(name,'target ') && (GT(i) == 1))
             % ERROU = 1;
              lambdaw = 1;
              lambdaWrong = lambdaWrong + lambdaw;
            %  error = (lambdaWrong) / (lambdaCorrect + lambdaWrong);
             % label_test_out(i) = 0;
          end
          
          % se classificou como foreground
          if (strcmp(name, 'outlier') && (GT(i) ==1))
             %ACERTOU = 1;
             lambdac = 1;
             lambdaCorrect = lambdaCorrect + lambdac;
            % error = (lambdaWrong)/(lambdaCorrect + lambdaWrong);
           %  label_test_out(i) = -1;
          end
               
          if (strcmp(name,'outlier') && (GT(i) == 0))
             %ERROU = 1;
             lambdaw = 1;
             lambdaWrong = lambdaWrong + lambdaw;
            % error = (lambdaWrong) / (lambdaCorrect + lambdaWrong);
            % label_test_out(i) = -1;
          end
       error = (lambdaWrong) / (lambdaCorrect + lambdaWrong);
        end
        

 %X = (1 - error)/error;
 %impClass = 0.5*(log(X));
 
%if (error <= 0.4)
%  if (error <= 0.14)
%      X = (1 - error)/error;
%      vWeight = 0.5*(log(X));
%      
%  end

end
      