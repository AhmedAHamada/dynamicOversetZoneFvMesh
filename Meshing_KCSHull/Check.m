clc; clear; close all;
fileID = fopen('CHECK','r');
X = textscan(fileID, '%f %f');
fclose(fileID);
II=15;
NJ=49; NK=49; PY=zeros(NJ,NK); PZ=PY;
for J=1:NJ
    for K=1:NK
        KK=NK*(J-1)+K; 
        PY(J,K)=X{1}(KK); 
        PZ(J,K)=X{2}(KK); 
    end
end
figure(1)
axis equal
hold on;
for j=1:NJ
    plot(PY(j,:),PZ(j,:),'k')
end
for k=1:NK
    plot(PY(:,k),PZ(:,k),'k')
end
hold off
saveas(gcf,['figmesh_STAGE_',num2str(II),'.png'])
saveas(gcf,['figmesh_STAGE_',num2str(II),'.fig'])