function [value] = f(x)
%function f(x) defined approximately by 1/cosh(ln(x)/2.403))
%used to find resistivity through Van Der Pauw method
value = (cosh(log(x)/2.403)).^(-1); 