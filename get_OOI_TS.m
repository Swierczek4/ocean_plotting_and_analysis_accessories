clear
close all
clc

tic()

str1 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG040-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str2 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG041-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str3 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG042-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str4 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG043-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str5 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG044-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str6 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG045-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str7 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG046-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str8 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG047-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str9 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOG048-recovered_inst-ctdmo_ghqr_instrument_recovered_20161101T061501-20180109T120001.nc';
str10 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOH049-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str11 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOH050-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str12 = 'deployment0003_GA03FLMA-RIM01-02-CTDMOH051-recovered_inst-ctdmo_ghqr_instrument_recovered_20161030T233001-20180109T120001.nc';
str13 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG060-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str14 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG061-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str15 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG062-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str16 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG063-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str17 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG064-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str18 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG065-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str19 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG066-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T124501.nc';
str20 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG067-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T124501.nc';
str21 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOG068-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str22 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOH069-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str23 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOH070-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';
str24 = 'deployment0003_GA03FLMB-RIM01-02-CTDMOH071-recovered_inst-ctdmo_ghqr_instrument_recovered_20161031T224501-20180112T130001.nc';





strla = 'lat';
strlo = 'lon';
strsqcr = 'practical_salinity_qc_results';
strsqce = 'practical_salinity_qc_executed';
strdqcr = 'density_qc_results';
strdqce = 'density_qc_executed';
strcqcr = 'ctdmo_seawater_conductivity_qc_results';
strcqce = 'ctdmo_seawater_conductivity_qc_executed';
strtqcr = 'ctdmo_seawater_temperature_qc_results';
strtqce = 'ctdmo_seawater_temperature_qc_executed';
strpqcr = 'ctdmo_seawater_pressure_qc_results';
strpqce = 'ctdmo_seawater_pressure_qc_executed';
strd = 'density';
strps = 'practical_salinity';
strsc = 'ctdmo_seawater_conductivity';
strst = 'ctdmo_seawater_temperature';
strp = 'ctdmo_seawater_pressure';
strt = 'temperature';
strtime = 'ctd_time';

str_key = '[time,lat,lon,temp,salt,pres,dens,depth]';

%% 1
ps_qc_e = ncread(str1,strsqce);
ps_qc_r = ncread(str1,strsqcr);
d_qc_e = ncread(str1,strdqce);
d_qc_r = ncread(str1,strdqcr);
st_qc_e = ncread(str1,strtqce);
st_qc_r = ncread(str1,strtqcr);
p_qc_e = ncread(str1,strpqce);
p_qc_r = ncread(str1,strpqcr);
c_qc_e = ncread(str1,strcqce);
c_qc_r = ncread(str1,strcqcr);

time = ncread(str1,strtime);
temp = ncread(str1,strst);
salt = ncread(str1,strps);
dens = ncread(str1,strd);
pres = ncread(str1,strp);
lat = ncread(str1,strla);
lon = ncread(str1,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_30mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_30mA_dep3 GA_OOI_CTD_30mA_dep3 str_key str1
%% 

%% 2
ps_qc_e = ncread(str2,strsqce);
ps_qc_r = ncread(str2,strsqcr);
d_qc_e = ncread(str2,strdqce);
d_qc_r = ncread(str2,strdqcr);
st_qc_e = ncread(str2,strtqce);
st_qc_r = ncread(str2,strtqcr);
p_qc_e = ncread(str2,strpqce);
p_qc_r = ncread(str2,strpqcr);
c_qc_e = ncread(str2,strcqce);
c_qc_r = ncread(str2,strcqcr);

time = ncread(str2,strtime);
temp = ncread(str2,strst);
salt = ncread(str2,strps);
dens = ncread(str2,strd);
pres = ncread(str2,strp);
lat = ncread(str2,strla);
lon = ncread(str2,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_40mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_40mA_dep3 GA_OOI_CTD_40mA_dep3 str_key str2
%% 

%% 3
ps_qc_e = ncread(str3,strsqce);
ps_qc_r = ncread(str3,strsqcr);
d_qc_e = ncread(str3,strdqce);
d_qc_r = ncread(str3,strdqcr);
st_qc_e = ncread(str3,strtqce);
st_qc_r = ncread(str3,strtqcr);
p_qc_e = ncread(str3,strpqce);
p_qc_r = ncread(str3,strpqcr);
c_qc_e = ncread(str3,strcqce);
c_qc_r = ncread(str3,strcqcr);

time = ncread(str3,strtime);
temp = ncread(str3,strst);
salt = ncread(str3,strps);
dens = ncread(str3,strd);
pres = ncread(str3,strp);
lat = ncread(str3,strla);
lon = ncread(str3,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_60mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_60mA_dep3 GA_OOI_CTD_60mA_dep3 str_key str3
%% 

%% 4
ps_qc_e = ncread(str4,strsqce);
ps_qc_r = ncread(str4,strsqcr);
d_qc_e = ncread(str4,strdqce);
d_qc_r = ncread(str4,strdqcr);
st_qc_e = ncread(str4,strtqce);
st_qc_r = ncread(str4,strtqcr);
p_qc_e = ncread(str4,strpqce);
p_qc_r = ncread(str4,strpqcr);
c_qc_e = ncread(str4,strcqce);
c_qc_r = ncread(str4,strcqcr);

time = ncread(str4,strtime);
temp = ncread(str4,strst);
salt = ncread(str4,strps);
dens = ncread(str4,strd);
pres = ncread(str4,strp);
lat = ncread(str4,strla);
lon = ncread(str4,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_90mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_90mA_dep3 GA_OOI_CTD_90mA_dep3 str_key str4
%% 

%% 5
ps_qc_e = ncread(str5,strsqce);
ps_qc_r = ncread(str5,strsqcr);
d_qc_e = ncread(str5,strdqce);
d_qc_r = ncread(str5,strdqcr);
st_qc_e = ncread(str5,strtqce);
st_qc_r = ncread(str5,strtqcr);
p_qc_e = ncread(str5,strpqce);
p_qc_r = ncread(str5,strpqcr);
c_qc_e = ncread(str5,strcqce);
c_qc_r = ncread(str5,strcqcr);

time = ncread(str5,strtime);
temp = ncread(str5,strst);
salt = ncread(str5,strps);
dens = ncread(str5,strd);
pres = ncread(str5,strp);
lat = ncread(str5,strla);
lon = ncread(str5,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_130mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_130mA_dep3 GA_OOI_CTD_130mA_dep3 str_key str5
%% 

%% 6
ps_qc_e = ncread(str6,strsqce);
ps_qc_r = ncread(str6,strsqcr);
d_qc_e = ncread(str6,strdqce);
d_qc_r = ncread(str6,strdqcr);
st_qc_e = ncread(str6,strtqce);
st_qc_r = ncread(str6,strtqcr);
p_qc_e = ncread(str6,strpqce);
p_qc_r = ncread(str6,strpqcr);
c_qc_e = ncread(str6,strcqce);
c_qc_r = ncread(str6,strcqcr);

time = ncread(str6,strtime);
temp = ncread(str6,strst);
salt = ncread(str6,strps);
dens = ncread(str6,strd);
pres = ncread(str6,strp);
lat = ncread(str6,strla);
lon = ncread(str6,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_180mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_180mA_dep3 GA_OOI_CTD_180mA_dep3 str_key str6
%% 

%% 7
ps_qc_e = ncread(str7,strsqce);
ps_qc_r = ncread(str7,strsqcr);
d_qc_e = ncread(str7,strdqce);
d_qc_r = ncread(str7,strdqcr);
st_qc_e = ncread(str7,strtqce);
st_qc_r = ncread(str7,strtqcr);
p_qc_e = ncread(str7,strpqce);
p_qc_r = ncread(str7,strpqcr);
c_qc_e = ncread(str7,strcqce);
c_qc_r = ncread(str7,strcqcr);

time = ncread(str7,strtime);
temp = ncread(str7,strst);
salt = ncread(str7,strps);
dens = ncread(str7,strd);
pres = ncread(str7,strp);
lat = ncread(str7,strla);
lon = ncread(str7,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_250mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_250mA_dep3 GA_OOI_CTD_250mA_dep3 str_key str7
%% 

%% 8
ps_qc_e = ncread(str8,strsqce);
ps_qc_r = ncread(str8,strsqcr);
d_qc_e = ncread(str8,strdqce);
d_qc_r = ncread(str8,strdqcr);
st_qc_e = ncread(str8,strtqce);
st_qc_r = ncread(str8,strtqcr);
p_qc_e = ncread(str8,strpqce);
p_qc_r = ncread(str8,strpqcr);
c_qc_e = ncread(str8,strcqce);
c_qc_r = ncread(str8,strcqcr);

time = ncread(str8,strtime);
temp = ncread(str8,strst);
salt = ncread(str8,strps);
dens = ncread(str8,strd);
pres = ncread(str8,strp);
lat = ncread(str8,strla);
lon = ncread(str8,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);

depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);
 
len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_350mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_350mA_dep3 GA_OOI_CTD_350mA_dep3 str_key str1
%% 

%% 9
ps_qc_e = ncread(str9,strsqce);
ps_qc_r = ncread(str9,strsqcr);
d_qc_e = ncread(str9,strdqce);
d_qc_r = ncread(str9,strdqcr);
st_qc_e = ncread(str9,strtqce);
st_qc_r = ncread(str9,strtqcr);
p_qc_e = ncread(str9,strpqce);
p_qc_r = ncread(str9,strpqcr);
c_qc_e = ncread(str9,strcqce);
c_qc_r = ncread(str9,strcqcr);

time = ncread(str9,strtime);
temp = ncread(str9,strst);
salt = ncread(str9,strps);
dens = ncread(str9,strd);
pres = ncread(str9,strp);
lat = ncread(str9,strla);
lon = ncread(str9,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_500mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_500mA_dep3 GA_OOI_CTD_500mA_dep3 str_key str9
%% 

%% 10
ps_qc_e = ncread(str10,strsqce);
ps_qc_r = ncread(str10,strsqcr);
d_qc_e = ncread(str10,strdqce);
d_qc_r = ncread(str10,strdqcr);
st_qc_e = ncread(str10,strtqce);
st_qc_r = ncread(str10,strtqcr);
p_qc_e = ncread(str10,strpqce);
p_qc_r = ncread(str10,strpqcr);
c_qc_e = ncread(str10,strcqce);
c_qc_r = ncread(str10,strcqcr);

time = ncread(str10,strtime);
temp = ncread(str10,strst);
salt = ncread(str10,strps);
dens = ncread(str10,strd);
pres = ncread(str10,strp);
lat = ncread(str10,strla);
lon = ncread(str10,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_750mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_750mA_dep3 GA_OOI_CTD_750mA_dep3 str_key str2
%% 


%% 11
ps_qc_e = ncread(str11,strsqce);
ps_qc_r = ncread(str11,strsqcr);
d_qc_e = ncread(str11,strdqce);
d_qc_r = ncread(str11,strdqcr);
st_qc_e = ncread(str11,strtqce);
st_qc_r = ncread(str11,strtqcr);
p_qc_e = ncread(str11,strpqce);
p_qc_r = ncread(str11,strpqcr);
c_qc_e = ncread(str11,strcqce);
c_qc_r = ncread(str11,strcqcr);

time = ncread(str11,strtime);
temp = ncread(str11,strst);
salt = ncread(str11,strps);
dens = ncread(str11,strd);
pres = ncread(str11,strp);
lat = ncread(str11,strla);
lon = ncread(str11,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_1000mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_1000mA_dep3 GA_OOI_CTD_1000mA_dep3 str_key str3 
%% 

%% 12
ps_qc_e = ncread(str12,strsqce);
ps_qc_r = ncread(str12,strsqcr);
d_qc_e = ncread(str12,strdqce);
d_qc_r = ncread(str12,strdqcr);
st_qc_e = ncread(str12,strtqce);
st_qc_r = ncread(str12,strtqcr);
p_qc_e = ncread(str12,strpqce);
p_qc_r = ncread(str12,strpqcr);
c_qc_e = ncread(str12,strcqce);
c_qc_r = ncread(str12,strcqcr);

time = ncread(str12,strtime);
temp = ncread(str12,strst);
salt = ncread(str12,strps);
dens = ncread(str12,strd);
pres = ncread(str12,strp);
lat = ncread(str12,strla);
lon = ncread(str12,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_1500mA_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_1500mA_dep3 GA_OOI_CTD_1500mA_dep3 str_key str4
%% 

%% 13
ps_qc_e = ncread(str13,strsqce);
ps_qc_r = ncread(str13,strsqcr);
d_qc_e = ncread(str13,strdqce);
d_qc_r = ncread(str13,strdqcr);
st_qc_e = ncread(str13,strtqce);
st_qc_r = ncread(str13,strtqcr);
p_qc_e = ncread(str13,strpqce);
p_qc_r = ncread(str13,strpqcr);
c_qc_e = ncread(str13,strcqce);
c_qc_r = ncread(str13,strcqcr);

time = ncread(str13,strtime);
temp = ncread(str13,strst);
salt = ncread(str13,strps);
dens = ncread(str13,strd);
pres = ncread(str13,strp);
lat = ncread(str13,strla);
lon = ncread(str13,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_30mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_30mB_dep3 GA_OOI_CTD_30mB_dep3 str_key str13
%% 

%% 14
ps_qc_e = ncread(str14,strsqce);
ps_qc_r = ncread(str14,strsqcr);
d_qc_e = ncread(str14,strdqce);
d_qc_r = ncread(str14,strdqcr);
st_qc_e = ncread(str14,strtqce);
st_qc_r = ncread(str14,strtqcr);
p_qc_e = ncread(str14,strpqce);
p_qc_r = ncread(str14,strpqcr);
c_qc_e = ncread(str14,strcqce);
c_qc_r = ncread(str14,strcqcr);

time = ncread(str14,strtime);
temp = ncread(str14,strst);
salt = ncread(str14,strps);
dens = ncread(str14,strd);
pres = ncread(str14,strp);
lat = ncread(str14,strla);
lon = ncread(str14,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_40mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_40mB_dep3 GA_OOI_CTD_40mB_dep3 str_key str14
%% 

%% 15
ps_qc_e = ncread(str15,strsqce);
ps_qc_r = ncread(str15,strsqcr);
d_qc_e = ncread(str15,strdqce);
d_qc_r = ncread(str15,strdqcr);
st_qc_e = ncread(str15,strtqce);
st_qc_r = ncread(str15,strtqcr);
p_qc_e = ncread(str15,strpqce);
p_qc_r = ncread(str15,strpqcr);
c_qc_e = ncread(str15,strcqce);
c_qc_r = ncread(str15,strcqcr);

time = ncread(str15,strtime);
temp = ncread(str15,strst);
salt = ncread(str15,strps);
dens = ncread(str15,strd);
pres = ncread(str15,strp);
lat = ncread(str15,strla);
lon = ncread(str15,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_60mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_60mB_dep3 GA_OOI_CTD_60mB_dep3 str_key str15
%% 

%% 16
ps_qc_e = ncread(str16,strsqce);
ps_qc_r = ncread(str16,strsqcr);
d_qc_e = ncread(str16,strdqce);
d_qc_r = ncread(str16,strdqcr);
st_qc_e = ncread(str16,strtqce);
st_qc_r = ncread(str16,strtqcr);
p_qc_e = ncread(str16,strpqce);
p_qc_r = ncread(str16,strpqcr);
c_qc_e = ncread(str16,strcqce);
c_qc_r = ncread(str16,strcqcr);

time = ncread(str16,strtime);
temp = ncread(str16,strst);
salt = ncread(str16,strps);
dens = ncread(str16,strd);
pres = ncread(str16,strp);
lat = ncread(str16,strla);
lon = ncread(str16,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_90mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_90mB_dep3 GA_OOI_CTD_90mB_dep3 str_key str16
%% 

%% 17
ps_qc_e = ncread(str17,strsqce);
ps_qc_r = ncread(str17,strsqcr);
d_qc_e = ncread(str17,strdqce);
d_qc_r = ncread(str17,strdqcr);
st_qc_e = ncread(str17,strtqce);
st_qc_r = ncread(str17,strtqcr);
p_qc_e = ncread(str17,strpqce);
p_qc_r = ncread(str17,strpqcr);
c_qc_e = ncread(str17,strcqce);
c_qc_r = ncread(str17,strcqcr);

time = ncread(str17,strtime);
temp = ncread(str17,strst);
salt = ncread(str17,strps);
dens = ncread(str17,strd);
pres = ncread(str17,strp);
lat = ncread(str17,strla);
lon = ncread(str17,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_130mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_130mB_dep3 GA_OOI_CTD_130mB_dep3 str_key str17
%% 

%% 18
ps_qc_e = ncread(str18,strsqce);
ps_qc_r = ncread(str18,strsqcr);
d_qc_e = ncread(str18,strdqce);
d_qc_r = ncread(str18,strdqcr);
st_qc_e = ncread(str18,strtqce);
st_qc_r = ncread(str18,strtqcr);
p_qc_e = ncread(str18,strpqce);
p_qc_r = ncread(str18,strpqcr);
c_qc_e = ncread(str18,strcqce);
c_qc_r = ncread(str18,strcqcr);

time = ncread(str18,strtime);
temp = ncread(str18,strst);
salt = ncread(str18,strps);
dens = ncread(str18,strd);
pres = ncread(str18,strp);
lat = ncread(str18,strla);
lon = ncread(str18,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_180mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_180mB_dep3 GA_OOI_CTD_180mB_dep3 str_key str18
%% 

%% 19
ps_qc_e = ncread(str19,strsqce);
ps_qc_r = ncread(str19,strsqcr);
d_qc_e = ncread(str19,strdqce);
d_qc_r = ncread(str19,strdqcr);
st_qc_e = ncread(str19,strtqce);
st_qc_r = ncread(str19,strtqcr);
p_qc_e = ncread(str19,strpqce);
p_qc_r = ncread(str19,strpqcr);
c_qc_e = ncread(str19,strcqce);
c_qc_r = ncread(str19,strcqcr);

time = ncread(str19,strtime);
temp = ncread(str19,strst);
salt = ncread(str19,strps);
dens = ncread(str19,strd);
pres = ncread(str19,strp);
lat = ncread(str19,strla);
lon = ncread(str19,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_250mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_250mB_dep3 GA_OOI_CTD_250mB_dep3 str_key str19
%% 

%% 20
ps_qc_e = ncread(str20,strsqce);
ps_qc_r = ncread(str20,strsqcr);
d_qc_e = ncread(str20,strdqce);
d_qc_r = ncread(str20,strdqcr);
st_qc_e = ncread(str20,strtqce);
st_qc_r = ncread(str20,strtqcr);
p_qc_e = ncread(str20,strpqce);
p_qc_r = ncread(str20,strpqcr);
c_qc_e = ncread(str20,strcqce);
c_qc_r = ncread(str20,strcqcr);

time = ncread(str20,strtime);
temp = ncread(str20,strst);
salt = ncread(str20,strps);
dens = ncread(str20,strd);
pres = ncread(str20,strp);
lat = ncread(str20,strla);
lon = ncread(str20,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_350mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_350mB_dep3 GA_OOI_CTD_350mB_dep3 str_key str5
%% 

%% 21
ps_qc_e = ncread(str21,strsqce);
ps_qc_r = ncread(str21,strsqcr);
d_qc_e = ncread(str21,strdqce);
d_qc_r = ncread(str21,strdqcr);
st_qc_e = ncread(str21,strtqce);
st_qc_r = ncread(str21,strtqcr);
p_qc_e = ncread(str21,strpqce);
p_qc_r = ncread(str21,strpqcr);
c_qc_e = ncread(str21,strcqce);
c_qc_r = ncread(str21,strcqcr);

time = ncread(str21,strtime);
temp = ncread(str21,strst);
salt = ncread(str21,strps);
dens = ncread(str21,strd);
pres = ncread(str21,strp);
lat = ncread(str21,strla);
lon = ncread(str21,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_500mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_500mB_dep3 GA_OOI_CTD_500mB_dep3 str_key str21
%% 

%% 22
ps_qc_e = ncread(str22,strsqce);
ps_qc_r = ncread(str22,strsqcr);
d_qc_e = ncread(str22,strdqce);
d_qc_r = ncread(str22,strdqcr);
st_qc_e = ncread(str22,strtqce);
st_qc_r = ncread(str22,strtqcr);
p_qc_e = ncread(str22,strpqce);
p_qc_r = ncread(str22,strpqcr);
c_qc_e = ncread(str22,strcqce);
c_qc_r = ncread(str22,strcqcr);

time = ncread(str22,strtime);
temp = ncread(str22,strst);
salt = ncread(str22,strps);
dens = ncread(str22,strd);
pres = ncread(str22,strp);
lat = ncread(str22,strla);
lon = ncread(str22,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_750mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_750mB_dep3 GA_OOI_CTD_750mB_dep3 str_key str6
%% 

%% 23
ps_qc_e = ncread(str23,strsqce);
ps_qc_r = ncread(str23,strsqcr);
d_qc_e = ncread(str23,strdqce);
d_qc_r = ncread(str23,strdqcr);
st_qc_e = ncread(str23,strtqce);
st_qc_r = ncread(str23,strtqcr);
p_qc_e = ncread(str23,strpqce);
p_qc_r = ncread(str23,strpqcr);
c_qc_e = ncread(str23,strcqce);
c_qc_r = ncread(str23,strcqcr);

time = ncread(str23,strtime);
temp = ncread(str23,strst);
salt = ncread(str23,strps);
dens = ncread(str23,strd);
pres = ncread(str23,strp);
lat = ncread(str23,strla);
lon = ncread(str23,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_1000mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_1000mB_dep3 GA_OOI_CTD_1000mB_dep3 str_key str7
%% 

%% 24
ps_qc_e = ncread(str24,strsqce);
ps_qc_r = ncread(str24,strsqcr);
d_qc_e = ncread(str24,strdqce);
d_qc_r = ncread(str24,strdqcr);
st_qc_e = ncread(str24,strtqce);
st_qc_r = ncread(str24,strtqcr);
p_qc_e = ncread(str24,strpqce);
p_qc_r = ncread(str24,strpqcr);
c_qc_e = ncread(str24,strcqce);
c_qc_r = ncread(str24,strcqcr);

time = ncread(str24,strtime);
temp = ncread(str24,strst);
salt = ncread(str24,strps);
dens = ncread(str24,strd);
pres = ncread(str24,strp);
lat = ncread(str24,strla);
lon = ncread(str24,strlo);

QC = (ps_qc_e-ps_qc_r)+(d_qc_e-d_qc_r)+(st_qc_e-st_qc_r)+(p_qc_e-p_qc_r)+(c_qc_e-c_qc_r); 


len1 = length(QC);

time = time(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
temp = temp(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
salt = salt(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
dens = dens(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
pres = pres(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lat = lat(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
lon = lon(QC==0|QC==16|QC==32|QC==48|QC==64|QC==80);
depth = gsw_z_from_p(pres,lat);
time = acc_convert_time_20000101(time);

len2 = length(lon);
len_keep = len2 +len_keep;

fprintf('QC disqualified %g of %g total measurements \n \n',len1-len2,len1);

GA_OOI_CTD_1500mB_dep3 = [time,lat,lon,temp,salt,pres,dens,depth];

save GA_OOI_CTD_1500mB_dep3 GA_OOI_CTD_1500mB_dep3 str_key str24
%% 

fprintf('Total number of measurements to pass QC: %g \n \n',len_keep)

toc()