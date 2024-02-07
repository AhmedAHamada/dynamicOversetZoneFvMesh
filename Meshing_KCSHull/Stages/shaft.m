clc; clear; close all;
load('shaft.mat')
factor1=0.2;
ans2=ans1;
ans2(:,1)=factor1*ans1(:,1);
ans2(:,2)=ans2(:,2)+abs(ans2(1,2))+abs(ans2(end,2)-ans2(1,2))/2+...
    ans1(1,2)-abs(ans1(end,2)-ans1(1,2))/2;
plot(ans1(:,1),ans1(:,2),'k',ans2(:,1),ans2(:,2),'b')
