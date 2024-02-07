clc; clear; close all;
ITL=15;
ITU=247;
delete  ../meshPics/fig/*
delete  ../meshPics/png/*
for II=ITL:ITU
fileID = fopen(['../mesh/2D/',num2str(II)],'r');
X = textscan(fileID, '%f %f');
fclose(fileID);
NJ=49; NK=49; PY=zeros(NJ,NK); PZ=PY;
for J=1:NJ
    for K=1:NK
        KK=NK*(J-1)+K; 
        PY(J,K)=X{1}(KK); 
        PZ(J,K)=X{2}(KK); 
    end
end
close all;
figure(1)
set(gcf,'Color','w')
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
hold on;
axis equal;
for j=1:NJ
    plot(PY(j,:),PZ(j,:),'k')
end
for k=1:NK
    plot(PY(:,k),PZ(:,k),'k')
end
xlabel('$ y $','interpreter','latex','fontsize',26)
ylabel('$ z $','interpreter','latex','fontsize',26)
ylim([-0.6 0])
xlim([0 0.6])
title(['$i$ = ',num2str(II)],'interpreter','latex','fontsize',26)
set(gca,'FontSize',26, 'FontName', 'Times')
hold off
% disp('Press a key !')
% pause;
saveas(gcf,['../meshPics/png/',num2str(II),'.png'])
saveas(gcf,['../meshPics/fig/',num2str(II),'.fig'])
end