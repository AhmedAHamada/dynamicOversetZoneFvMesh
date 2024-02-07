clc; clear; close all;
ITL=15;
ITU=253;
D=-0.341800004;
NK=49; NI=ITU-ITL+1;
NK_BOW=7;
NK_STERN=30;
DD=D/(NK-1);
PZ=zeros(NI,NK); PY=PZ;
DTHETA = -90/(NK-1);
THETA=linspace(0,-90,NK);
R=2;
delete  ../files/*
delete  ../hullFigures/*
delete  ../hullMesh/*
delete  ../Mesh.mat
m=0;
for i=ITL:ITU
    m=m+1;
    X = readmatrix(['../excel/',num2str(i),'.csv']);
    for j=1:length(X(:,3))
        if abs(X(j,3))<10^-10
            X(j,3)=0;
        end
        if abs(X(j,4))<10^-10
            X(j,4)=0;
        end
    end

    if X(end,3)==X(end-1,3) && X(end,4)==X(end-1,4)
        A = [X(1:end-1,3) X(1:end-1,4)];
    else
        A = [X(:,3) X(:,4)];
    end

    %     if X(end,4)~=D || X(end,3)~=0
    %         XX=[0 D];
    %         AA = [A;XX];
    if X(end,3)~=0
        A(end,1)=0;
        AA=A;
    else
        AA = A;
    end

    if X(1,4)~=0
        XXX=[0 0];
        AAA = [XXX;AA];
    else
        AAA = AA;
    end

    if AAA(1,2)~=0 || AAA(end,1)~=0 %|| AAA(end,2)~=D
        disp(i)
    end

    B=AAA(sum(isnan(AAA),2)==0,:);
    %     if i>85 && i<95
    %         for K=1:NK
    %             P = InterX([B(:,1)';B(:,2)'],[[0,R*cosd(THETA(K))];[0,R*sind(THETA(K))]]);
    %             PY(i+1,K)=P(1);
    %             PZ(i+1,K)=P(2);
    %         end
    %     else
    if i<53
        [PYA, PZA] = rediscretize_curve(B(1:2,1)', B(1:2,2)', NK_BOW);
        [PYB, PZB] = rediscretize_curve(B(2:end,1)', B(2:end,2)', NK-NK_BOW+1);
        PY(i,:)=[PYA(1:NK_BOW-1),PYB];
        PZ(i,:)=[PZA(1:NK_BOW-1),PZB];
    elseif i>=232 && i<=236
        indd=find(B(:,1)==0);
        [PYA, PZA] = rediscretize_curve(B(1:indd(1),1)', B(1:indd(1),2)', NK_STERN);
        [PYB, PZB] = rediscretize_curve(B(indd(1):indd(2),1)', B(indd(1):indd(2),2)', 13);
        [PYC, PZC] = rediscretize_curve(B(indd(2):end,1)', B(indd(2):end,2)', 8);
        PY(i,:)=[PYA(1:NK_STERN-1),PYB(1:12),PYC];
        PZ(i,:)=[PZA(1:NK_STERN-1),PZB(1:12),PZC];
        BB=B;
    elseif i>236 && i<241
        inddd=find(B(:,1)==0);
        [PYA, PZA] = rediscretize_curve(B(1:inddd(1),1)', B(1:inddd(1),2)', NK_STERN);
        [PYB, PZB] = rediscretize_curve([B(inddd(1),1),BB(indd(1):indd(2),1)'], [B(inddd(1),2),BB(indd(1):indd(2),2)'], 13);
        [PYC, PZC] = rediscretize_curve( [0, 0], [BB(indd(2),2),BB(end,2)], 8);
        PY(i,:)=[PYA(1:NK_STERN-1),PYB(1:12),PYC];
        PZ(i,:)=[PZA(1:NK_STERN-1),PZB(1:12),PZC];
    elseif i>=241
        [PYA, PZA] = rediscretize_curve(B(1:2,1)', B(1:2,2)', NK_STERN);
        [PYB, PZB] = rediscretize_curve(B(2:3,1)', B(2:3,2)', 13);
        [PYC, PZC] = rediscretize_curve(B(3:4,1)', B(3:4,2)', 8);
        PY(i,:)=[PYA(1:NK_STERN-1),PYB(1:12),PYC];
        PZ(i,:)=[PZA(1:NK_STERN-1),PZB(1:12),PZC];
    else
        [PY(i,:), PZ(i,:)] = rediscretize_curve(B(:,1)', B(:,2)', NK);
    end
    %     end
%     if i==ITU-1
%         PY(ITU,:)=0;
%         PZ(ITU,:)=PZ(i,:);
%         C=[PY(ITU,:)' PZ(ITU,:)'];
%         writematrix(C,['../hullMesh/',num2str(ITU)],'Delimiter',' ')
%         oldname1=['../hullMesh/',num2str(ITU),'.txt'];
%         newname1=['../hullMesh/',num2str(ITU)];
%         dos(['rename "' oldname1 '" "' newname1 '"']);
%         clear C
%     elseif i==ITU-ITL-1
%         PY(NI,:)=0;
%         PZ(NI,:)=PZ(i+1,:);
%         C=[PY(NI,:)' PZ(NI,:)'];
%         writematrix(C,['../hullMesh/',num2str(ITL)],'Delimiter',' ')
%         oldname1=['../hullMesh/',num2str(ITL),'.txt'];
%         newname1=['../hullMesh/',num2str(ITL)];
%         dos(['rename "' oldname1 '" "' newname1 '"']);
%         clear C
%     end
    C=[PY(i,:)' PZ(i,:)'];
    writematrix(C,['../hullMesh/',num2str(i)],'Delimiter',' ')
    oldname1=['../hullMesh/',num2str(i),'.txt'];
    newname1=['../hullMesh/',num2str(i)];
    dos(['rename "' oldname1 '" "' newname1 '"']);
    clear C
    close all;
    figure(1)
    set(gcf,'Color','w')
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    hold on;
    plot(B(:,1),B(:,2),'k','LineWidth',3)
    plot(PY(i,:),PZ(i,:),'ob','LineWidth',3,'MarkerFaceColor','b')
    hold off;
    grid on;
    axis equal;
    xlabel('$ y $','interpreter','latex','fontsize',26)
    ylabel('$ z $','interpreter','latex','fontsize',26)
    ylim([-0.35 0])
    xlim([0 0.55])
    xticks(0:0.05:0.55)
    xtickangle(45)
    yticks(-0.35:0.025:0)
    title(['$i$ = ',num2str(i)],'interpreter','latex','fontsize',26)
    set(gca,'FontSize',26, 'FontName', 'Times')
    saveas(gcf,['../hullFigures/',num2str(i),'.png'])
    disp('Press a key !')
    %     pause;
    writematrix(AAA,['../files/',num2str(i)],'Delimiter',' ')
    oldname2=['../files/',num2str(i),'.txt'];
    newname2=['../files/',num2str(i)];
    dos(['rename "' oldname2 '" "' newname2 '"']);
    clear X XX XXX A AA AAA oldname newname j i B ans
end
% close all;
save ../Mesh.mat PY PZ