clear
close all
clc
tic()

%%
acc_colors

inside_coords = [-58.9 -31.8 -2030 0];



load PROFILES/processed/theta_zonal_3
load PROFILES/processed/theta_zonal_6
load PROFILES/processed/theta_zonal_12
load PROFILES/processed/dic_zonal_3
load PROFILES/processed/dic_zonal_6
load PROFILES/processed/dic_zonal_12



cm1 = acc_colormap('cmo_balance');
cm2 = cm1;

lb1 = -5;
ub1 = 5;
lb2 = -40;
ub2 = 40;
lbcb1 = lb1;
ubcb1 = ub1;
lbcb2 = lb2;
ubcb2 = ub2;
sz = 35;
lw = 2;

figure()
set(gcf, 'Position', [1, 1, 1600, 900])
colormap(cm1)
ax1 = subplot(2,3,1);
scatter(prof_lat_3(3334).*ones(97,1),-prof_depth,sz,theta_zonal_3(3334,:),'filled')
hold on
for ii=3333:-1:1
    scatter(prof_lat_3(ii).*ones(97,1),-prof_depth,sz,theta_zonal_3(ii,:),'filled')
end
caxis([lb1 ub1])
axis(inside_coords)
set(gca,'xdir','reverse')
title('1/3  theta misfit','FontWeight','Normal','FontSize',18)
acc_movie_2
acc_6plots_2balz(1,ax1,cm1,lbcb1,ubcb1,lbcb2,ubcb2)
hold off

ax2 = subplot(2,3,2);
scatter(prof_lat_6(3288).*ones(97,1),-prof_depth,sz,theta_zonal_6(3288,:),'filled')
hold on
for ii=3287:-1:1
    scatter(prof_lat_6(ii).*ones(97,1),-prof_depth,sz,theta_zonal_6(ii,:),'filled')
end
caxis([lb1 ub1])
axis(inside_coords)
set(gca,'xdir','reverse')
title('1/6  theta misfit','FontWeight','Normal','FontSize',18)
acc_movie_2
acc_6plots_2balz(2,ax2,cm1,lbcb1,ubcb1,lbcb2,ubcb2)
hold off

ax3 = subplot(2,3,3);
scatter(prof_lat_12(3008).*ones(97,1),-prof_depth,sz,theta_zonal_12(3008,:),'filled')
hold on
for ii=3007:-1:1
    scatter(prof_lat_12(ii).*ones(97,1),-prof_depth,sz,theta_zonal_12(ii,:),'filled')
end
caxis([lb1 ub1])
axis(inside_coords)
set(gca,'xdir','reverse')
title('1/12  theta misfit deg C','FontWeight','Normal','FontSize',18)
acc_movie_2
acc_6plots_2balz(3,ax3,cm1,lbcb1,ubcb1,lbcb2,ubcb2)
hold off

% colormap(cm2)

ax4 = subplot(2,3,4);
scatter(prof_lat_3c(325).*ones(97,1),-prof_depth,sz,dic_zonal_3(325,:),'filled')
hold on
for ii=324:-1:1
    scatter(prof_lat_3c(ii).*ones(97,1),-prof_depth,sz,dic_zonal_3(ii,:),'filled')
end
caxis([lb2 ub2])
axis(inside_coords)
set(gca,'xdir','reverse')
title('1/3  DIC misfit','FontWeight','Normal','FontSize',18)
acc_movie_2
acc_6plots_2balz(4,ax4,cm2,lbcb1,ubcb1,lbcb2,ubcb2)
hold off

ax5 = subplot(2,3,5);
scatter(prof_lat_6c(321).*ones(97,1),-prof_depth,sz,dic_zonal_6(321,:),'filled')
hold on
for ii=320:-1:1
    scatter(prof_lat_6c(ii).*ones(97,1),-prof_depth,sz,dic_zonal_6(ii,:),'filled')
end
caxis([lb2 ub2])
axis(inside_coords)
set(gca,'xdir','reverse')
title('1/6  DIC misfit','FontWeight','Normal','FontSize',18)
acc_movie_2
acc_6plots_2balz(5,ax5,cm2,lbcb1,ubcb1,lbcb2,ubcb2)
hold off

ax6 = subplot(2,3,6);
scatter(prof_lat_12c(300).*ones(97,1),-prof_depth,sz,dic_zonal_12(300,:),'filled')
hold on
for ii=299:-1:1
    scatter(prof_lat_12c(ii).*ones(97,1),-prof_depth,sz,dic_zonal_12(ii,:),'filled')
end
caxis([lb2 ub2])
axis(inside_coords)
set(gca,'xdir','reverse')
title('1/12  DIC misfit \mumol/kg','FontWeight','Normal','FontSize',18)
acc_movie_2
acc_6plots_2balz(6,ax6,cm2,lbcb1,ubcb1,lbcb2,ubcb2)
hold off

set(gcf,'InvertHardCopy','off');
print('-r100','Argo_misfits_zonal_2','-dtiff')
close all







toc()


