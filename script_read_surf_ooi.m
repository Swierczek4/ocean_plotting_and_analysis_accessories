clear
close all
clc

tic()

etan_ooia_32sample = zeros(9491,1);
etan_ooib_32sample = zeros(9491,1);
etan_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',10);
etan_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    etan_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',13);
etan_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    etan_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',16);
etan_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    etan_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except etan*

save ETAN_OOI_32

pco2_ooia_32sample = zeros(9491,1);
pco2_ooib_32sample = zeros(9491,1);
pco2_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',20);
pco2_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    pco2_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',23);
pco2_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    pco2_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',26);
pco2_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    pco2_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except pco2*

save PCO2_OOI_32

phibot_ooia_32sample = zeros(9491,1);
phibot_ooib_32sample = zeros(9491,1);
phibot_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',30);
phibot_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    phibot_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',33);
phibot_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    phibot_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',36);
phibot_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    phibot_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except phibot*

save PHIBOT_OOI_32

o2sat_ooia_32sample = zeros(9491,1);
o2sat_ooib_32sample = zeros(9491,1);
o2sat_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',40);
o2sat_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    o2sat_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',43);
o2sat_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    o2sat_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',46);
o2sat_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    o2sat_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except o2sat*

save O2SAT_OOI_32

mld_ooia_32sample = zeros(9491,1);
mld_ooib_32sample = zeros(9491,1);
mld_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',50);
mld_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    mld_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',53);
mld_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    mld_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_surf_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',56);
mld_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:50
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    mld_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except mld*

save MLD_OOI_32

tflux_ooia_32sample = zeros(9491,1);
tflux_ooib_32sample = zeros(9491,1);
tflux_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',10);
tflux_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    tflux_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',13);
tflux_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    tflux_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',16);
tflux_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    tflux_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except tflux*

save TFLUX_OOI_32

sflux_ooia_32sample = zeros(9491,1);
sflux_ooib_32sample = zeros(9491,1);
sflux_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',20);
sflux_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    sflux_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',23);
sflux_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    sflux_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',26);
sflux_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    sflux_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except sflux*

save SFLUX_OOI_32

cflux_ooia_32sample = zeros(9491,1);
cflux_ooib_32sample = zeros(9491,1);
cflux_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',30);
cflux_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    cflux_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',33);
cflux_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    cflux_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',36);
cflux_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    cflux_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except cflux*

save CFLUX_OOI_32

oflux_ooia_32sample = zeros(9491,1);
oflux_ooib_32sample = zeros(9491,1);
oflux_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',40);
oflux_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    oflux_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',43);
oflux_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    oflux_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',46);
oflux_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    oflux_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except oflux*

save OFLUX_OOI_32

taux_ooia_32sample = zeros(9491,1);
taux_ooib_32sample = zeros(9491,1);
taux_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',50);
taux_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    taux_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',53);
taux_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    taux_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',56);
taux_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    taux_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except taux*

save TAUX_OOI_32


tauy_ooia_32sample = zeros(9491,1);
tauy_ooib_32sample = zeros(9491,1);
tauy_ooip_32sample = zeros(9491,1);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',60);
tauy_ooia_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    tauy_ooia_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);


counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',63);
tauy_ooib_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    tauy_ooib_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

counter = 1;

fid = fopen('diag_airsea_ooi.0000000000.txt');
results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',66);
tauy_ooip_32sample(counter) = results{1};
counter = 2;

for jj=1:9489
    for ii=1:60
        fgets(fid);
    end
    results = textscan(fid, ' %*u %f %*f %*f %*f %*f', 1,'headerlines',0);
    tauy_ooip_32sample(counter) = results{1};
    counter = counter + 1;
end

fclose(fid);

clearvars -except tauy*

save TAUY_OOI_32

toc()