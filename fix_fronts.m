clear
close all
clc
tic()


load fronts_mitgcm

PF_12(:,227:512) = 0;
PF_6(:,111:260) = 0;
PF_3(:,58:132) = 0;
PF_12(1:107,52:230) = 0;
PF_12(1:240,99:230) = 0;
PF_6(1:55,30:120) = 0;
PF_6(1:139,50:120) = 0;
PF_3(1:29,18:60) = 0;
PF_3(1:48,26:60) = 0;
PF_12(625:645,125:145) = 1;

SAF_12(:,319:512) = 0;
SAF_6(:,178:260) = 0;
SAF_3(:,76:132) = 0;
SAF_12(1:66,59:330) = 0;
SAF_12(1:104,102:330) = 0;
SAF_6(1:35,30:180) = 0;
SAF_6(1:98,52:121) = 0;
SAF_6(1:74,117:180) = 0;
SAF_6(75:82,163:180) = 0;
SAF_6(82:90,171:180) = 0;
SAF_6(232:240,108:116) = 1;
SAF_6(357,210) = 0;
SAF_3(1:19,16:77) = 0;
SAF_3(1:48,28:77) = 0;
SAF_3(139:144,59:64) = 1;
SAF_12(1:194,103:225) = 0;
SAF_12(1:143,102:330) = 0;
SAF_12(124:141,64:77) = 1;
SAF_12(82:110,35:64) = 1;
SAF_12(728:738,246:257) = 1;
SAF_12(437:485,209:238) = 1;
SAF_12(222:243,177:210) = 1;
SAF_12(220:240,122:135) = 0;
SAF_12(255:256,136:137) = 0;


save fronts_mitgcm



toc()