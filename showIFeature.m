function showIFeature(AD, rimage, kfeatures)
%%
% load('full_data.mat','impFeatureTime','labels','numlabels','rimage','sfeatures');
% FI FG
% {'Color','Texture','Color+Texture','Gradient','Motion'}
%{
% cor automatica
fc = zeros(5,3);
for i = 1:5
  fc(i,:) = rand(1,3);
end
%}
% cor manual
mkdir RESULTS/FEATURESMAPS
fc = zeros(3,3);

fc(1,:) = [1 0 0]; %color %red color
fc(2,:) = [0 0 1]; %texture  %blue color
fc(3,:) = [1 0 1]; %edge  %magente color

% fc(1,:) = [1 0 0]; %color %red color
% fc(2,:) = [0 1 0]; %texture %green coloror
% fc(3,:) = [0 0 1]; %color-texture  %blue color
% fc(4,:) = [1 0 1]; %gradient %magenta color
% fc(5,:) = [1 1 0]; %ultispectral  %yellow color

%% visualizacao das cores
x = 0:pi/100:2*pi;
clf;plot(x,sin(x),'Color',fc(1,:),'LineWidth',2);hold on;
plot(x,sin(x-.25),'Color',fc(2,:),'LineWidth',2);
plot(x,sin(x-.5),'Color',fc(3,:),'LineWidth',2);
% plot(x,sin(x-.75),'Color',fc(4,:),'LineWidth',2);
% plot(x,sin(x-1.0),'Color',fc(5,:),'LineWidth',2);hold off;
%% construcao do mapa de cor
% imshow(rimage);
clc;
mask = zeros(size(rimage,1)*size(rimage,2),3);

for i = 1:kfeatures
     k = find(AD == i);
   %  g = FG(i);
 for j = 1:length(k)
    mask(k(j),:) = fc(i,:);
    %break;
  end
  %break;
end
 
%% plot
% img_mask = reshape(mask,size(rimage,1),size(rimage,2),3);
% subplot(1,3,1),imshow(rimage);
% subplot(1,3,2),imshow(img_mask);
% subplot(1,3,3),imshow(rimage.*uint8(img_mask));

img_mask = reshape(mask,size(rimage,1),size(rimage,2),3);
subplot(1,2,1),imshow(rimage);
subplot(1,2,2),imshow(img_mask);

%saveas(gca, 'RESULTS/FEATURESMAPS/test.eps','eps');
imwrite(rimage,'RESULTS/FEATURESMAPS/originalimage.png');
imwrite(img_mask,'RESULTS/FEATURESMAPS/mapimage.png');
end