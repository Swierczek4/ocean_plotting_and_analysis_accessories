clear
close all
clc

tic()
acc_settings

%%
load mask
load XY3 
load XY6 
load XY12
load ETAN_MAT
load AB_AVISO_adj
%%

%%
D_AVISO(isnan(D_AVISO)==1) = 99999999;
numdate = datenum('12012016','mmddyyyy');
option = 13;
mask = permute(mask,[2,1,3]);
inside_coords = [290.5 350.2 -58.7 -32];
[XC3,YC3] = ndgrid(XC3,YC3);
[XC6,YC6] = ndgrid(XC6,YC6);
[XC12,YC12] = ndgrid(XC12,YC12);
clear *field* *MASK* mm nn ii jj hix hiy lox loy *Fac* str *DYG* *DXG* *DRF*
%%

%% ETAN
cm = acc_colormap('cmo_balance');

[lb,ub,lbcb,ubcb,nlvls] = get_color_bounds_balance_alt(D_AVISO,...
    ETAN_Series32,ETAN_Series62,ETAN_Series122,option);
nlvls = 8*(nlvls - 1) +1;
z = linspace(lb,ub,nlvls);


figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm)
ax1 = subplot(2,2,1);
contourf(XCA,YCA,D_AVISO(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
caxis([lb ub])
axis(inside_coords)
ytickformat('degrees')
title('1/4 AVISO SSH anomaly','FontWeight','Normal','FontSize',16)
acc_movie
acc_quad_plots_v1
text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
hold off

ax2 = subplot(2,2,2);
contourf(XC3,YC3,ETAN_Series32(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
caxis([lb ub])
axis(inside_coords)
xtickformat('degrees')
ytickformat('degrees')
title('1/3 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
acc_movie
acc_quad_plots_v2
text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
hold off

ax3 = subplot(2,2,3);
contourf(XC6,YC6,ETAN_Series62(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
caxis([lb ub])
axis(inside_coords)
xtickformat('degrees')
ytickformat('degrees')
title('1/6 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
acc_movie
acc_quad_plots_v3
text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
hold off

ax4 = subplot(2,2,4);
contourf(XC12,YC12,ETAN_Series122(:,:,1),'LineStyle','none','LevelList',z);
hold on
cbar = colorbar('eastoutside');
set(cbar,'XLim',[lbcb ubcb]);
contour(XCm,YCm,mask(:,:,1),'Color','k')
caxis([lb ub])
axis(inside_coords)
xtickformat('degrees')
ytickformat('degrees')
title('1/12 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
acc_movie
acc_quad_plots_v8
text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
hold off

set(gca, 'nextplot','replacechildren', 'Visible','on');
vidObj = VideoWriter('SSH_AVISO.avi');
vidObj.Quality = 100;
vidObj.FrameRate = 30;
open(vidObj);
writeVideo(vidObj, getframe(gcf));

ax1 = subplot(2,2,1);
contourf(XCA,YCA,D_AVISO(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
caxis([lb ub])
axis(inside_coords)
ytickformat('degrees')
title('1/4 AVISO SSH anomaly','FontWeight','Normal','FontSize',16)
acc_movie
acc_quad_plots_v1
text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
hold off

ax2 = subplot(2,2,2);
contourf(XC3,YC3,ETAN_Series32(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
caxis([lb ub])
axis(inside_coords)
xtickformat('degrees')
ytickformat('degrees')
title('1/3 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
acc_movie
acc_quad_plots_v2
text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
hold off

ax3 = subplot(2,2,3);
contourf(XC6,YC6,ETAN_Series62(:,:,1),'LineStyle','none','LevelList',z);
hold on
contour(XCm,YCm,mask(:,:,1),'Color','k')
caxis([lb ub])
axis(inside_coords)
xtickformat('degrees')
ytickformat('degrees')
title('1/6 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
acc_movie
acc_quad_plots_v3
text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
hold off

ax4 = subplot(2,2,4);
contourf(XC12,YC12,ETAN_Series122(:,:,1),'LineStyle','none','LevelList',z);
hold on
cbar = colorbar('eastoutside');
set(cbar,'XLim',[lbcb ubcb]);
contour(XCm,YCm,mask(:,:,1),'Color','k')
caxis([lb ub])
axis(inside_coords)
xtickformat('degrees')
ytickformat('degrees')
title('1/12 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
acc_movie
acc_quad_plots_v8
text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
hold off

drawnow()
writeVideo(vidObj, getframe(gcf));

for ii=2:395
    numdate = numdate + 1;
    
    ax1 = subplot(2,2,1);
    contourf(XCA,YCA,D_AVISO(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    caxis([lb ub])
    axis(inside_coords)
    ytickformat('degrees')
    title('1/4 AVISO SSH anomaly','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_quad_plots_v1
    text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
    hold off
    
    ax2 = subplot(2,2,2);
    contourf(XC3,YC3,ETAN_Series32(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    caxis([lb ub])
    axis(inside_coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('1/3 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_quad_plots_v2
    text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
    hold off
    
    ax3 = subplot(2,2,3);
    contourf(XC6,YC6,ETAN_Series62(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    caxis([lb ub])
    axis(inside_coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('1/6 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_quad_plots_v3
    text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
    hold off
    
    ax4 = subplot(2,2,4);
    contourf(XC12,YC12,ETAN_Series122(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    cbar = colorbar('eastoutside');
    set(cbar,'XLim',[lbcb ubcb]);
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    caxis([lb ub])
    axis(inside_coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('1/12 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_quad_plots_v8
    text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
    hold off
    
    
    drawnow()
    writeVideo(vidObj, getframe(gcf));
    
    ax1 = subplot(2,2,1);
    contourf(XCA,YCA,D_AVISO(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    caxis([lb ub])
    axis(inside_coords)
    ytickformat('degrees')
    title('1/4 AVISO SSH anomaly','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_quad_plots_v1
    text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
    hold off
    
    ax2 = subplot(2,2,2);
    contourf(XC3,YC3,ETAN_Series32(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    caxis([lb ub])
    axis(inside_coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('1/3 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_quad_plots_v2
    text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
    hold off
    
    ax3 = subplot(2,2,3);
    contourf(XC6,YC6,ETAN_Series62(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    caxis([lb ub])
    axis(inside_coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('1/6 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_quad_plots_v3
    text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
    hold off
    
    ax4 = subplot(2,2,4);
    contourf(XC12,YC12,ETAN_Series122(:,:,ii),'LineStyle','none','LevelList',z);
    hold on
    cbar = colorbar('eastoutside');
    set(cbar,'XLim',[lbcb ubcb]);
    contour(XCm,YCm,mask(:,:,1),'Color','k')
    caxis([lb ub])
    axis(inside_coords)
    xtickformat('degrees')
    ytickformat('degrees')
    title('1/12 MITgcm+BLING SSH anomaly','FontWeight','Normal','FontSize',16)
    acc_movie
    acc_quad_plots_v8
    text(291,-33.7,datestr(numdate,'yyyy mmm dd'),'FontSize',21,'Color','w')
    hold off
    
    
    drawnow()
    writeVideo(vidObj, getframe(gcf));
end
close(vidObj);

%% END ETAN