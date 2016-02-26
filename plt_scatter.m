function plt_scatter(data, B_field_sign, temp_scale, TemperatureK)
%plots data from SHE measurements. b_field_sign = 'pos', 'neg', or 'zero'
%to plot the data from positive, negative, or zero b field measurements.
%temp_scale is 'norm' or 'inv' to plot against T or 1/T

if strcmp(B_field_sign, 'pos')
    indices = 1:3:length(TemperatureK);
elseif strcmp(B_field_sign, 'zero')
    indices = 2:3:length(TemperatureK);
elseif strcmp(B_field_sign, 'neg')
    indices = 3:3:length(TemperatureK);
end

if strcmp(temp_scale, 'inv')
    temp = 1./TemperatureK;
else
    temp = TemperatureK;
end

scatter(temp(indices), data(indices))