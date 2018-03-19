function show_all_histogram(M,imgsize)
n = imgsize(1);
m = imgsize(2);
mkdir RESULTS/HISTOGRAMS
  for i = 1:size(M,2)
      disp(i);
   I = reshape(M(:,i),n,m);
    I = imresize(I, [60, 80]); % mudar aqui
    
    I = uint8(I);
    %subplot(1,1,1),imhist(I1*50);
    
    [counts,binLocations] = imhist(I);
    % counts1 = counts(2:20);
     counts1 = counts(2:4);
   
width = 0.5;
counts1 = counts1./(max(counts1(:)));
B = bar3(counts1,width, 'k');

%%%%Escolha cores aleatorias
% for ii=1:1
%  set(B(ii),'facecolor',rand(1,3));
% end
for ii=1:1
 % set(B(ii),'facecolor',rand(1,3));
  set(B(ii),'facecolor',[0.957597025538810 0.647894229235606 0.172137706097284]);
end

title(['Importance Group Feature - Time ' num2str(i)]);
xlabel('Frames');
ylabel('Features');
zlabel('Importance');
set(gca,'XTickLabel',{'Gray','XCS-LBP','Gradients'});
%set(gca,'XTickLabel',{'Color','Texture','Color+Texture','Gradient','Motion'});
% set(gca,'XTickLabel',{'Gray','Red','Green','Blue','Hue','Saturation','Value','XCS','OCLBPRR',...
% 'OCLBPGG','OCLBPBB','OCLBPRG','OCLBPRB','OCLBPGB', 'GradientX','GradientY','GradientMagnitude','GradientDirection','OpticalOFlow'});
%set(gca,'XTickLabel',{'Gray','XCS-LBP','Gradient','Multispectral'});

    pause(0.01);
    saveas(gcf,['RESULTS/HISTOGRAMS/histogram_' num2str(i) '.png']) %salva histogram
   % clf;
  end
end
