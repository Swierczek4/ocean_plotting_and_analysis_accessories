clear all
close all
addpath /home/mmazloff/ANALYSIS

y(1) = -89.7848850;
dy = [0.2786766,0.2803199,0.2806917,0.2808328,0.2809011,0.2809392,0.2809626,0.2809781, ...
      0.2809888,0.2809965,0.2810023,0.2810067,0.2810102,0.2810129,0.2810151,...
      ones(1,33)*0.2810258,ones(1,543)*0.2810302,ones(1,33)*0.2810258,...
      0.2810151,0.2810129,0.2810102,0.2810067,0.2810023,0.2809965,0.2809888,0.2809781,...
      0.2809626,0.2809392,0.2809011,0.2808328,0.2806917,0.2803199,0.2786766];
NY = length(dy)+1;
for i = 2:NY
  y(i) = y(i-1) + dy(i-1);
end
NX = 1280;
x(1) = 0;
for i = 2:NX
  x(i) = x(i-1) + 0.2812500;
end

fid = fopen('ERA5_dsw_2013','r','b');
  Q = single(fread(fid,NX*NY,'single'));
%  Q = single(fread(fid,inf,'single'));
fclose(fid);
NT = length(Q)/NX/NY
Q = reshape(Q,[NX,NY,NT]);

figure(1); clf
imagescnan(x,y,Q(:,:,1)');axis xy
colorbar



