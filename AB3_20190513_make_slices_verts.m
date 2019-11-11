
%% 32

tfield32 = 1;
sfield32 = 2;
wfield32 = 5;
ufield32 = 3;
vfield32 = 4;
tffield32 = 1;
sffield32 = 2;
cfield32 = 3;
ofield32 = 4;
efield32 = 1;
mfield32 = 4;
dfield32 = 1;
afield32 = 2;
agfield32 = 9;
pcfield32 = 2;
no3field32 = 4;
o2field32 = 3;

slice_index = 57;

THETA_Series_vert_32 = zeros(192,132,395);
DIC_Series_vert_32 = zeros(192,132,395);
O2_Series_vert_32 = zeros(192,132,395);
NO3_Series_vert_32 = zeros(192,132,395);

THETA_Series_vert_t32 = zeros(192,132,395);
DIC_Series_vert_t32 = zeros(192,132,395);
O2_Series_vert_t32 = zeros(192,132,395);
NO3_Series_vert_t32 = zeros(192,132,395);

THETA_Series_vert100_t32 = zeros(192,132,395);
DIC_Series_vert100_t32 = zeros(192,132,395);
O2_Series_vert100_t32 = zeros(192,132,395);
NO3_Series_vert100_t32 = zeros(192,132,395);

THETA_Series_slice_32 = zeros(132,52,395);
SALT_Series_slice_32 = zeros(132,52,395);
WVEL_Series_slice_32 = zeros(132,52,395);
UVEL_Series_slice_32 = zeros(132,52,395);
VVEL_Series_slice_32 = zeros(132,52,395);
DIC_Series_slice_32 = zeros(132,52,395);
ALK_Series_slice_32 = zeros(132,52,395);
O2_Series_slice_32 = zeros(132,52,395);
NO3_Series_slice_32 = zeros(132,52,395);
TFLUX_Series_slice_32 = zeros(132,395);
SFLUX_Series_slice_32 = zeros(132,395);
CFLUX_Series_slice_32 = zeros(132,395);
OFLUX_Series_slice_32 = zeros(132,395);
ETAN_Series_slice_32 = zeros(132,395);
MLD_Series_slice_32 = zeros(132,395);
PCO2_Series_slice_32 = zeros(132,395);

HC = rdmds('../MITgcm/verification/SO3_20190513/run/hFacC');
DRF_temp = rdmds('../MITgcm/verification/SO3_20190513/run/DRF');
[mm,nn,pp] = size(HC);
DRF = zeros(1,1,pp);
DRF(1,1,:) = DRF_temp;
clear DRF_temp;
Volume = zeros(mm,nn,pp);

for ii=1:mm
    for jj=1:nn
        Volume(ii,jj,:) = HC(ii,jj,:).*DRF;
    end
end

Height = sum(Volume,3);

depth32 = 1;
str = '../MITgcm/verification/SO3_20190513/diag_slice/';

for ii=1:2
    char32state = [str,'diag_state.00000000',num2str(48*ii)];
    temp32state = rdmds(char32state);
    THETA_Series_vert_t32(:,:,ii) = sum(temp32state(:,:,:,tfield32).*Volume,3);
    THETA_Series_vert100_t32(:,:,ii) = sum(temp32state(:,:,1:12,tfield32).*Volume(:,:,1:12),3);
    THETA_Series_vert_32(:,:,ii) = THETA_Series_vert_t32(:,:,ii)./Height;
    THETA_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,tfield32);
    SALT_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,sfield32);
    WVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,wfield32);
    UVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,ufield32);
    VVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,vfield32);
    clear temp32state
    char32surf = [str,'diag_surf.00000000',num2str(48*ii)];
    temp32surf = rdmds(char32surf); 
    ETAN_Series_slice_32(:,ii) = temp32surf(slice_index,:,efield32); 
    MLD_Series_slice_32(:,ii) = temp32surf(slice_index,:,mfield32);
    PCO2_Series_slice_32(:,ii) = temp32surf(slice_index,:,pcfield32);
    clear temp32surf
    char32airsea = [str,'diag_airsea.00000000',num2str(48*ii)];
    temp32airsea = rdmds(char32airsea); 
    TFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,tffield32);
    SFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,sffield32);
    CFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,cfield32);
    OFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,ofield32);
    clear temp32airsea
    char32bgc = [str,'diag_bgc.00000000',num2str(48*ii)];
    temp32bgc = rdmds(char32bgc); 
    DIC_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,dfield32);
    ALK_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,afield32);
    O2_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,o2field32);
    NO3_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,no3field32);
    DIC_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,dfield32).*Volume,3);
    DIC_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,dfield32).*Volume(:,:,1:12),3);
    DIC_Series_vert_32(:,:,ii) = DIC_Series_vert_t32(:,:,ii)./Height;
    O2_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,o2field32).*Volume,3);
    O2_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,o2field32).*Volume(:,:,1:12),3);
    O2_Series_vert_32(:,:,ii) = O2_Series_vert_t32(:,:,ii)./Height;
    NO3_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,no3field32).*Volume,3);
    NO3_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,no3field32).*Volume(:,:,1:12),3);
    NO3_Series_vert_32(:,:,ii) = NO3_Series_vert_t32(:,:,ii)./Height;
    clear temp32bgc
end

for ii=3:20
    char32state = [str,'diag_state.0000000',num2str(48*ii)];
    temp32state = rdmds(char32state);
    THETA_Series_vert_t32(:,:,ii) = sum(temp32state(:,:,:,tfield32).*Volume,3);
    THETA_Series_vert100_t32(:,:,ii) = sum(temp32state(:,:,1:12,tfield32).*Volume(:,:,1:12),3);
    THETA_Series_vert_32(:,:,ii) = THETA_Series_vert_t32(:,:,ii)./Height;
    THETA_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,tfield32);
    SALT_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,sfield32);
    WVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,wfield32);
    UVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,ufield32);
    VVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,vfield32);
    clear temp32state
    char32surf = [str,'diag_surf.0000000',num2str(48*ii)];
    temp32surf = rdmds(char32surf); 
    ETAN_Series_slice_32(:,ii) = temp32surf(slice_index,:,efield32); 
    MLD_Series_slice_32(:,ii) = temp32surf(slice_index,:,mfield32);
    PCO2_Series_slice_32(:,ii) = temp32surf(slice_index,:,pcfield32);
    clear temp32surf
    char32airsea = [str,'diag_airsea.0000000',num2str(48*ii)];
    temp32airsea = rdmds(char32airsea); 
    TFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,tffield32);
    SFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,sffield32);
    CFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,cfield32);
    OFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,ofield32);
    clear temp32airsea
    char32bgc = [str,'diag_bgc.0000000',num2str(48*ii)];
    temp32bgc = rdmds(char32bgc); 
    DIC_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,dfield32);
    ALK_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,afield32);
    O2_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,o2field32);
    NO3_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,no3field32);
    DIC_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,dfield32).*Volume,3);
    DIC_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,dfield32).*Volume(:,:,1:12),3);
    DIC_Series_vert_32(:,:,ii) = DIC_Series_vert_t32(:,:,ii)./Height;
    O2_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,o2field32).*Volume,3);
    O2_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,o2field32).*Volume(:,:,1:12),3);
    O2_Series_vert_32(:,:,ii) = O2_Series_vert_t32(:,:,ii)./Height;
    NO3_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,no3field32).*Volume,3);
    NO3_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,no3field32).*Volume(:,:,1:12),3);
    NO3_Series_vert_32(:,:,ii) = NO3_Series_vert_t32(:,:,ii)./Height;
    clear temp32bgc
end

for ii=21:208
    char32state = [str,'diag_state.000000',num2str(48*ii)];
    temp32state = rdmds(char32state);
    THETA_Series_vert_t32(:,:,ii) = sum(temp32state(:,:,:,tfield32).*Volume,3);
    THETA_Series_vert100_t32(:,:,ii) = sum(temp32state(:,:,1:12,tfield32).*Volume(:,:,1:12),3);
    THETA_Series_vert_32(:,:,ii) = THETA_Series_vert_t32(:,:,ii)./Height;
    THETA_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,tfield32);
    SALT_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,sfield32);
    WVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,wfield32);
    UVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,ufield32);
    VVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,vfield32);
    clear temp32state
    char32surf = [str,'diag_surf.000000',num2str(48*ii)];
    temp32surf = rdmds(char32surf); 
    ETAN_Series_slice_32(:,ii) = temp32surf(slice_index,:,efield32); 
    MLD_Series_slice_32(:,ii) = temp32surf(slice_index,:,mfield32);
    PCO2_Series_slice_32(:,ii) = temp32surf(slice_index,:,pcfield32);
    clear temp32surf
    char32airsea = [str,'diag_airsea.000000',num2str(48*ii)];
    temp32airsea = rdmds(char32airsea); 
    TFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,tffield32);
    SFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,sffield32);
    CFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,cfield32);
    OFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,ofield32);
    clear temp32airsea
    char32bgc = [str,'diag_bgc.000000',num2str(48*ii)];
    temp32bgc = rdmds(char32bgc); 
    DIC_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,dfield32);
    ALK_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,afield32);
    O2_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,o2field32);
    NO3_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,no3field32);
    DIC_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,dfield32).*Volume,3);
    DIC_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,dfield32).*Volume(:,:,1:12),3);
    DIC_Series_vert_32(:,:,ii) = DIC_Series_vert_t32(:,:,ii)./Height;
    O2_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,o2field32).*Volume,3);
    O2_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,o2field32).*Volume(:,:,1:12),3);
    O2_Series_vert_32(:,:,ii) = O2_Series_vert_t32(:,:,ii)./Height;
    NO3_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,no3field32).*Volume,3);
    NO3_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,no3field32).*Volume(:,:,1:12),3);
    NO3_Series_vert_32(:,:,ii) = NO3_Series_vert_t32(:,:,ii)./Height;
    clear temp32bgc
end

for ii=209:395
    char32state = [str,'diag_state.00000',num2str(48*ii)];
    temp32state = rdmds(char32state);
    THETA_Series_vert_t32(:,:,ii) = sum(temp32state(:,:,:,tfield32).*Volume,3);
    THETA_Series_vert100_t32(:,:,ii) = sum(temp32state(:,:,1:12,tfield32).*Volume(:,:,1:12),3);
    THETA_Series_vert_32(:,:,ii) = THETA_Series_vert_t32(:,:,ii)./Height;
    THETA_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,tfield32);
    SALT_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,sfield32);
    WVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,wfield32);
    UVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,ufield32);
    VVEL_Series_slice_32(:,:,ii) = temp32state(slice_index,:,:,vfield32);
    clear temp32state
    char32surf = [str,'diag_surf.00000',num2str(48*ii)];
    temp32surf = rdmds(char32surf); 
    ETAN_Series_slice_32(:,ii) = temp32surf(slice_index,:,efield32); 
    MLD_Series_slice_32(:,ii) = temp32surf(slice_index,:,mfield32);
    PCO2_Series_slice_32(:,ii) = temp32surf(slice_index,:,pcfield32);
    clear temp32surf
    char32airsea = [str,'diag_airsea.00000',num2str(48*ii)];
    temp32airsea = rdmds(char32airsea); 
    TFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,tffield32);
    SFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,sffield32);
    CFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,cfield32);
    OFLUX_Series_slice_32(:,ii) = temp32airsea(slice_index,:,ofield32);
    clear temp32airsea
    char32bgc = [str,'diag_bgc.00000',num2str(48*ii)];
    temp32bgc = rdmds(char32bgc); 
    DIC_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,dfield32);
    ALK_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,afield32);
    O2_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,o2field32);
    NO3_Series_slice_32(:,:,ii) = temp32bgc(slice_index,:,:,no3field32);
    DIC_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,dfield32).*Volume,3);
    DIC_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,dfield32).*Volume(:,:,1:12),3);
    DIC_Series_vert_32(:,:,ii) = DIC_Series_vert_t32(:,:,ii)./Height;
    O2_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,o2field32).*Volume,3);
    O2_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,o2field32).*Volume(:,:,1:12),3);
    O2_Series_vert_32(:,:,ii) = O2_Series_vert_t32(:,:,ii)./Height;
    NO3_Series_vert_t32(:,:,ii) = sum(temp32bgc(:,:,:,no3field32).*Volume,3);
    NO3_Series_vert100_t32(:,:,ii) = sum(temp32bgc(:,:,1:12,no3field32).*Volume(:,:,1:12),3);
    NO3_Series_vert_32(:,:,ii) = NO3_Series_vert_t32(:,:,ii)./Height;
    clear temp32bgc
end

for ii=1:132
    if (HC(slice_index,ii,1)==0)
        ETAN_Series_slice_32(ii,:) = NaN;
        MLD_Series_slice_32(ii,:) = NaN;
        PCO2_Series_slice_32(ii,:) = NaN;
        TFLUX_Series_slice_32(ii,:) = NaN;
        OFLUX_Series_slice_32(ii,:) = NaN;
        CFLUX_Series_slice_32(ii,:) = NaN;
        SFLUX_Series_slice_32(ii,:) = NaN;
    end
end

parfor ii=1:192
    for jj=1:132
        if (HC(ii,jj,1)==0)
            THETA_Series_vert_32(ii,jj,:) = NaN;
            THETA_Series_vert_t32(ii,jj,:) = NaN;
            THETA_Series_vert100_t32(ii,jj,:) = NaN;
            DIC_Series_vert_32(ii,jj,:) = NaN;
            DIC_Series_vert_t32(ii,jj,:) = NaN;
            DIC_Series_vert100_t32(ii,jj,:) = NaN;
            O2_Series_vert_32(ii,jj,:) = NaN;
            O2_Series_vert_t32(ii,jj,:) = NaN;
            O2_Series_vert100_t32(ii,jj,:) = NaN;
            NO3_Series_vert_32(ii,jj,:) = NaN;
            NO3_Series_vert_t32(ii,jj,:) = NaN;
            NO3_Series_vert100_t32(ii,jj,:) = NaN;
        end
    end
end


THETA_32_DJF_slice_avg = mean(THETA_Series_slice_32(:,:,1:91),3);
SALT_32_DJF_slice_avg = mean(SALT_Series_slice_32(:,:,1:91),3);
WVEL_32_DJF_slice_avg = mean(WVEL_Series_slice_32(:,:,1:91),3);
WVEL_32_DJF_slice_std = std(WVEL_Series_slice_32(:,:,1:91),0,3);
UVEL_32_DJF_slice_avg = mean(UVEL_Series_slice_32(:,:,1:91),3);
UVEL_32_DJF_slice_std = std(UVEL_Series_slice_32(:,:,1:91),0,3);
VVEL_32_DJF_slice_avg = mean(VVEL_Series_slice_32(:,:,1:91),3);
VVEL_32_DJF_slice_std = std(VVEL_Series_slice_32(:,:,1:91),0,3);
DIC_32_DJF_slice_avg = mean(DIC_Series_slice_32(:,:,1:91),3);
ALK_32_DJF_slice_avg = mean(ALK_Series_slice_32(:,:,1:91),3);
O2_32_DJF_slice_avg = mean(O2_Series_slice_32(:,:,1:91),3);
NO3_32_DJF_slice_avg = mean(NO3_Series_slice_32(:,:,1:91),3);
ETAN_32_DJF_slice_avg = mean(ETAN_Series_slice_32(:,1:91),2);
MLD_32_DJF_slice_avg = mean(MLD_Series_slice_32(:,1:91),2);
PCO2_32_DJF_slice_avg = mean(PCO2_Series_slice_32(:,1:91),2);
TFLUX_32_DJF_slice_avg = mean(TFLUX_Series_slice_32(:,1:91),2);
SFLUX_32_DJF_slice_avg = mean(SFLUX_Series_slice_32(:,1:91),2);
CFLUX_32_DJF_slice_avg = mean(CFLUX_Series_slice_32(:,1:91),2);
OFLUX_32_DJF_slice_avg = mean(OFLUX_Series_slice_32(:,1:91),2);
THETA_32_DJF_vert_avg = mean(THETA_Series_vert_32(:,:,1:91),3);
THETA_32_DJF_tvert_avg = mean(THETA_Series_vert_t32(:,:,1:91),3);
THETA_32_DJF_vert100_avg = mean(THETA_Series_vert100_t32(:,:,1:91),3);
DIC_32_DJF_vert_avg = mean(DIC_Series_vert_32(:,:,1:91),3);
DIC_32_DJF_tvert_avg = mean(DIC_Series_vert_t32(:,:,1:91),3);
DIC_32_DJF_vert100_avg = mean(DIC_Series_vert100_t32(:,:,1:91),3);
O2_32_DJF_vert_avg = mean(O2_Series_vert_32(:,:,1:91),3);
O2_32_DJF_tvert_avg = mean(O2_Series_vert_t32(:,:,1:91),3);
O2_32_DJF_vert100_avg = mean(O2_Series_vert100_t32(:,:,1:91),3);
NO3_32_DJF_vert_avg = mean(NO3_Series_vert_32(:,:,1:91),3);
NO3_32_DJF_tvert_avg = mean(NO3_Series_vert_t32(:,:,1:91),3);
NO3_32_DJF_vert100_avg = mean(NO3_Series_vert100_t32(:,:,1:91),3);

THETA_32_JFM_slice_avg = mean(THETA_Series_slice_32(:,:,32:122),3);
SALT_32_JFM_slice_avg = mean(SALT_Series_slice_32(:,:,32:122),3);
WVEL_32_JFM_slice_avg = mean(WVEL_Series_slice_32(:,:,32:122),3);
WVEL_32_JFM_slice_std = std(WVEL_Series_slice_32(:,:,32:122),0,3);
UVEL_32_JFM_slice_avg = mean(UVEL_Series_slice_32(:,:,32:122),3);
UVEL_32_JFM_slice_std = std(UVEL_Series_slice_32(:,:,32:122),0,3);
VVEL_32_JFM_slice_avg = mean(VVEL_Series_slice_32(:,:,32:122),3);
VVEL_32_JFM_slice_std = std(VVEL_Series_slice_32(:,:,32:122),0,3);
DIC_32_JFM_slice_avg = mean(DIC_Series_slice_32(:,:,32:122),3);
ALK_32_JFM_slice_avg = mean(ALK_Series_slice_32(:,:,32:122),3);
O2_32_JFM_slice_avg = mean(O2_Series_slice_32(:,:,32:122),3);
NO3_32_JFM_slice_avg = mean(NO3_Series_slice_32(:,:,32:122),3);
ETAN_32_JFM_slice_avg = mean(ETAN_Series_slice_32(:,32:122),2);
MLD_32_JFM_slice_avg = mean(MLD_Series_slice_32(:,32:122),2);
PCO2_32_JFM_slice_avg = mean(PCO2_Series_slice_32(:,32:122),2);
TFLUX_32_JFM_slice_avg = mean(TFLUX_Series_slice_32(:,32:122),2);
SFLUX_32_JFM_slice_avg = mean(SFLUX_Series_slice_32(:,32:122),2);
CFLUX_32_JFM_slice_avg = mean(CFLUX_Series_slice_32(:,32:122),2);
OFLUX_32_JFM_slice_avg = mean(OFLUX_Series_slice_32(:,32:122),2);
THETA_32_JFM_vert_avg = mean(THETA_Series_vert_32(:,:,32:122),3);
THETA_32_JFM_tvert_avg = mean(THETA_Series_vert_t32(:,:,32:122),3);
THETA_32_JFM_vert100_avg = mean(THETA_Series_vert100_t32(:,:,32:122),3);
DIC_32_JFM_vert_avg = mean(DIC_Series_vert_32(:,:,32:122),3);
DIC_32_JFM_tvert_avg = mean(DIC_Series_vert_t32(:,:,32:122),3);
DIC_32_JFM_vert100_avg = mean(DIC_Series_vert100_t32(:,:,32:122),3);
O2_32_JFM_vert_avg = mean(O2_Series_vert_32(:,:,32:122),3);
O2_32_JFM_tvert_avg = mean(O2_Series_vert_t32(:,:,32:122),3);
O2_32_JFM_vert100_avg = mean(O2_Series_vert100_t32(:,:,32:122),3);
NO3_32_JFM_vert_avg = mean(NO3_Series_vert_32(:,:,32:122),3);
NO3_32_JFM_tvert_avg = mean(NO3_Series_vert_t32(:,:,32:122),3);
NO3_32_JFM_vert100_avg = mean(NO3_Series_vert100_t32(:,:,32:122),3); 

THETA_32_DJFMAM_slice_avg = mean(THETA_Series_slice_32(:,:,1:182),3);
SALT_32_DJFMAM_slice_avg = mean(SALT_Series_slice_32(:,:,1:182),3);
WVEL_32_DJFMAM_slice_avg = mean(WVEL_Series_slice_32(:,:,1:182),3);
WVEL_32_DJFMAM_slice_std = std(WVEL_Series_slice_32(:,:,1:182),0,3);
UVEL_32_DJFMAM_slice_avg = mean(UVEL_Series_slice_32(:,:,1:182),3);
UVEL_32_DJFMAM_slice_std = std(UVEL_Series_slice_32(:,:,1:182),0,3);
VVEL_32_DJFMAM_slice_avg = mean(VVEL_Series_slice_32(:,:,1:182),3);
VVEL_32_DJFMAM_slice_std = std(VVEL_Series_slice_32(:,:,1:182),0,3);
DIC_32_DJFMAM_slice_avg = mean(DIC_Series_slice_32(:,:,1:182),3);
ALK_32_DJFMAM_slice_avg = mean(ALK_Series_slice_32(:,:,1:182),3);
O2_32_DJFMAM_slice_avg = mean(O2_Series_slice_32(:,:,1:182),3);
NO3_32_DJFMAM_slice_avg = mean(NO3_Series_slice_32(:,:,1:182),3);
ETAN_32_DJFMAM_slice_avg = mean(ETAN_Series_slice_32(:,1:182),2);
MLD_32_DJFMAM_slice_avg = mean(MLD_Series_slice_32(:,1:182),2);
PCO2_32_DJFMAM_slice_avg = mean(PCO2_Series_slice_32(:,1:182),2);
TFLUX_32_DJFMAM_slice_avg = mean(TFLUX_Series_slice_32(:,1:182),2);
SFLUX_32_DJFMAM_slice_avg = mean(SFLUX_Series_slice_32(:,1:182),2);
CFLUX_32_DJFMAM_slice_avg = mean(CFLUX_Series_slice_32(:,1:182),2);
OFLUX_32_DJFMAM_slice_avg = mean(OFLUX_Series_slice_32(:,1:182),2);
THETA_32_DJFMAM_vert_avg = mean(THETA_Series_vert_32(:,:,1:182),3);
THETA_32_DJFMAM_tvert_avg = mean(THETA_Series_vert_t32(:,:,1:182),3);
THETA_32_DJFMAM_vert100_avg = mean(THETA_Series_vert100_t32(:,:,1:182),3);
DIC_32_DJFMAM_vert_avg = mean(DIC_Series_vert_32(:,:,1:182),3);
DIC_32_DJFMAM_tvert_avg = mean(DIC_Series_vert_t32(:,:,1:182),3);
DIC_32_DJFMAM_vert100_avg = mean(DIC_Series_vert100_t32(:,:,1:182),3);
O2_32_DJFMAM_vert_avg = mean(O2_Series_vert_32(:,:,1:182),3);
O2_32_DJFMAM_tvert_avg = mean(O2_Series_vert_t32(:,:,1:182),3);
O2_32_DJFMAM_vert100_avg = mean(O2_Series_vert100_t32(:,:,1:182),3);
NO3_32_DJFMAM_vert_avg = mean(NO3_Series_vert_32(:,:,1:182),3);
NO3_32_DJFMAM_tvert_avg = mean(NO3_Series_vert_t32(:,:,1:182),3);
NO3_32_DJFMAM_vert100_avg = mean(NO3_Series_vert100_t32(:,:,1:182),3); 

THETA_32_JFMAMJ_slice_avg = mean(THETA_Series_slice_32(:,:,32:213),3);
SALT_32_JFMAMJ_slice_avg = mean(SALT_Series_slice_32(:,:,32:213),3);
WVEL_32_JFMAMJ_slice_avg = mean(WVEL_Series_slice_32(:,:,32:213),3);
WVEL_32_JFMAMJ_slice_std = std(WVEL_Series_slice_32(:,:,32:213),0,3);
UVEL_32_JFMAMJ_slice_avg = mean(UVEL_Series_slice_32(:,:,32:213),3);
UVEL_32_JFMAMJ_slice_std = std(UVEL_Series_slice_32(:,:,32:213),0,3);
VVEL_32_JFMAMJ_slice_avg = mean(VVEL_Series_slice_32(:,:,32:213),3);
VVEL_32_JFMAMJ_slice_std = std(VVEL_Series_slice_32(:,:,32:213),0,3);
DIC_32_JFMAMJ_slice_avg = mean(DIC_Series_slice_32(:,:,32:213),3);
ALK_32_JFMAMJ_slice_avg = mean(ALK_Series_slice_32(:,:,32:213),3);
O2_32_JFMAMJ_slice_avg = mean(O2_Series_slice_32(:,:,32:213),3);
NO3_32_JFMAMJ_slice_avg = mean(NO3_Series_slice_32(:,:,32:213),3);
ETAN_32_JFMAMJ_slice_avg = mean(ETAN_Series_slice_32(:,32:213),2);
MLD_32_JFMAMJ_slice_avg = mean(MLD_Series_slice_32(:,32:213),2);
PCO2_32_JFMAMJ_slice_avg = mean(PCO2_Series_slice_32(:,32:213),2);
TFLUX_32_JFMAMJ_slice_avg = mean(TFLUX_Series_slice_32(:,32:213),2);
SFLUX_32_JFMAMJ_slice_avg = mean(SFLUX_Series_slice_32(:,32:213),2);
CFLUX_32_JFMAMJ_slice_avg = mean(CFLUX_Series_slice_32(:,32:213),2);
OFLUX_32_JFMAMJ_slice_avg = mean(OFLUX_Series_slice_32(:,32:213),2);
THETA_32_JFMAMJ_vert_avg = mean(THETA_Series_vert_32(:,:,32:213),3);
THETA_32_JFMAMJ_tvert_avg = mean(THETA_Series_vert_t32(:,:,32:213),3);
THETA_32_JFMAMJ_vert100_avg = mean(THETA_Series_vert100_t32(:,:,32:213),3);
DIC_32_JFMAMJ_vert_avg = mean(DIC_Series_vert_32(:,:,32:213),3);
DIC_32_JFMAMJ_tvert_avg = mean(DIC_Series_vert_t32(:,:,32:213),3);
DIC_32_JFMAMJ_vert100_avg = mean(DIC_Series_vert100_t32(:,:,32:213),3);
O2_32_JFMAMJ_vert_avg = mean(O2_Series_vert_32(:,:,32:213),3);
O2_32_JFMAMJ_tvert_avg = mean(O2_Series_vert_t32(:,:,32:213),3);
O2_32_JFMAMJ_vert100_avg = mean(O2_Series_vert100_t32(:,:,32:213),3);
NO3_32_JFMAMJ_vert_avg = mean(NO3_Series_vert_32(:,:,32:213),3);
NO3_32_JFMAMJ_tvert_avg = mean(NO3_Series_vert_t32(:,:,32:213),3);
NO3_32_JFMAMJ_vert100_avg = mean(NO3_Series_vert100_t32(:,:,32:213),3); 

THETA_32_DN_slice_avg = mean(THETA_Series_slice_32(:,:,1:364),3);
SALT_32_DN_slice_avg = mean(SALT_Series_slice_32(:,:,1:364),3);
WVEL_32_DN_slice_avg = mean(WVEL_Series_slice_32(:,:,1:364),3);
WVEL_32_DN_slice_std = std(WVEL_Series_slice_32(:,:,1:364),0,3);
UVEL_32_DN_slice_avg = mean(UVEL_Series_slice_32(:,:,1:364),3);
UVEL_32_DN_slice_std = std(UVEL_Series_slice_32(:,:,1:364),0,3);
VVEL_32_DN_slice_avg = mean(VVEL_Series_slice_32(:,:,1:364),3);
VVEL_32_DN_slice_std = std(VVEL_Series_slice_32(:,:,1:364),0,3);
DIC_32_DN_slice_avg = mean(DIC_Series_slice_32(:,:,1:364),3);
ALK_32_DN_slice_avg = mean(ALK_Series_slice_32(:,:,1:364),3);
O2_32_DN_slice_avg = mean(O2_Series_slice_32(:,:,1:364),3);
NO3_32_DN_slice_avg = mean(NO3_Series_slice_32(:,:,1:364),3);
ETAN_32_DN_slice_avg = mean(ETAN_Series_slice_32(:,1:364),2);
MLD_32_DN_slice_avg = mean(MLD_Series_slice_32(:,1:364),2);
PCO2_32_DN_slice_avg = mean(PCO2_Series_slice_32(:,1:364),2);
TFLUX_32_DN_slice_avg = mean(TFLUX_Series_slice_32(:,1:364),2);
SFLUX_32_DN_slice_avg = mean(SFLUX_Series_slice_32(:,1:364),2);
CFLUX_32_DN_slice_avg = mean(CFLUX_Series_slice_32(:,1:364),2);
OFLUX_32_DN_slice_avg = mean(OFLUX_Series_slice_32(:,1:364),2);
THETA_32_DN_vert_avg = mean(THETA_Series_vert_32(:,:,1:364),3);
THETA_32_DN_tvert_avg = mean(THETA_Series_vert_t32(:,:,1:364),3);
THETA_32_DN_vert100_avg = mean(THETA_Series_vert100_t32(:,:,1:364),3);
DIC_32_DN_vert_avg = mean(DIC_Series_vert_32(:,:,1:364),3);
DIC_32_DN_tvert_avg = mean(DIC_Series_vert_t32(:,:,1:364),3);
DIC_32_DN_vert100_avg = mean(DIC_Series_vert100_t32(:,:,1:364),3);
O2_32_DN_vert_avg = mean(O2_Series_vert_32(:,:,1:364),3);
O2_32_DN_tvert_avg = mean(O2_Series_vert_t32(:,:,1:364),3);
O2_32_DN_vert100_avg = mean(O2_Series_vert100_t32(:,:,1:364),3);
NO3_32_DN_vert_avg = mean(NO3_Series_vert_32(:,:,1:364),3);
NO3_32_DN_tvert_avg = mean(NO3_Series_vert_t32(:,:,1:364),3);
NO3_32_DN_vert100_avg = mean(NO3_Series_vert100_t32(:,:,1:364),3); 

THETA_32_JD_slice_avg = mean(THETA_Series_slice_32(:,:,32:395),3);
SALT_32_JD_slice_avg = mean(SALT_Series_slice_32(:,:,32:395),3);
WVEL_32_JD_slice_avg = mean(WVEL_Series_slice_32(:,:,32:395),3);
WVEL_32_JD_slice_std = std(WVEL_Series_slice_32(:,:,32:395),0,3);
UVEL_32_JD_slice_avg = mean(UVEL_Series_slice_32(:,:,32:395),3);
UVEL_32_JD_slice_std = std(UVEL_Series_slice_32(:,:,32:395),0,3);
VVEL_32_JD_slice_avg = mean(VVEL_Series_slice_32(:,:,32:395),3);
VVEL_32_JD_slice_std = std(VVEL_Series_slice_32(:,:,32:395),0,3);
DIC_32_JD_slice_avg = mean(DIC_Series_slice_32(:,:,32:395),3);
ALK_32_JD_slice_avg = mean(ALK_Series_slice_32(:,:,32:395),3);
O2_32_JD_slice_avg = mean(O2_Series_slice_32(:,:,32:395),3);
NO3_32_JD_slice_avg = mean(NO3_Series_slice_32(:,:,32:395),3);
ETAN_32_JD_slice_avg = mean(ETAN_Series_slice_32(:,32:395),2);
MLD_32_JD_slice_avg = mean(MLD_Series_slice_32(:,32:395),2);
PCO2_32_JD_slice_avg = mean(PCO2_Series_slice_32(:,32:395),2);
TFLUX_32_JD_slice_avg = mean(TFLUX_Series_slice_32(:,32:395),2);
SFLUX_32_JD_slice_avg = mean(SFLUX_Series_slice_32(:,32:395),2);
CFLUX_32_JD_slice_avg = mean(CFLUX_Series_slice_32(:,32:395),2);
OFLUX_32_JD_slice_avg = mean(OFLUX_Series_slice_32(:,32:395),2);
THETA_32_JD_vert_avg = mean(THETA_Series_vert_32(:,:,32:395),3);
THETA_32_JD_tvert_avg = mean(THETA_Series_vert_t32(:,:,32:395),3);
THETA_32_JD_vert100_avg = mean(THETA_Series_vert100_t32(:,:,32:395),3);
DIC_32_JD_vert_avg = mean(DIC_Series_vert_32(:,:,32:395),3);
DIC_32_JD_tvert_avg = mean(DIC_Series_vert_t32(:,:,32:395),3);
DIC_32_JD_vert100_avg = mean(DIC_Series_vert100_t32(:,:,32:395),3);
O2_32_JD_vert_avg = mean(O2_Series_vert_32(:,:,32:395),3);
O2_32_JD_tvert_avg = mean(O2_Series_vert_t32(:,:,32:395),3);
O2_32_JD_vert100_avg = mean(O2_Series_vert100_t32(:,:,32:395),3);
NO3_32_JD_vert_avg = mean(NO3_Series_vert_32(:,:,32:395),3);
NO3_32_JD_tvert_avg = mean(NO3_Series_vert_t32(:,:,32:395),3);
NO3_32_JD_vert100_avg = mean(NO3_Series_vert100_t32(:,:,32:395),3); 

[m32,n32] = size(THETA_32_DJF_slice_avg);

parfor ii=1:m32
    for jj=1:n32
        if (HC(slice_index,ii,jj)==0)
            THETA_Series_slice_32(ii,jj,:) = NaN;
            SALT_Series_slice_32(ii,jj,:) = NaN;
            WVEL_Series_slice_32(ii,jj,:) = NaN;
            UVEL_Series_slice_32(ii,jj,:) = NaN;
            VVEL_Series_slice_32(ii,jj,:) = NaN;
            DIC_Series_slice_32(ii,jj,:) = NaN;
            ALK_Series_slice_32(ii,jj,:) = NaN;
            O2_Series_slice_32(ii,jj,:) = NaN;
            NO3_Series_slice_32(ii,jj,:) = NaN;
            
            THETA_32_DJF_slice_avg(ii,jj) = NaN;
            SALT_32_DJF_slice_avg(ii,jj) = NaN;
            DIC_32_DJF_slice_avg(ii,jj) = NaN;
            ALK_32_DJF_slice_avg(ii,jj) = NaN;
            WVEL_32_DJF_slice_avg(ii,jj) = NaN;
            VVEL_32_DJF_slice_avg(ii,jj) = NaN;
            UVEL_32_DJF_slice_avg(ii,jj) = NaN;
            O2_32_DJF_slice_avg(ii,jj) = NaN;
            NO3_32_DJF_slice_avg(ii,jj) = NaN;
            
            THETA_32_JFM_slice_avg(ii,jj) = NaN;
            SALT_32_JFM_slice_avg(ii,jj) = NaN;
            DIC_32_JFM_slice_avg(ii,jj) = NaN;
            ALK_32_JFM_slice_avg(ii,jj) = NaN;
            WVEL_32_JFM_slice_avg(ii,jj) = NaN;
            VVEL_32_JFM_slice_avg(ii,jj) = NaN;
            UVEL_32_JFM_slice_avg(ii,jj) = NaN;
            O2_32_JFM_slice_avg(ii,jj) = NaN;
            NO3_32_JFM_slice_avg(ii,jj) = NaN;
            
            THETA_32_DJFMAM_slice_avg(ii,jj) = NaN;
            SALT_32_DJFMAM_slice_avg(ii,jj) = NaN;
            DIC_32_DJFMAM_slice_avg(ii,jj) = NaN;
            ALK_32_DJFMAM_slice_avg(ii,jj) = NaN;
            WVEL_32_DJFMAM_slice_avg(ii,jj) = NaN;
            VVEL_32_DJFMAM_slice_avg(ii,jj) = NaN;
            UVEL_32_DJFMAM_slice_avg(ii,jj) = NaN;
            O2_32_DJFMAM_slice_avg(ii,jj) = NaN;
            NO3_32_DJFMAM_slice_avg(ii,jj) = NaN;
            
            THETA_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            SALT_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            DIC_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            ALK_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            WVEL_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            VVEL_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            UVEL_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            O2_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            NO3_32_JFMAMJ_slice_avg(ii,jj) = NaN;
            
            THETA_32_DN_slice_avg(ii,jj) = NaN;
            SALT_32_DN_slice_avg(ii,jj) = NaN;
            DIC_32_DN_slice_avg(ii,jj) = NaN;
            ALK_32_DN_slice_avg(ii,jj) = NaN;
            WVEL_32_DN_slice_avg(ii,jj) = NaN;
            VVEL_32_DN_slice_avg(ii,jj) = NaN;
            UVEL_32_DN_slice_avg(ii,jj) = NaN;
            O2_32_DN_slice_avg(ii,jj) = NaN;
            NO3_32_DN_slice_avg(ii,jj) = NaN;
            
            THETA_32_JD_slice_avg(ii,jj) = NaN;
            SALT_32_JD_slice_avg(ii,jj) = NaN;
            DIC_32_JD_slice_avg(ii,jj) = NaN;
            ALK_32_JD_slice_avg(ii,jj) = NaN;
            WVEL_32_JD_slice_avg(ii,jj) = NaN;
            VVEL_32_JD_slice_avg(ii,jj) = NaN;
            UVEL_32_JD_slice_avg(ii,jj) = NaN;
            O2_32_JD_slice_avg(ii,jj) = NaN;
            NO3_32_JD_slice_avg(ii,jj) = NaN;
        end
    end
end


clear char32* temp32* n32 m32 *field32 ii jj

save AB32_output_THETA_slice_vert THETA*
save AB32_output_SALT_slice_vert SALT*
save AB32_output_WVEL_slice_vert WVEL*
save AB32_output_VVEL_slice_vert VVEL*
save AB32_output_UVEL_slice_vert UVEL*
save AB32_output_O2_slice_vert O2*
save AB32_output_NO3_slice_vert NO3*
save AB32_output_DIC_slice_vert DIC*
save AB32_output_ALK_slice_vert ALK*
save AB32_output_ETAN_slice_vert ETAN*
save AB32_output_MLD_slice_vert MLD*
save AB32_output_PCO2_slice_vert PCO2*
save AB32_output_TFLUX_slice_vert TFLUX*
save AB32_output_CFLUX_slice_vert CFLUX*
save AB32_output_SFLUX_slice_vert SFLUX*
save AB32_output_OFLUX_slice_vert OFLUX*

fprintf('finished 32 \n')

%% end 32


