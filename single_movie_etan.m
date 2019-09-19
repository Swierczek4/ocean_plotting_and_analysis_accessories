clear
close all
clc
tic()

acc_settings

%%
load XY3 YC3
load XY6 YC6
load XY12 YC12
load BSOSE_surf_slice_avgs ETAN_series YCS
load MAT_files/AB122_output_ETAN_slice_vert ETAN_Series*
load MAT_files/AB62_output_ETAN_slice_vert ETAN_Series*
load MAT_files/AB32_output_ETAN_slice_vert ETAN_Series*
%%

%%
numdate = datenum('12012016','mmddyyyy');
option = 1;
lw = 3.3;
ms = 20;
cb = 85;
c3 = 86;
c6 = 87;
c12 = 88;
coords = [-60 -32 -1.7 1.7];
%%

%% 01
figure()
set(gcf, 'Position', [1, 1, 1600, 900])
h1 = plot(YCS,ETAN_series(:,1),'LineWidth',lw,'Color',Color(cb,:));
hold on
h2 = plot(YC3,ETAN_Series_slice_32(:,1),'LineWidth',lw,'Color',Color(c3,:));
h3 = plot(YC6,ETAN_Series_slice_62(:,1),'LineWidth',lw,'Color',Color(c6,:));
h4 = plot(YC12,ETAN_Series_slice_122(:,1),'LineWidth',lw,'Color',Color(c12,:));
axis(coords)
xtickformat('degrees')
ylabel('[m]')
title('SSH anomaly along 307 E','FontWeight','Normal','FontSize',18)
legend([h1(1),h2(1),h3(1),h4(1)],'BSOSE','1/3','1/6','1/12')
acc_movie
acc_plots
text(-39,-1.5,datestr(numdate,'yyyy mmm dd'),'FontSize',24,'Color','k')
hold off

set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('ETAN_slice.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 15;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

for ii=2:395
    numdate = numdate + 1;
    
    h1 = plot(YCS,ETAN_series(:,ii),'LineWidth',lw,'Color',Color(cb,:));
    hold on
    h2 = plot(YC3,ETAN_Series_slice_32(:,ii),'LineWidth',lw,'Color',Color(c3,:));
    h3 = plot(YC6,ETAN_Series_slice_62(:,ii),'LineWidth',lw,'Color',Color(c6,:));
    h4 = plot(YC12,ETAN_Series_slice_122(:,ii),'LineWidth',lw,'Color',Color(c12,:));
    axis(coords)
    xtickformat('degrees')
    ylabel('[m]')
    title('SSH anomaly along 307 E','FontWeight','Normal','FontSize',18)
    legend([h1(1),h2(1),h3(1),h4(1)],'BSOSE','1/3','1/6','1/12')
    acc_movie
    % acc_plots
    text(-39,-1.5,datestr(numdate,'yyyy mmm dd'),'FontSize',24,'Color','k')
    hold off
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end

close(vidObj);
%%
