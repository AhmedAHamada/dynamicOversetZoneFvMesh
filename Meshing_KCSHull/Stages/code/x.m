clc; clear; close all;
xst=-2; xend=2.5; 
xi=0.0775812; xf=-7.50009; 
l=xi-xf; 
N=225-33+1; 
xd=linspace(xi,xf,N);
Ad=[ 190 -7.40142240625   ;
    191 -7.421155925     ;
    192 -7.431022684375  ;
    193 -7.44088944375   ;
    194 -7.450756203125  ;
    195 -7.4606229625    ;
    196 -7.4655563421875 ;
    197 -7.470489721875  ;
    198 -7.4754231015625 ;
    199 -7.48035648125   ;
    200 -7.4852898609375 ;
    201 -7.490223240625  ;
    202 -7.49268993046875;
    203 -7.4951566203125 ;
    204 -7.49762331015625;
    205 -7.49885665507813;
    206 -7.50009          ];
Ad(:,1)=Ad(:,1)+33;
NN=1:1:303;
xpt=flip(([xd(1:end-3),Ad(:,2)']-xf)/l-0.5);
clear Ad N xd
xx=zeros(size(NN));
xx(33:239)=xpt;
ds_front=xpt(2)-xpt(1);
R1=1533.52187912659;
N1=32;
r1=R1^(1/(N1-1));
xx(N1)=xpt(1)-(ds_front*r1);
for i=2:N1
    xx(N1-(i-1))=xx(N1-(i-1)+1)-(abs(xx(N1-(i-1)+1)-xx(N1-(i-1)+2))*r1);
end
xx(1)=-2;
ds_rear=xpt(end)-xpt(end-1);
R2=17.145;
N2=64;
r2=R2^(1/(N2-1));
xx(240)=xpt(end)+(ds_rear*r2);
for i=241:303
    xx(i)=xx(i-1)+((xx(i-1)-xx(i-2))*r2);
end
xx(303)=2.5;
xx=xx'*l;
writematrix(xx,'../mesh/3D/xx','Delimiter',' ')
oldname1='../mesh/3D/xx.txt';
newname1='../mesh/3D/xx';
dos(['rename "' oldname1 '" "' newname1 '"']);