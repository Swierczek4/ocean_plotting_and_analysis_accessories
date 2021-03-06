clear
close all
clc

tic()
acc_settings

str1 = 'deployment0001_GA02HYPM-WFP02-03-DOSTAL000-recovered_wfp-dosta_ln_wfp_instrument_recovered_20150317T090905-20151114T231515.nc';
str2 = 'deployment0001_GA02HYPM-WFP03-03-DOSTAL000-recovered_wfp-dosta_ln_wfp_instrument_recovered_20150316T230204-20151115T143145.nc';
str3 = 'deployment0002_GA02HYPM-WFP02-03-DOSTAL000-recovered_wfp-dosta_ln_wfp_instrument_recovered_20151117T000205-20161104T160956.nc';
str4 = 'deployment0002_GA02HYPM-WFP03-03-DOSTAL000-recovered_wfp-dosta_ln_wfp_instrument_recovered_20151117T040206-20161104T200957.nc';
str5 = 'deployment0003_GA02HYPM-WFP02-03-DOSTAL000-recovered_wfp-dosta_ln_wfp_instrument_recovered_20161030T000204-20171003T185635.nc';
str6 = 'deployment0003_GA02HYPM-WFP03-03-DOSTAL000-recovered_wfp-dosta_ln_wfp_instrument_recovered_20161030T040206-20171225T092805.nc';

str7 = 'ctdpf_ckl_seawater_temperature';
str8 = 'optode_temperature_qc_executed';
str9 = 'optode_temperature_qc_results';

str10 = 'dissolved_oxygen';
str11 = 'dissolved_oxygen_qc_executed';
str12 = 'dissolved_oxygen_qc_results';

str13 = 'estimated_oxygen_concentration';
str14 = 'estimated_oxygen_concentration_qc_executed';
str15 = 'estimated_oxygen_concentration_qc_results';

str16 = 'practical_salinity';
str17 = 'int_ctd_pressure';

% QC_type = ncread(str1,str8);
% QC_type(1:20)
% 
% dec2bin(QC_type(1:20))
% 
% QC_result = ncread(str1,str9);
% QC_result(1:20)

Full_Array = zeros(1398821,7);

%% file 1
T_QC_ex = ncread(str1,str8);
T_QC_res = ncread(str1,str9);
DO_QC_ex = ncread(str1,str11);
DO_QC_res = ncread(str1,str12);
EOC_QC_ex = ncread(str1,str14);
EOC_QC_res = ncread(str1,str15);
DO = ncread(str1,str10);
EOC = ncread(str1,str13);
T = ncread(str1,str7);
S = ncread(str1,str16);
P = ncread(str1,str17);
lat = ncread(str1,'lat');
lon = ncread(str1,'lon');
my_time = ncread(str1,'time');

QC = (DO_QC_ex-DO_QC_res)+(EOC_QC_ex-EOC_QC_res)+(T_QC_ex-T_QC_res);

lat = lat(QC==0);
lon = lon(QC==0);
max_lon = max(lon);
min_lon = min(lon);
max_lat = max(lat);
min_lat = min(lat);
P = P(QC==0);
T = T(QC==0);
S = S(QC==0);
DO = DO(QC==0);
EOC = EOC(QC==0);
my_time = my_time(QC==0);
my_time = acc_convert_time_19000101(my_time);
L1 = length(S);
fprintf('number of obs in 1st deployment: %g \n',L1);
depth = gsw_z_from_p(P,lat);

Full_Array(1:L1,:) = [my_time,T,S,P,DO,EOC,depth];
%% end file 1

%% file 2
T_QC_ex = ncread(str2,str8);
T_QC_res = ncread(str2,str9);
DO_QC_ex = ncread(str2,str11);
DO_QC_res = ncread(str2,str12);
EOC_QC_ex = ncread(str2,str14);
EOC_QC_res = ncread(str2,str15);
DO = ncread(str2,str10);
EOC = ncread(str2,str13);
T = ncread(str2,str7);
S = ncread(str2,str16);
P = ncread(str2,str17);
lat = ncread(str2,'lat');
lon = ncread(str2,'lon');
my_time = ncread(str2,'time');

QC = (DO_QC_ex-DO_QC_res)+(EOC_QC_ex-EOC_QC_res)+(T_QC_ex-T_QC_res);

lat = lat(QC==0);
lon = lon(QC==0);
if max(lon)>max_lon
    max_lon = max(lon);
end
if min(lon)<min_lon
    min_lon = min(lon);
end
if max(lat)>max_lat
    max_lat = max(lat);
end
if min(lat)<min_lat
    min_lat = min(lat);
end
P = P(QC==0);
T = T(QC==0);
S = S(QC==0);
DO = DO(QC==0);
EOC = EOC(QC==0);
my_time = my_time(QC==0);
my_time = acc_convert_time_19000101(my_time);
L2 = length(S);
fprintf('number of obs in 1st deployment: %g \n',L2);
depth = gsw_z_from_p(P,lat);

Full_Array((L1+1):(L1+L2),:) = [my_time,T,S,P,DO,EOC,depth];
L1 = L1 + L2;
%% end file 2

%% file 3
T_QC_ex = ncread(str3,str8);
T_QC_res = ncread(str3,str9);
DO_QC_ex = ncread(str3,str11);
DO_QC_res = ncread(str3,str12);
EOC_QC_ex = ncread(str3,str14);
EOC_QC_res = ncread(str3,str15);
DO = ncread(str3,str10);
EOC = ncread(str3,str13);
T = ncread(str3,str7);
S = ncread(str3,str16);
P = ncread(str3,str17);
lat = ncread(str3,'lat');
lon = ncread(str3,'lon');
my_time = ncread(str3,'time');

QC = (DO_QC_ex-DO_QC_res)+(EOC_QC_ex-EOC_QC_res)+(T_QC_ex-T_QC_res);

lat = lat(QC==0);
lon = lon(QC==0);
if max(lon)>max_lon
    max_lon = max(lon);
end
if min(lon)<min_lon
    min_lon = min(lon);
end
if max(lat)>max_lat
    max_lat = max(lat);
end
if min(lat)<min_lat
    min_lat = min(lat);
end
P = P(QC==0);
T = T(QC==0);
S = S(QC==0);
DO = DO(QC==0);
EOC = EOC(QC==0);
my_time = my_time(QC==0);
my_time = acc_convert_time_19000101(my_time);
L3 = length(S);
fprintf('number of obs in 2nd deployment: %g \n',L3);
depth = gsw_z_from_p(P,lat);

Full_Array((L1+1):(L1+L3),:) = [my_time,T,S,P,DO,EOC,depth];
L1 = L1 + L3;
%% end file 3

%% file 4
T_QC_ex = ncread(str4,str8);
T_QC_res = ncread(str4,str9);
DO_QC_ex = ncread(str4,str11);
DO_QC_res = ncread(str4,str12);
EOC_QC_ex = ncread(str4,str14);
EOC_QC_res = ncread(str4,str15);
DO = ncread(str4,str10);
EOC = ncread(str4,str13);
T = ncread(str4,str7);
S = ncread(str4,str16);
P = ncread(str4,str17);
lat = ncread(str4,'lat');
lon = ncread(str4,'lon');
my_time = ncread(str4,'time');

QC = (DO_QC_ex-DO_QC_res)+(EOC_QC_ex-EOC_QC_res)+(T_QC_ex-T_QC_res);

lat = lat(QC==0);
lon = lon(QC==0);
if max(lon)>max_lon
    max_lon = max(lon);
end
if min(lon)<min_lon
    min_lon = min(lon);
end
if max(lat)>max_lat
    max_lat = max(lat);
end
if min(lat)<min_lat
    min_lat = min(lat);
end
P = P(QC==0);
T = T(QC==0);
S = S(QC==0);
DO = DO(QC==0);
EOC = EOC(QC==0);
my_time = my_time(QC==0);
my_time = acc_convert_time_19000101(my_time);
L4 = length(S);
fprintf('number of obs in 2nd deployment: %g \n',L4);
depth = gsw_z_from_p(P,lat);

Full_Array((L1+1):(L1+L4),:) = [my_time,T,S,P,DO,EOC,depth];
L1 = L1 + L4;
%% end file 4

%% file 5
T_QC_ex = ncread(str5,str8);
T_QC_res = ncread(str5,str9);
DO_QC_ex = ncread(str5,str11);
DO_QC_res = ncread(str5,str12);
EOC_QC_ex = ncread(str5,str14);
EOC_QC_res = ncread(str5,str15);
DO = ncread(str5,str10);
EOC = ncread(str5,str13);
T = ncread(str5,str7);
S = ncread(str5,str16);
P = ncread(str5,str17);
lat = ncread(str5,'lat');
lon = ncread(str5,'lon');
my_time = ncread(str5,'time');

QC = (DO_QC_ex-DO_QC_res)+(EOC_QC_ex-EOC_QC_res)+(T_QC_ex-T_QC_res);

lat = lat(QC==0);
lon = lon(QC==0);
if max(lon)>max_lon
    max_lon = max(lon);
end
if min(lon)<min_lon
    min_lon = min(lon);
end
if max(lat)>max_lat
    max_lat = max(lat);
end
if min(lat)<min_lat
    min_lat = min(lat);
end
P = P(QC==0);
T = T(QC==0);
S = S(QC==0);
DO = DO(QC==0);
EOC = EOC(QC==0);
my_time = my_time(QC==0);
my_time = acc_convert_time_19000101(my_time);
L5 = length(S);
fprintf('number of obs in 3rd deployment: %g \n',L5);
depth = gsw_z_from_p(P,lat);

Full_Array((L1+1):(L1+L5),:) = [my_time,T,S,P,DO,EOC,depth];
L1 = L1 + L5;
%% end file 5

%% file 6
T_QC_ex = ncread(str6,str8);
T_QC_res = ncread(str6,str9);
DO_QC_ex = ncread(str6,str11);
DO_QC_res = ncread(str6,str12);
EOC_QC_ex = ncread(str6,str14);
EOC_QC_res = ncread(str6,str15);
DO = ncread(str6,str10);
EOC = ncread(str6,str13);
T = ncread(str6,str7);
S = ncread(str6,str16);
P = ncread(str6,str17);
lat = ncread(str6,'lat');
lon = ncread(str6,'lon');
my_time = ncread(str6,'time');

QC = (DO_QC_ex-DO_QC_res)+(EOC_QC_ex-EOC_QC_res)+(T_QC_ex-T_QC_res);

lat = lat(QC==0);
lon = lon(QC==0);
if max(lon)>max_lon
    max_lon = max(lon);
end
if min(lon)<min_lon
    min_lon = min(lon);
end
if max(lat)>max_lat
    max_lat = max(lat);
end
if min(lat)<min_lat
    min_lat = min(lat);
end
P = P(QC==0);
T = T(QC==0);
S = S(QC==0);
DO = DO(QC==0);
EOC = EOC(QC==0);
my_time = my_time(QC==0);
my_time = acc_convert_time_19000101(my_time);
L6 = length(S);
fprintf('number of obs in 3rd deployment: %g \n',L6);
depth = gsw_z_from_p(P,lat);

Full_Array((L1+1):(L1+L6),:) = [my_time,T,S,P,DO,EOC,depth];
L1 = L1 + L6;
%% end file 6







