tic()
clc
clear
close all


load XY12

HC = hFacC12;
HS = hFacS12;
HW = hFacW12;

DRF12 = repmat(DRF12,1,512)';
EDYG12 = repmat(EDYG12,104,1)';
WDYG12 = repmat(WDYG12,104,1)';
NDXG12 = repmat(NDXG12,1,104);
SDXG12 = repmat(SDXG12,1,104);

[XU,YU] = ndgrid(XG12,YC12);
[XV,YV] = ndgrid(XC12,YG12);
[XC12,YC12] = ndgrid(XC12,YC12);

%% DIC
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_DIC.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
%%

%% UVEL
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_Uvel.nc';

XCS = ncread(str,'XG');
YCS = ncread(str,'YC');
hFacW = ncread(str,'hFacW');
% X = XCS;
% Y = YCS;
% lox = find(X>288.3,1)-1;
% hix = find(X>352,1)+1;
% loy = find(Y>-60.1,1)-1;
% hiy = find(Y>-30.7,1)+1;
% YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacW = hFacW(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



UVEL_temp = ncread(str,'UVEL',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        UVEL_temp_temp = UVEL_temp(:,:,jj,ii);
        UVEL_temp_temp(hFacW(:,:,jj)==0) = NaN;
        UVEL_temp_temp = fillmissingstan(UVEL_temp_temp);
        UVEL_temp(:,:,jj,ii) = UVEL_temp_temp;
    end
end
UVEL = zeros(756,512,104,72);

fprintf('UVEL grid = [%g,%g]x[%g,%g] \n UVEL nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,UVEL_temp(:,:,ii,jj),'linear');
        UVEL(:,:,2*ii,jj) = F(XU,YU);
    end
    if ii==1
        UVEL(:,:,1,:) = UVEL(:,:,2,:);
    else
        UVEL(:,:,2*ii-1,:) = 0.5*(UVEL(:,:,2*ii-2,:) + UVEL(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = UVEL(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of UVEL mistakes = %g \n',num_mistakes)

UVELN = UVEL(:,497,:,:);
UVELS = UVEL(:,16,:,:);
UVELE = UVEL(741,:,:,:);
UVELW = UVEL(16,:,:,:);

UVELN = squeeze(UVELN);
UVELS = squeeze(UVELS);
UVELE = squeeze(UVELE);
UVELW = squeeze(UVELW);

UVEL_temp = ncread(str,'UVEL',[1,1,1,1],[2160,588,52,72]);
XCS = ncread(str,'XG');
YCS = ncread(str,'YC');
hFacW = ncread(str,'hFacW');
DYG = ncread(str,'dyG');
DRF = ncread(str,'drF');
DRF = repmat(DRF,1,249)';
bsinde = find(XCS>XG12(741),1)-1;
temp1 = abs(XCS(bsinde)-XG12(741));
temp2 = abs(XCS(bsinde+1)-XG12(741));
if temp2<temp1
    bsinde = bsinde + 1;
end
bsindw = find(XCS>XG12(15),1);
temp1 = abs(XCS(bsindw)-XG12(15));
temp2 = abs(XCS(bsindw-1)-XG12(15));
if temp2<temp1
    bsindw = bsindw - 1;
end
bsindn = find(YCS>YG12(497),1);
temp1 = abs(YCS(bsindn)-YC12(497));
temp2 = abs(YCS(bsindn-1)-YC12(497));
if temp2<temp1
    bsindn = bsindn - 1;
end
bsinds = find(YCS>YC12(15),1)-1;
temp1 = abs(YCS(bsinds)-YC12(15));
temp2 = abs(YCS(bsinds+1)-YC12(15));
if temp2<temp1
    bsinds = bsinds + 1;
end
DYGE = DYG(bsinde,bsinds:bsindn);
DYGE = repmat(DYGE,52,1)';
DYGW = DYG(bsindw,bsinds:bsindn);
DYGW = repmat(DYGW,52,1)';
cross_sec_area_e = sum(sum(EUMASK12.*DRF12.*EDYG12));
cross_sec_area_w = sum(sum(WUMASK12.*DRF12.*WDYG12));

for ii=1:72
    myfluxe = sum(sum(UVELE(:,:,ii).*EUMASK12.*DRF12.*EDYG12));
    myfluxw = sum(sum(UVELW(:,:,ii).*WUMASK12.*DRF12.*WDYG12));
    bsosefluxe = sum(sum(squeeze(UVEL_temp(bsinde,bsinds:bsindn,:,ii)).*...
        squeeze(hFacW(bsinde,bsinds:bsindn,:)).*DRF.*DYGE));
    bsosefluxw = sum(sum(squeeze(UVEL_temp(bsindw,bsinds:bsindn,:,ii)).*...
        squeeze(hFacW(bsindw,bsinds:bsindn,:)).*DRF.*DYGW));
    fprintf('my east flux is %g \n',myfluxe);
    fprintf('my west flux is %g \n',myfluxw);
    fprintf('bsose east flux is %g \n',bsosefluxe);
    fprintf('bsose west flux is %g \n',bsosefluxw);
    efluxdiff = bsosefluxe - myfluxe;
    wfluxdiff = bsosefluxw - myfluxw;
    UVELE(:,:,ii) = UVELE(:,:,ii) + ...
        efluxdiff/cross_sec_area_e;
    UVELW(:,:,ii) = UVELW(:,:,ii) + ...
        wfluxdiff/cross_sec_area_w;
    myfluxe = sum(sum(UVELE(:,:,ii).*EUMASK12.*DRF12.*EDYG12));
    myfluxw = sum(sum(UVELW(:,:,ii).*WUMASK12.*DRF12.*WDYG12));
    fprintf('now my east flux is %g \n',myfluxe);
    fprintf('now my west flux is %g \n',myfluxw);    
end

for ii=1:15
    UVELN(ii,:,:) = UVELN(16,:,:);
    UVELN(741+ii,:,:) = UVELN(741,:,:);
    UVELS(ii,:,:) = UVELS(16,:,:);
    UVELS(741+ii,:,:) = UVELS(741,:,:);
    UVELE(ii,:,:) = UVELE(16,:,:);
    UVELE(497+ii,:,:) = UVELE(497,:,:);
    UVELW(ii,:,:) = UVELW(16,:,:);
    UVELW(497+ii,:,:) = UVELW(497,:,:);
end

fprintf('UVELN has %g NaNs \n',sum(sum(sum(isnan(UVELN)))));
fprintf('UVELS has %g NaNs \n',sum(sum(sum(isnan(UVELS)))));
fprintf('UVELE has %g NaNs \n',sum(sum(sum(isnan(UVELE)))));
fprintf('UVELW has %g NaNs \n',sum(sum(sum(isnan(UVELW)))));

fid = fopen('UVEL_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,UVELN,'single');
fclose(fid);

fid = fopen('UVEL_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,UVELS,'single');
fclose(fid);

fid = fopen('UVEL_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,UVELE,'single');
fclose(fid);

fid = fopen('UVEL_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,UVELW,'single');
fclose(fid);

clear UVEL*
%% end UVEL

%% VVEL
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_Vvel.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YG');
hFacS = ncread(str,'hFacS');
% X = XCS;
% Y = YCS;
% lox = find(X>288.3,1)-1;
% hix = find(X>352,1)+1;
% loy = find(Y>-60.1,1)-1;
% hiy = find(Y>-30.7,1)+1;
% YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacS = hFacS(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



VVEL_temp = ncread(str,'VVEL',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        VVEL_temp_temp = VVEL_temp(:,:,jj,ii);
        VVEL_temp_temp(hFacS(:,:,jj)==0) = NaN;
        VVEL_temp_temp = fillmissingstan(VVEL_temp_temp);
        VVEL_temp(:,:,jj,ii) = VVEL_temp_temp;
    end
end
VVEL = zeros(756,512,104,72);

fprintf('VVEL grid = [%g,%g]x[%g,%g] \n VVEL nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,VVEL_temp(:,:,ii,jj),'linear');
        VVEL(:,:,2*ii,jj) = F(XV,YV);
    end
    if ii==1
        VVEL(:,:,1,:) = VVEL(:,:,2,:);
    else
        VVEL(:,:,2*ii-1,:) = 0.5*(VVEL(:,:,2*ii-2,:) + VVEL(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = VVEL(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of VVEL mistakes = %g \n',num_mistakes)

VVELN = VVEL(:,497,:,:);
VVELS = VVEL(:,16,:,:);
VVELE = VVEL(741,:,:,:);
VVELW = VVEL(16,:,:,:);

VVELN = squeeze(VVELN);
VVELS = squeeze(VVELS);
VVELE = squeeze(VVELE);
VVELW = squeeze(VVELW);

VVEL_temp = ncread(str,'VVEL',[1,1,1,1],[2160,588,52,72]);
XCS = ncread(str,'XC');
YCS = ncread(str,'YG');
hFacS = ncread(str,'hFacS');
DXG = ncread(str,'dxG');
DRF = ncread(str,'drF');

bsinde = find(XCS>XC12(741),1)-1;
temp1 = abs(XCS(bsinde)-XC12(741));
temp2 = abs(XCS(bsinde+1)-XC12(741));
if temp2<temp1
    bsinde = bsinde + 1;
end
bsindw = find(XCS>XC12(15),1);
temp1 = abs(XCS(bsindw)-XC12(15));
temp2 = abs(XCS(bsindw-1)-XC12(15));
if temp2<temp1
    bsindw = bsindw - 1;
end
bsindn = find(YCS>YG12(497),1);
temp1 = abs(YCS(bsindn)-YG12(497));
temp2 = abs(YCS(bsindn-1)-YG12(497));
if temp2<temp1
    bsindn = bsindn - 1;
end
bsinds = find(YCS>YG12(15),1)-1;
temp1 = abs(YCS(bsinds)-YG12(15));
temp2 = abs(YCS(bsinds+1)-YG12(15));
if temp2<temp1
    bsinds = bsinds + 1;
end
DXGS = DXG(bsindw:bsinde,bsinds);
DXGS = repmat(DXGS,1,52);
DXGN = DXG(bsindw:bsinde,bsindn);
DXGN = repmat(DXGN,1,52);
DRF12 = repmat(DRF12(1,:),756,1);
cross_sect_area_n = sum(sum(NVMASK12.*DRF12.*NDXG12));
cross_sect_area_s = sum(sum(SVMASK12.*DRF12.*SDXG12));
DRF = repmat(DRF,1,bsinde-bsindw+1)';

for ii=1:72
    myfluxn = sum(sum(VVELN(:,:,ii).*NVMASK12.*DRF12.*NDXG12));
    myfluxs = sum(sum(VVELS(:,:,ii).*SVMASK12.*DRF12.*SDXG12));
    bsosefluxn = sum(sum(squeeze(VVEL_temp(bsindw:bsinde,bsindn,:,ii)).*...
        squeeze(hFacS(bsindw:bsinde,bsindn,:)).*DRF.*DXGN));
    bsosefluxs = sum(sum(squeeze(VVEL_temp(bsindw:bsinde,bsinds,:,ii)).*...
        squeeze(hFacS(bsindw:bsinde,bsinds,:)).*DRF.*DXGS));
    fprintf('my north flux is %g \n',myfluxn);
    fprintf('my south flux is %g \n',myfluxs);
    fprintf('bsose north flux is %g \n',bsosefluxn);
    fprintf('bsose south flux is %g \n',bsosefluxs);
    nfluxdiff = bsosefluxn - myfluxn;
    sfluxdiff = bsosefluxs - myfluxs;
    VVELN(:,:,ii) = VVELN(:,:,ii) + ...
        nfluxdiff/cross_sect_area_n;
    VVELS(:,:,ii) = VVELS(:,:,ii) + ...
        sfluxdiff/cross_sect_area_s;
    myfluxn = sum(sum(VVELN(:,:,ii).*NVMASK12.*DRF12.*NDXG12));
    myfluxs = sum(sum(VVELS(:,:,ii).*SVMASK12.*DRF12.*SDXG12));   
    fprintf('now my north flux is %g \n',myfluxn);
    fprintf('now my south flux is %g \n',myfluxs);    
end


for ii=1:15
    VVELN(ii,:,:) = VVELN(16,:,:);
    VVELN(741+ii,:,:) = VVELN(741,:,:);
    VVELS(ii,:,:) = VVELS(16,:,:);
    VVELS(741+ii,:,:) = VVELS(741,:,:);
    VVELE(ii,:,:) = VVELE(16,:,:);
    VVELE(497+ii,:,:) = VVELE(497,:,:);
    VVELW(ii,:,:) = VVELW(16,:,:);
    VVELW(497+ii,:,:) = VVELW(497,:,:);
end

fprintf('VVELN has %g NaNs \n',sum(sum(sum(isnan(VVELN)))));
fprintf('VVELS has %g NaNs \n',sum(sum(sum(isnan(VVELS)))));
fprintf('VVELE has %g NaNs \n',sum(sum(sum(isnan(VVELE)))));
fprintf('VVELW has %g NaNs \n',sum(sum(sum(isnan(VVELW)))));

fid = fopen('VVEL_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,VVELN,'single');
fclose(fid);

fid = fopen('VVEL_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,VVELS,'single');
fclose(fid);

fid = fopen('VVEL_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,VVELE,'single');
fclose(fid);

fid = fopen('VVEL_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,VVELW,'single');
fclose(fid);

clear VVEL*
%% end VVEL

%% DIC
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_DIC.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



DIC_temp = ncread(str,'TRAC01',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        DIC_temp_temp = DIC_temp(:,:,jj,ii);
        DIC_temp_temp(hFacC(:,:,jj)==0) = NaN;
        DIC_temp_temp = fillmissingstan(DIC_temp_temp);
        DIC_temp(:,:,jj,ii) = DIC_temp_temp;
    end
end
DIC = zeros(756,512,104,72);

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,DIC_temp(:,:,ii,jj),'linear');
        DIC(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        DIC(:,:,1,:) = DIC(:,:,2,:);
    else
        DIC(:,:,2*ii-1,:) = 0.5*(DIC(:,:,2*ii-2,:) + DIC(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = DIC(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of DIC mistakes = %g \n',num_mistakes)

fprintf('DIC grid = [%g,%g]x[%g,%g] \n DIC nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));


DICN = DIC(:,497,:,:);
DICS = DIC(:,16,:,:);
DICE = DIC(741,:,:,:);
DICW = DIC(16,:,:,:);
for ii=1:15
    DICN(ii,:,:,:) = DICN(16,:,:,:);
    DICN(741+ii,:,:,:) = DICN(741,:,:,:);
    DICS(ii,:,:,:) = DICS(16,:,:,:);
    DICS(741+ii,:,:,:) = DICS(741,:,:,:);
    DICE(:,ii,:,:) = DICE(:,16,:,:);
    DICE(:,497+ii,:,:) = DICE(:,497,:,:);
    DICW(:,ii,:,:) = DICW(:,16,:,:);
    DICW(:,497+ii,:,:) = DICW(:,497,:,:);
end

DICN = squeeze(DICN);
DICS = squeeze(DICS);
DICE = squeeze(DICE);
DICW = squeeze(DICW);

fprintf('DICN has %g NaNs \n',sum(sum(sum(isnan(DICN)))));
fprintf('DICS has %g NaNs \n',sum(sum(sum(isnan(DICS)))));
fprintf('DICE has %g NaNs \n',sum(sum(sum(isnan(DICE)))));
fprintf('DICW has %g NaNs \n',sum(sum(sum(isnan(DICW)))));

fid = fopen('DIC_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DICN,'single');
fclose(fid);

fid = fopen('DIC_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DICS,'single');
fclose(fid);

fid = fopen('DIC_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DICE,'single');
fclose(fid);

fid = fopen('DIC_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DICW,'single');
fclose(fid);

clear DIC*
%% end DIC


%% ALK
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_Alk.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



ALK_temp = ncread(str,'TRAC02',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        ALK_temp_temp = ALK_temp(:,:,jj,ii);
        ALK_temp_temp(hFacC(:,:,jj)==0) = NaN;
        ALK_temp_temp = fillmissingstan(ALK_temp_temp);
        ALK_temp(:,:,jj,ii) = ALK_temp_temp;
    end
end
ALK = zeros(756,512,104,72);

fprintf('ALK grid = [%g,%g]x[%g,%g] \n ALK nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,ALK_temp(:,:,ii,jj),'linear');
        ALK(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        ALK(:,:,1,:) = ALK(:,:,2,:);
    else
        ALK(:,:,2*ii-1,:) = 0.5*(ALK(:,:,2*ii-2,:) + ALK(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = ALK(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of ALK mistakes = %g \n',num_mistakes)

ALKN = ALK(:,497,:,:);
ALKS = ALK(:,16,:,:);
ALKE = ALK(741,:,:,:);
ALKW = ALK(16,:,:,:);
for ii=1:15
    ALKN(ii,:,:,:) = ALKN(16,:,:,:);
    ALKN(741+ii,:,:,:) = ALKN(741,:,:,:);
    ALKS(ii,:,:,:) = ALKS(16,:,:,:);
    ALKS(741+ii,:,:,:) = ALKS(741,:,:,:);
    ALKE(:,ii,:,:) = ALKE(:,16,:,:);
    ALKE(:,497+ii,:,:) = ALKE(:,497,:,:);
    ALKW(:,ii,:,:) = ALKW(:,16,:,:);
    ALKW(:,497+ii,:,:) = ALKW(:,497,:,:);
end

ALKN = squeeze(ALKN);
ALKS = squeeze(ALKS);
ALKE = squeeze(ALKE);
ALKW = squeeze(ALKW);

fprintf('ALKN has %g NaNs \n',sum(sum(sum(isnan(ALKN)))));
fprintf('ALKS has %g NaNs \n',sum(sum(sum(isnan(ALKS)))));
fprintf('ALKE has %g NaNs \n',sum(sum(sum(isnan(ALKE)))));
fprintf('ALKW has %g NaNs \n',sum(sum(sum(isnan(ALKW)))));

fid = fopen('ALK_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,ALKN,'single');
fclose(fid);

fid = fopen('ALK_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,ALKS,'single');
fclose(fid);

fid = fopen('ALK_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,ALKE,'single');
fclose(fid);

fid = fopen('ALK_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,ALKW,'single');
fclose(fid);

clear ALK*
%% end ALK

%% O2
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_O2.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



O2_temp = ncread(str,'TRAC03',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        O2_temp_temp = O2_temp(:,:,jj,ii);
        O2_temp_temp(hFacC(:,:,jj)==0) = NaN;
        O2_temp_temp = fillmissingstan(O2_temp_temp);
        O2_temp(:,:,jj,ii) = O2_temp_temp;
    end
end
O2 = zeros(756,512,104,72);

fprintf('O2 grid = [%g,%g]x[%g,%g] \n O2 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,O2_temp(:,:,ii,jj),'linear');
        O2(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        O2(:,:,1,:) = O2(:,:,2,:);
    else
        O2(:,:,2*ii-1,:) = 0.5*(O2(:,:,2*ii-2,:) + O2(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = O2(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of O2 mistakes = %g \n',num_mistakes)

O2N = O2(:,497,:,:);
O2S = O2(:,16,:,:);
O2E = O2(741,:,:,:);
O2W = O2(16,:,:,:);
for ii=1:15
    O2N(ii,:,:,:) = O2N(16,:,:,:);
    O2N(741+ii,:,:,:) = O2N(741,:,:,:);
    O2S(ii,:,:,:) = O2S(16,:,:,:);
    O2S(741+ii,:,:,:) = O2S(741,:,:,:);
    O2E(:,ii,:,:) = O2E(:,16,:,:);
    O2E(:,497+ii,:,:) = O2E(:,497,:,:);
    O2W(:,ii,:,:) = O2W(:,16,:,:);
    O2W(:,497+ii,:,:) = O2W(:,497,:,:);
end

O2N = squeeze(O2N);
O2S = squeeze(O2S);
O2E = squeeze(O2E);
O2W = squeeze(O2W);

fprintf('O2N has %g NaNs \n',sum(sum(sum(isnan(O2N)))));
fprintf('O2S has %g NaNs \n',sum(sum(sum(isnan(O2S)))));
fprintf('O2E has %g NaNs \n',sum(sum(sum(isnan(O2E)))));
fprintf('O2W has %g NaNs \n',sum(sum(sum(isnan(O2W)))));

fid = fopen('O2_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,O2N,'single');
fclose(fid);

fid = fopen('O2_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,O2S,'single');
fclose(fid);

fid = fopen('O2_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,O2E,'single');
fclose(fid);

fid = fopen('O2_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,O2W,'single');
fclose(fid);

clear O2*
%% end O2

%% NO3
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_NO3.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



NO3_temp = ncread(str,'TRAC04',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        NO3_temp_temp = NO3_temp(:,:,jj,ii);
        NO3_temp_temp(hFacC(:,:,jj)==0) = NaN;
        NO3_temp_temp = fillmissingstan(NO3_temp_temp);
        NO3_temp(:,:,jj,ii) = NO3_temp_temp;
    end
end
NO3 = zeros(756,512,104,72);

fprintf('NO3 grid = [%g,%g]x[%g,%g] \n NO3 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,NO3_temp(:,:,ii,jj),'linear');
        NO3(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        NO3(:,:,1,:) = NO3(:,:,2,:);
    else
        NO3(:,:,2*ii-1,:) = 0.5*(NO3(:,:,2*ii-2,:) + NO3(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = NO3(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of NO3 mistakes = %g \n',num_mistakes)

NO3N = NO3(:,497,:,:);
NO3S = NO3(:,16,:,:);
NO3E = NO3(741,:,:,:);
NO3W = NO3(16,:,:,:);
for ii=1:15
    NO3N(ii,:,:,:) = NO3N(16,:,:,:);
    NO3N(741+ii,:,:,:) = NO3N(741,:,:,:);
    NO3S(ii,:,:,:) = NO3S(16,:,:,:);
    NO3S(741+ii,:,:,:) = NO3S(741,:,:,:);
    NO3E(:,ii,:,:) = NO3E(:,16,:,:);
    NO3E(:,497+ii,:,:) = NO3E(:,497,:,:);
    NO3W(:,ii,:,:) = NO3W(:,16,:,:);
    NO3W(:,497+ii,:,:) = NO3W(:,497,:,:);
end

NO3N = squeeze(NO3N);
NO3S = squeeze(NO3S);
NO3E = squeeze(NO3E);
NO3W = squeeze(NO3W);

fprintf('NO3N has %g NaNs \n',sum(sum(sum(isnan(NO3N)))));
fprintf('NO3S has %g NaNs \n',sum(sum(sum(isnan(NO3S)))));
fprintf('NO3E has %g NaNs \n',sum(sum(sum(isnan(NO3E)))));
fprintf('NO3W has %g NaNs \n',sum(sum(sum(isnan(NO3W)))));

fid = fopen('NO3_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,NO3N,'single');
fclose(fid);

fid = fopen('NO3_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,NO3S,'single');
fclose(fid);

fid = fopen('NO3_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,NO3E,'single');
fclose(fid);

fid = fopen('NO3_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,NO3W,'single');
fclose(fid);

clear NO3*
%% end NO3

%% PO4
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_PO4.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



PO4_temp = ncread(str,'TRAC05',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        PO4_temp_temp = PO4_temp(:,:,jj,ii);
        PO4_temp_temp(hFacC(:,:,jj)==0) = NaN;
        PO4_temp_temp = fillmissingstan(PO4_temp_temp);
        PO4_temp(:,:,jj,ii) = PO4_temp_temp;
    end
end
PO4 = zeros(756,512,104,72);

fprintf('PO4 grid = [%g,%g]x[%g,%g] \n PO4 nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,PO4_temp(:,:,ii,jj),'linear');
        PO4(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        PO4(:,:,1,:) = PO4(:,:,2,:);
    else
        PO4(:,:,2*ii-1,:) = 0.5*(PO4(:,:,2*ii-2,:) + PO4(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = PO4(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of PO4 mistakes = %g \n',num_mistakes)

PO4N = PO4(:,497,:,:);
PO4S = PO4(:,16,:,:);
PO4E = PO4(741,:,:,:);
PO4W = PO4(16,:,:,:);
for ii=1:15
    PO4N(ii,:,:,:) = PO4N(16,:,:,:);
    PO4N(741+ii,:,:,:) = PO4N(741,:,:,:);
    PO4S(ii,:,:,:) = PO4S(16,:,:,:);
    PO4S(741+ii,:,:,:) = PO4S(741,:,:,:);
    PO4E(:,ii,:,:) = PO4E(:,16,:,:);
    PO4E(:,497+ii,:,:) = PO4E(:,497,:,:);
    PO4W(:,ii,:,:) = PO4W(:,16,:,:);
    PO4W(:,497+ii,:,:) = PO4W(:,497,:,:);
end

PO4N = squeeze(PO4N);
PO4S = squeeze(PO4S);
PO4E = squeeze(PO4E);
PO4W = squeeze(PO4W);

fprintf('PO4N has %g NaNs \n',sum(sum(sum(isnan(PO4N)))));
fprintf('PO4S has %g NaNs \n',sum(sum(sum(isnan(PO4S)))));
fprintf('PO4E has %g NaNs \n',sum(sum(sum(isnan(PO4E)))));
fprintf('PO4W has %g NaNs \n',sum(sum(sum(isnan(PO4W)))));

fid = fopen('PO4_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,PO4N,'single');
fclose(fid);

fid = fopen('PO4_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,PO4S,'single');
fclose(fid);

fid = fopen('PO4_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,PO4E,'single');
fclose(fid);

fid = fopen('PO4_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,PO4W,'single');
fclose(fid);

clear PO4*
%% end PO4

%% FE
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_Fe.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



FE_temp = ncread(str,'TRAC06',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        FE_temp_temp = FE_temp(:,:,jj,ii);
        FE_temp_temp(hFacC(:,:,jj)==0) = NaN;
        FE_temp_temp = fillmissingstan(FE_temp_temp);
        FE_temp(:,:,jj,ii) = FE_temp_temp;
    end
end
FE = zeros(756,512,104,72);

fprintf('FE grid = [%g,%g]x[%g,%g] \n FE nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,FE_temp(:,:,ii,jj),'linear');
        FE(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        FE(:,:,1,:) = FE(:,:,2,:);
    else
        FE(:,:,2*ii-1,:) = 0.5*(FE(:,:,2*ii-2,:) + FE(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = FE(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of FE mistakes = %g \n',num_mistakes)

FEN = FE(:,497,:,:);
FES = FE(:,16,:,:);
FEE = FE(741,:,:,:);
FEW = FE(16,:,:,:);
for ii=1:15
    FEN(ii,:,:,:) = FEN(16,:,:,:);
    FEN(741+ii,:,:,:) = FEN(741,:,:,:);
    FES(ii,:,:,:) = FES(16,:,:,:);
    FES(741+ii,:,:,:) = FES(741,:,:,:);
    FEE(:,ii,:,:) = FEE(:,16,:,:);
    FEE(:,497+ii,:,:) = FEE(:,497,:,:);
    FEW(:,ii,:,:) = FEW(:,16,:,:);
    FEW(:,497+ii,:,:) = FEW(:,497,:,:);
end

FEN = squeeze(FEN);
FES = squeeze(FES);
FEE = squeeze(FEE);
FEW = squeeze(FEW);

fprintf('FEN has %g NaNs \n',sum(sum(sum(isnan(FEN)))));
fprintf('FES has %g NaNs \n',sum(sum(sum(isnan(FES)))));
fprintf('FEE has %g NaNs \n',sum(sum(sum(isnan(FEE)))));
fprintf('FEW has %g NaNs \n',sum(sum(sum(isnan(FEW)))));

fid = fopen('FE_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,FEN,'single');
fclose(fid);

fid = fopen('FE_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,FES,'single');
fclose(fid);

fid = fopen('FE_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,FEE,'single');
fclose(fid);

fid = fopen('FE_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,FEW,'single');
fclose(fid);

clear FE*
%% end FE

%% DON
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_DON.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



DON_temp = ncread(str,'TRAC07',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        DON_temp_temp = DON_temp(:,:,jj,ii);
        DON_temp_temp(hFacC(:,:,jj)==0) = NaN;
        DON_temp_temp = fillmissingstan(DON_temp_temp);
        DON_temp(:,:,jj,ii) = DON_temp_temp;
    end
end
DON = zeros(756,512,104,72);

fprintf('DON grid = [%g,%g]x[%g,%g] \n DON nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,DON_temp(:,:,ii,jj),'linear');
        DON(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        DON(:,:,1,:) = DON(:,:,2,:);
    else
        DON(:,:,2*ii-1,:) = 0.5*(DON(:,:,2*ii-2,:) + DON(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = DON(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of DON mistakes = %g \n',num_mistakes)

DONN = DON(:,497,:,:);
DONS = DON(:,16,:,:);
DONE = DON(741,:,:,:);
DONW = DON(16,:,:,:);
for ii=1:15
    DONN(ii,:,:,:) = DONN(16,:,:,:);
    DONN(741+ii,:,:,:) = DONN(741,:,:,:);
    DONS(ii,:,:,:) = DONS(16,:,:,:);
    DONS(741+ii,:,:,:) = DONS(741,:,:,:);
    DONE(:,ii,:,:) = DONE(:,16,:,:);
    DONE(:,497+ii,:,:) = DONE(:,497,:,:);
    DONW(:,ii,:,:) = DONW(:,16,:,:);
    DONW(:,497+ii,:,:) = DONW(:,497,:,:);
end

DONN = squeeze(DONN);
DONS = squeeze(DONS);
DONE = squeeze(DONE);
DONW = squeeze(DONW);

fprintf('DONN has %g NaNs \n',sum(sum(sum(isnan(DONN)))));
fprintf('DONS has %g NaNs \n',sum(sum(sum(isnan(DONS)))));
fprintf('DONE has %g NaNs \n',sum(sum(sum(isnan(DONE)))));
fprintf('DONW has %g NaNs \n',sum(sum(sum(isnan(DONW)))));

fid = fopen('DON_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DONN,'single');
fclose(fid);

fid = fopen('DON_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DONS,'single');
fclose(fid);

fid = fopen('DON_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DONE,'single');
fclose(fid);

fid = fopen('DON_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DONW,'single');
fclose(fid);

clear DON*
%% end DON

%% DOP
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_DOP.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



DOP_temp = ncread(str,'TRAC08',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        DOP_temp_temp = DOP_temp(:,:,jj,ii);
        DOP_temp_temp(hFacC(:,:,jj)==0) = NaN;
        DOP_temp_temp = fillmissingstan(DOP_temp_temp);
        DOP_temp(:,:,jj,ii) = DOP_temp_temp;
    end
end
DOP = zeros(756,512,104,72);

fprintf('DOP grid = [%g,%g]x[%g,%g] \n DOP nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,DOP_temp(:,:,ii,jj),'linear');
        DOP(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        DOP(:,:,1,:) = DOP(:,:,2,:);
    else
        DOP(:,:,2*ii-1,:) = 0.5*(DOP(:,:,2*ii-2,:) + DOP(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = DOP(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of DOP mistakes = %g \n',num_mistakes)

DOPN = DOP(:,497,:,:);
DOPS = DOP(:,16,:,:);
DOPE = DOP(741,:,:,:);
DOPW = DOP(16,:,:,:);
for ii=1:15
    DOPN(ii,:,:,:) = DOPN(16,:,:,:);
    DOPN(741+ii,:,:,:) = DOPN(741,:,:,:);
    DOPS(ii,:,:,:) = DOPS(16,:,:,:);
    DOPS(741+ii,:,:,:) = DOPS(741,:,:,:);
    DOPE(:,ii,:,:) = DOPE(:,16,:,:);
    DOPE(:,497+ii,:,:) = DOPE(:,497,:,:);
    DOPW(:,ii,:,:) = DOPW(:,16,:,:);
    DOPW(:,497+ii,:,:) = DOPW(:,497,:,:);
end

DOPN = squeeze(DOPN);
DOPS = squeeze(DOPS);
DOPE = squeeze(DOPE);
DOPW = squeeze(DOPW);

fprintf('DOPN has %g NaNs \n',sum(sum(sum(isnan(DOPN)))));
fprintf('DOPS has %g NaNs \n',sum(sum(sum(isnan(DOPS)))));
fprintf('DOPE has %g NaNs \n',sum(sum(sum(isnan(DOPE)))));
fprintf('DOPW has %g NaNs \n',sum(sum(sum(isnan(DOPW)))));

fid = fopen('DOP_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DOPN,'single');
fclose(fid);

fid = fopen('DOP_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DOPS,'single');
fclose(fid);

fid = fopen('DOP_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DOPE,'single');
fclose(fid);

fid = fopen('DOP_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,DOPW,'single');
fclose(fid);

clear DOP*
%% end DOP

%% THETA
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_Theta.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



THETA_temp = ncread(str,'THETA',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        THETA_temp_temp = THETA_temp(:,:,jj,ii);
        THETA_temp_temp(hFacC(:,:,jj)==0) = NaN;
        THETA_temp_temp = fillmissingstan(THETA_temp_temp);
        THETA_temp(:,:,jj,ii) = THETA_temp_temp;
    end
end
THETA = zeros(756,512,104,72);

fprintf('THETA grid = [%g,%g]x[%g,%g] \n DOP nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,THETA_temp(:,:,ii,jj),'linear');
        THETA(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        THETA(:,:,1,:) = THETA(:,:,2,:);
    else
        THETA(:,:,2*ii-1,:) = 0.5*(THETA(:,:,2*ii-2,:) + THETA(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = THETA(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of THETA mistakes = %g \n',num_mistakes)

THETAN = THETA(:,497,:,:);
THETAS = THETA(:,16,:,:);
THETAE = THETA(741,:,:,:);
THETAW = THETA(16,:,:,:);
for ii=1:15
    THETAN(ii,:,:,:) = THETAN(16,:,:,:);
    THETAN(741+ii,:,:,:) = THETAN(741,:,:,:);
    THETAS(ii,:,:,:) = THETAS(16,:,:,:);
    THETAS(741+ii,:,:,:) = THETAS(741,:,:,:);
    THETAE(:,ii,:,:) = THETAE(:,16,:,:);
    THETAE(:,497+ii,:,:) = THETAE(:,497,:,:);
    THETAW(:,ii,:,:) = THETAW(:,16,:,:);
    THETAW(:,497+ii,:,:) = THETAW(:,497,:,:);
end

THETAN = squeeze(THETAN);
THETAS = squeeze(THETAS);
THETAE = squeeze(THETAE);
THETAW = squeeze(THETAW);

fprintf('THETAN has %g NaNs \n',sum(sum(sum(isnan(THETAN)))));
fprintf('THETAS has %g NaNs \n',sum(sum(sum(isnan(THETAS)))));
fprintf('THETAE has %g NaNs \n',sum(sum(sum(isnan(THETAE)))));
fprintf('THETAW has %g NaNs \n',sum(sum(sum(isnan(THETAW)))));

fid = fopen('THETA_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,THETAN,'single');
fclose(fid);

fid = fopen('THETA_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,THETAS,'single');
fclose(fid);

fid = fopen('THETA_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,THETAE,'single');
fclose(fid);

fid = fopen('THETA_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,THETAW,'single');
fclose(fid);

clear THETA*
%% end THETA


%% SALT
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_Salt.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



SALT_temp = ncread(str,'SALT',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        SALT_temp_temp = SALT_temp(:,:,jj,ii);
        SALT_temp_temp(hFacC(:,:,jj)==0) = NaN;
        SALT_temp_temp = fillmissingstan(SALT_temp_temp);
        SALT_temp(:,:,jj,ii) = SALT_temp_temp;
    end
end
SALT = zeros(756,512,104,72);

fprintf('SALT grid = [%g,%g]x[%g,%g] \n SALT nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,SALT_temp(:,:,ii,jj),'linear');
        SALT(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        SALT(:,:,1,:) = SALT(:,:,2,:);
    else
        SALT(:,:,2*ii-1,:) = 0.5*(SALT(:,:,2*ii-2,:) + SALT(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = SALT(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of SALT mistakes = %g \n',num_mistakes)

SALTN = SALT(:,497,:,:);
SALTS = SALT(:,16,:,:);
SALTE = SALT(741,:,:,:);
SALTW = SALT(16,:,:,:);
for ii=1:15
    SALTN(ii,:,:,:) = SALTN(16,:,:,:);
    SALTN(741+ii,:,:,:) = SALTN(741,:,:,:);
    SALTS(ii,:,:,:) = SALTS(16,:,:,:);
    SALTS(741+ii,:,:,:) = SALTS(741,:,:,:);
    SALTE(:,ii,:,:) = SALTE(:,16,:,:);
    SALTE(:,497+ii,:,:) = SALTE(:,497,:,:);
    SALTW(:,ii,:,:) = SALTW(:,16,:,:);
    SALTW(:,497+ii,:,:) = SALTW(:,497,:,:);
end

SALTN = squeeze(SALTN);
SALTS = squeeze(SALTS);
SALTE = squeeze(SALTE);
SALTW = squeeze(SALTW);

fprintf('SALTN has %g NaNs \n',sum(sum(sum(isnan(SALTN)))));
fprintf('SALTS has %g NaNs \n',sum(sum(sum(isnan(SALTS)))));
fprintf('SALTE has %g NaNs \n',sum(sum(sum(isnan(SALTE)))));
fprintf('SALTW has %g NaNs \n',sum(sum(sum(isnan(SALTW)))));

fid = fopen('SALT_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,SALTN,'single');
fclose(fid);

fid = fopen('SALT_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,SALTS,'single');
fclose(fid);

fid = fopen('SALT_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,SALTE,'single');
fclose(fid);

fid = fopen('SALT_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,SALTW,'single');
fclose(fid);

% clear SALT*
%% end SALT

%% PHYTO_SM
str = '/data/SOSE/SOSE/SO6/ITER126/bsose_i126_2013to2018_monthly_PhytoSm.nc';

XCS = ncread(str,'XC');
YCS = ncread(str,'YC');
hFacC = ncread(str,'hFacC');
X = XCS;
Y = YCS;
lox = find(X>288.3,1)-1;
hix = find(X>352,1)+1;
loy = find(Y>-60.1,1)-1;
hiy = find(Y>-30.7,1)+1;
YY = find(Y>-32.1,1);
XCS = XCS(lox:hix);
YCS = YCS(loy:hiy);
hFacC = hFacC(lox:hix,loy:hiy,:);
nn = length(XCS);
mm = length(YCS);
[XCS,YCS] = ndgrid(XCS,YCS);



PHYTO_SM_temp = ncread(str,'BLGPSM',[lox,loy,1,1],[nn,mm,52,72]);
for ii=1:72
    for jj=1:52
        PHYTO_SM_temp_temp = PHYTO_SM_temp(:,:,jj,ii);
        PHYTO_SM_temp_temp(hFacC(:,:,jj)==0) = NaN;
        PHYTO_SM_temp_temp = fillmissingstan(PHYTO_SM_temp_temp);
        PHYTO_SM_temp(:,:,jj,ii) = PHYTO_SM_temp_temp;
    end
end
PHYTO_SM = zeros(756,512,104,72);

fprintf('PHYTO_SM grid = [%g,%g]x[%g,%g] \n PHYTO_SM nbc loc = %g \n',X(lox),X(hix),Y(loy),Y(hiy),Y(YY));

for ii=1:52
    for jj=1:72
        F = griddedInterpolant(XCS,YCS,PHYTO_SM_temp(:,:,ii,jj),'linear');
        PHYTO_SM(:,:,2*ii,jj) = F(XC12,YC12);
    end
    if ii==1
        PHYTO_SM(:,:,1,:) = PHYTO_SM(:,:,2,:);
    else
        PHYTO_SM(:,:,2*ii-1,:) = 0.5*(PHYTO_SM(:,:,2*ii-2,:) + PHYTO_SM(:,:,2*ii,:));
    end
end

num_mistakes = 0;
for kk=1:72
    Logic = PHYTO_SM(:,:,:,kk)==0&HC~=0;
    num_mistakes = num_mistakes + sum(reshape(Logic,[756*512*104,1]));
end
fprintf('number of PHYTO_SM mistakes = %g \n',num_mistakes)

PHYTO_SMN = PHYTO_SM(:,497,:,:);
PHYTO_SMS = PHYTO_SM(:,16,:,:);
PHYTO_SME = PHYTO_SM(741,:,:,:);
PHYTO_SMW = PHYTO_SM(16,:,:,:);
for ii=1:15
    PHYTO_SMN(ii,:,:,:) = PHYTO_SMN(16,:,:,:);
    PHYTO_SMN(741+ii,:,:,:) = PHYTO_SMN(741,:,:,:);
    PHYTO_SMS(ii,:,:,:) = PHYTO_SMS(16,:,:,:);
    PHYTO_SMS(741+ii,:,:,:) = PHYTO_SMS(741,:,:,:);
    PHYTO_SME(:,ii,:,:) = PHYTO_SME(:,16,:,:);
    PHYTO_SME(:,497+ii,:,:) = PHYTO_SME(:,497,:,:);
    PHYTO_SMW(:,ii,:,:) = PHYTO_SMW(:,16,:,:);
    PHYTO_SMW(:,497+ii,:,:) = PHYTO_SMW(:,497,:,:);
end

PHYTO_SMN = squeeze(PHYTO_SMN);
PHYTO_SMS = squeeze(PHYTO_SMS);
PHYTO_SME = squeeze(PHYTO_SME);
PHYTO_SMW = squeeze(PHYTO_SMW);

fprintf('PHYTO_SMN has %g NaNs \n',sum(sum(sum(isnan(PHYTO_SMN)))));
fprintf('PHYTO_SMS has %g NaNs \n',sum(sum(sum(isnan(PHYTO_SMS)))));
fprintf('PHYTO_SME has %g NaNs \n',sum(sum(sum(isnan(PHYTO_SME)))));
fprintf('PHYTO_SMW has %g NaNs \n',sum(sum(sum(isnan(PHYTO_SMW)))));

fid = fopen('PHYTO_SM_NBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,PHYTO_SMN,'single');
fclose(fid);

fid = fopen('PHYTO_SM_SBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,PHYTO_SMS,'single');
fclose(fid);

fid = fopen('PHYTO_SM_EBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,PHYTO_SME,'single');
fclose(fid);

fid = fopen('PHYTO_SM_WBC_2013to2018_monthly_12.bin','w','b');
fwrite(fid,PHYTO_SMW,'single');
fclose(fid);

% clear PHYTO_SM*
%% end PHYTO_SM

%% AGE
AGEN = zeros(756,104,61);
AGEN(:,2:104,48) = 1;
AGEN(:,2:104,49) = 2629800;
AGEN(:,2:104,50) = 2*2629800;
AGEN(:,2:104,51) = 3*2629800;
AGEN(:,2:104,52) = 4*2629800;
AGEN(:,2:104,53) = 5*2629800;
AGEN(:,2:104,54) = 6*2629800;
AGEN(:,2:104,55) = 7*2629800;
AGEN(:,2:104,56) = 8*2629800;
AGEN(:,2:104,57) = 9*2629800;
AGEN(:,2:104,58) = 10*2629800;
AGEN(:,2:104,59) = 11*2629800;
AGEN(:,2:104,60) = 12*2629800;
AGEN(:,2:104,61) = 13*2629800;

AGES = AGEN;

AGEE = zeros(512,104,61);
AGEE(:,2:104,48) = 1;
AGEE(:,2:104,49) = 2629800;
AGEE(:,2:104,50) = 2*2629800;
AGEE(:,2:104,51) = 3*2629800;
AGEE(:,2:104,52) = 4*2629800;
AGEE(:,2:104,53) = 5*2629800;
AGEE(:,2:104,54) = 6*2629800;
AGEE(:,2:104,55) = 7*2629800;
AGEE(:,2:104,56) = 8*2629800;
AGEE(:,2:104,57) = 9*2629800;
AGEE(:,2:104,58) = 10*2629800;
AGEE(:,2:104,59) = 11*2629800;
AGEE(:,2:104,60) = 12*2629800;
AGEE(:,2:104,61) = 13*2629800;

AGEW = AGEE;

fid = fopen('AGE_NBC_2013to2018_monthly_122.bin','w','b');
fwrite(fid,AGEN,'single');
fclose(fid);

fid = fopen('AGE_SBC_2013to2018_monthly_122.bin','w','b');
fwrite(fid,AGES,'single');
fclose(fid);

fid = fopen('AGE_EBC_2013to2018_monthly_122.bin','w','b');
fwrite(fid,AGEE,'single');
fclose(fid);

fid = fopen('AGE_WBC_2013to2018_monthly_122.bin','w','b');
fwrite(fid,AGEW,'single');
fclose(fid);

clear AGE*
%% end AGE

%% AGE
AGEN = zeros(756,104,61);

AGEN(:,2:104,54) = 1;
AGEN(:,2:104,55) = 2629800;
AGEN(:,2:104,56) = 2*2629800;
AGEN(:,2:104,57) = 3*2629800;
AGEN(:,2:104,58) = 4*2629800;
AGEN(:,2:104,59) = 5*2629800;
AGEN(:,2:104,60) = 6*2629800;
AGEN(:,2:104,61) = 7*2629800;

AGES = AGEN;

AGEE = zeros(512,104,61);
AGEE(:,2:104,54) = 1;
AGEE(:,2:104,55) = 2629800;
AGEE(:,2:104,56) = 2*2629800;
AGEE(:,2:104,57) = 3*2629800;
AGEE(:,2:104,58) = 4*2629800;
AGEE(:,2:104,59) = 5*2629800;
AGEE(:,2:104,60) = 6*2629800;
AGEE(:,2:104,61) = 7*2629800;

AGEW = AGEE;

fid = fopen('AGE_NBC_2013to2018_monthly_124.bin','w','b');
fwrite(fid,AGEN,'single');
fclose(fid);

fid = fopen('AGE_SBC_2013to2018_monthly_124.bin','w','b');
fwrite(fid,AGES,'single');
fclose(fid);

fid = fopen('AGE_EBC_2013to2018_monthly_124.bin','w','b');
fwrite(fid,AGEE,'single');
fclose(fid);

fid = fopen('AGE_WBC_2013to2018_monthly_124.bin','w','b');
fwrite(fid,AGEW,'single');
fclose(fid);

clear AGE*
%% end AGE


