function show_2dvideo(M,imgsize,origimgsize)
n = imgsize(1);
m = imgsize(2);
x = origimgsize(1);
y = origimgsize(2);
  mkdir RESULTS/FG
  for i = 1:size(M,2)
    I = reshape(M(:,i),n,m);
    I = imresize(I, [x y]); % mudar aqui
   imshow(I,[],'InitialMagnification','fit');
    disp(i);
    pause(0.01);
    %salva image
  filename = [num2str(i) '.png'];
  
  imwrite(I,strcat('RESULTS/FG/',filename));
  end
end
