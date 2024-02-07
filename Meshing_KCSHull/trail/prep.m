clc; clear; close all;
X = readmatrix('Rear.csv');
NK=49;
II=180;
D = 0.3418;
DD=-D/(NK-1);
PZ=zeros(1,NK); PY=PZ;
theta=zeros(1,NK);
if -1*X(1,3)<0
    X(1,3)=0;
end
xx=[-1*X(1,3),-1*X(:,3)',0,0]; yy=[0,X(:,4)',X(end,4),-2*D];
DTHETA = -90/(NK-1);
for K=1:NK
    theta(K)=DTHETA * (K-1);
    P = InterX([xx;yy],[[0,2*cosd(theta(K))];[0,2*sind(theta(K))]]);
 %    P = InterX([xx;yy],[[0,10];DD*(K-1)*ones(1,2)]);
    PY(1,K)=P(1);
    PZ(1,K)=P(2);
end

% for K=2:NK-1
%     if PY(1,K+1)>0 && PY(1,K-1)==0
%         PZ(1,K)=X(1,4);
%         PZ(1,K-2)=(PZ(1,K-1)+PZ(1,K-3))/2;
%         P = InterX([xx;yy],[[PY(1,K),PY(1,K)];[-0.2 1]]);
%         PZ(1,K)=P(2);
%     elseif PY(1,K+1)==0 && PY(1,K-1)>0
%         PZ(1,K)=X(end,4);
%         PZ(1,K+1)=(PZ(1,K)+PZ(1,K+2))/2;
%         P = InterX([xx;yy],[[PY(1,K),PY(1,K)];[-1.2 -0.2]]);
%         PZ(1,K)=P(2);
%     end
% end
fileID = fopen(['STAGE_',num2str(II),'_1.txt'],'w');
fprintf(fileID,'%12.8f\n',PY');
fclose(fileID);

fileID = fopen(['STAGE_',num2str(II),'_2.txt'],'w');
fprintf(fileID,'%12.8f\n',PZ');
fclose(fileID);

plot(PY,PZ,'-ok')
hold on; plot(-1*X(:,3)',X(:,4)','r')