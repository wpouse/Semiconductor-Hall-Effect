close all
%Positive field measurements, forward then reverse
R_AC_BD = VoltageBD(1:3:end)./samplecurrentAC(1:3:end);
R_BD_CA = VoltageAC(1:3:end)./samplecurrentBD(1:3:end);
R_H_prop = (R_AC_BD+R_BD_CA)./BFieldGauss(1:3:end);
R_H = -1.25*.5*R_H_prop*10;
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

title('Hall Coefficient');
xlabel('Temperature (K)'); ylabel('Hall Coefficient m^3/C');
legend('Positive B-field', 'Zero B-field', 'Negative B-field');