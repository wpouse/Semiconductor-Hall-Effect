close all

electron_charge = 1.602 *10^(-19); %in C

pos_indices = 1:3:length(TemperatureK);
zero_indices = 2:3:length(TemperatureK);
neg_indices = 3:3:length(TemperatureK);

%Positive field measurements, forward then reverse
R_AC_BD = (VoltageBD./samplecurrentAC + VoltageBD1./samplecurrentAC1)./2;
R_BD_CA = (VoltageAC./samplecurrentBD + VoltageAC1./samplecurrentBD1)./2;

R_H_prop = (R_AC_BD + R_BD_CA)./BFieldGauss;
R_H = -1.25*.5*R_H_prop;
figure(1)
plt_scatter(R_H, 'pos', 'reg', TemperatureK)
%hold on
%plt_scatter(R_H, 'zero', 'reg', TemperatureK)
%plt_scatter(R_H, 'neg', 'reg', TemperatureK)

%{
R_AC_BD_pos = VoltageBD(1:3:end)./samplecurrentAC(1:3:end);
R_BD_CA_pos = VoltageAC(1:3:end)./samplecurrentBD(1:3:end);
R_H_prop = (R_AC_BD_pos+R_BD_CA_pos)./BFieldGauss(1:3:end);
R_H_pos = -1.25*.5*R_H_prop*10;
figure(1)
scatter(TemperatureK(1:3:end),R_H);
hold on
R_H(46)

R_CA_DB = VoltageBD1(1:3:end)./samplecurrentAC1(1:3:end);
R_DB_AC = VoltageAC1(1:3:end)./samplecurrentBD1(1:3:end);
R_H_prop1 = (R_CA_DB+R_DB_AC)./BFieldGauss(1:3:end);
R_H1 = -1.25*.5*R_H_prop1*10;
R_H1(46)
%for right units, 1 Gauss = 10^-4 tesla, and d = 1.25mm = 1.25*10^-3 m so
%extra multiplication by 10 needed

%zero field measurements

R_AC_BD_zero = VoltageBD(2:3:end)./samplecurrentAC(2:3:end);
R_BD_CA_zero = VoltageAC(2:3:end)./samplecurrentBD(2:3:end);
R_H_prop_zero = (R_AC_BD_zero+R_BD_CA_zero)./BFieldGauss(2:3:end);
R_H_zero = -1.25*.5*R_H_prop_zero*10;
scatter(TemperatureK(2:3:end),R_H_zero);

%negative field measurements
R_AC_BD_neg = VoltageBD(3:3:end)./samplecurrentAC(3:3:end);
R_BD_CA_neg = VoltageAC(3:3:end)./samplecurrentBD(3:3:end);
R_H_prop_neg = (R_AC_BD_neg+R_BD_CA_neg)./BFieldGauss(3:3:end);
R_H_neg = -1.25*.5*R_H_prop*10;
scatter(TemperatureK(3:3:end),R_H_neg);
R_H_neg(46)

R_CA_DB_neg = VoltageBD1(3:3:end)./samplecurrentAC1(3:3:end);
R_DB_AC_neg = VoltageAC1(3:3:end)./samplecurrentBD1(3:3:end);
R_H_prop1_neg = (R_CA_DB_neg+R_DB_AC_neg)./BFieldGauss(3:3:end);
R_H1_neg = -1.25*.5*R_H_prop1_neg*10;
R_H1_neg(46)
%}

title('Hall Coefficient');
xlabel('Temperature (K)'); ylabel('Hall Coefficient m^3/C');
%legend('Positive B-field', 'Zero B-field', 'Negative B-field');

figure(2)
%Resistivity positive field
%{
R_AB_CD_pos = VoltageCD(1:3:end)./samplecurrentAB(1:3:end);
R_AB_CD_pos1 = VoltageCD1(1:3:end)./samplecurrentAB1(1:3:end);
R_AB_CD_pos_avg = (R_AB_CD_pos + R_AB_CD_pos1)./2

R_AD_CB_pos = VoltageBC(1:3:end)./samplecurrentAD(1:3:end);
R_AD_CB_pos1 = VoltageBC1(1:3:end)./samplecurrentAD1(1:3:end);
R_AD_CB_pos_avg = (R_AD_CB_pos + R_AD_CB_pos1)./2
%}

R_AB_CD = (VoltageCD./samplecurrentAB + VoltageCD1./samplecurrentAB1)./2;
R_AD_CB = (VoltageBC./samplecurrentAD + VoltageBC1./samplecurrentAD1)./2;
%resistivity_pos = real(pi*1.25*10^-3 /log(2) *.5 * (R_AB_CD_pos_avg+R_AD_CB_pos_avg).*f(R_AB_CD_pos_avg./R_AD_CB_pos_avg));
%scatter(1./TemperatureK(1:3:end), resistivity);
resistivity = real(pi*1.25*10^-3 /log(2) *.5 * (R_AB_CD+R_AD_CB).*f(R_AB_CD./R_AD_CB));
conductivity = 1./resistivity;

plt_scatter(resistivity, 'pos', 'inv', TemperatureK)
hold on
plt_scatter(resistivity, 'zero', 'inv', TemperatureK)
plt_scatter(resistivity, 'neg', 'inv', TemperatureK)
title('Resistivity')
xlabel('Inverse Temperature (1/K)')
ylabel('Resistivity (Ohm*m)')

hole_density = -1./(electron_charge*R_H); %in final use averages of pos/neg polarity

hole_mobility = 1./(resistivity .* hole_density * electron_charge); %from eq 15 in lab manual (assumes p >> n)

figure(3)
plt_scatter(hole_density, 'pos', 'reg', TemperatureK)
%hold on
%plt_scatter(hole_density, 'zero', 'reg', TemperatureK)
%plt_scatter(hole_density, 'neg', 'reg', TemperatureK)
title('Hole Concentration')
xlabel('Temperature (K)')
ylabel('Hole density (1/m^3)')
%hole_drift_velocity = hole_mobility*

figure(4)
plt_scatter(hole_mobility, 'pos', 'reg', TemperatureK)
%hold on
%plt_scatter(hole_mobility, 'zero', 'reg', TemperatureK)
%plt_scatter(hole_mobility, 'neg', 'reg', TemperatureK)
title('Hole Mobility')
xlabel('Temperature (K)')
ylabel('Hole Mobility (1/Gauss)')

figure(5)
plt_scatter(conductivity, 'pos', 'inv', TemperatureK)
%hold on
%plt_scatter(conductivity, 'zero', 'inv', TemperatureK)
%plt_scatter(conductivity, 'neg', 'inv', TemperatureK)
xlabel('Inverse Temperature (1/K)')
ylabel('Conductivity (1/Ohm*m)')
title('Conductivity')

