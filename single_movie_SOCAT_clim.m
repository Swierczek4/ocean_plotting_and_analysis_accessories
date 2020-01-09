clear
close all
clc

tic()
acc_settings

%%
load mask

str = 'SOCATv2019_tracks_gridded_monthly.nc';

tmnth = ncread(str,'tmnth');
xlon = ncread(str,'xlon');
ylat = ncread(str,'ylat');

xlo = find(xlon>-70,1)-1;
xhi = find(xlon>-10,1);
ylo = find(ylat>-60,1)-1;
yhi = find(ylat>-30,1);

xlon = xlon(xlo:xhi) +360;
ylat = ylat(ylo:yhi);

fco2_count_nobs = ncread(str,'fco2_count_nobs');

fco2_count_nobs = fco2_count_nobs(xlo:xhi,ylo:yhi,:);
%%

%%
numdate = datenum('01011970','mmddyyyy') + tmnth(481);
inside_coords = [290.5 350.2 -58.7 -32];
mask = permute(mask,[2,1,3]);
[xlon,ylat] = ndgrid(xlon,ylat);
%%

%% SOCAT
cm = acc_colormap('cmo_tempo');

z = [0:10,1000];

temp = fco2_count_nobs(:,:,481);
fco2_count_clim = zeros(62,32,12);
for ii=1:12
    fco2_count_clim(:,:,ii) = sum(fco2_count_nobs(:,:,(480+ii):12:end),3);
end

figure()
set(gcf, 'Position', [1, 1, 1400, 860])
colormap(cm)
pcolor(xlon,ylat,fco2_count_clim(:,:,1))
% contour(XCm,YCm,mask(:,:,1),'Color','k')
% image(xlon,ylat,fco2_count_nobs(:,:,1),'CDataMapping','scaled')
% contourf(xlon,ylat,fco2_count_nobs(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
% scatter(xlon(temp>0),ylat(temp>0),temp(temp>0)+50,Color(:,13),'filled')
caxis([0 100])
cbar = colorbar('eastoutside');
axis(inside_coords)
ytickformat('degrees')
xtickformat('degrees')
title(['# of fCO_2 obs [SOCAT] during ',datestr(numdate,'mmmm')],...
    'FontWeight','Normal','FontSize',16)
acc_movie
acc_plots
hold off

set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('SOCAT_NUM_OBS_CLIM.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 0.5;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:12
    numdate = numdate + tmnth(ii) - tmnth(ii-1);
    temp = fco2_count_nobs(:,:,ii);
    
    pcolor(xlon,ylat,fco2_count_clim(:,:,ii))
    % contour(XCm,YCm,mask(:,:,1),'Color','k')
    % image(xlon,ylat,fco2_count_nobs(:,:,ii),'CDataMapping','scaled')
    % contourf(xlon,ylat,fco2_count_nobs(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(XCm,YCm,mask(:,:,1),'Color','k')
%     scatter(xlon(temp>0),ylat(temp>0),temp(temp>0)+50,Color(:,13),'filled')
    caxis([0 100])
    cbar = colorbar('eastoutside');
    axis(inside_coords)
    ytickformat('degrees')
    xtickformat('degrees')
    title(['# of fCO_2 obs [SOCAT] during ',datestr(numdate,'mmmm')],...
    'FontWeight','Normal','FontSize',16)
    acc_movie
    hold off
    
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end
close(vidObj);

%% END SOCAT