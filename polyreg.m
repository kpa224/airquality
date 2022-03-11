clc 
close all
clear 

A = xlsread('air_quality_2.xls', 1); 

% import ozone concentration(output) 
%1=radiation,2=No2,3=NO,4=CO,5=PM10,6=O3
n = A(:,6);
no= A(:,3);
no2=A(:,2);
co=A(:,4);
%clear A;
%figure; plot (n)

%dividing dataset

y_cal = n(1:565); %4 yrs data for calibration
y_val = n(566: 848); %2 years data for validation

clear n;

nox_cal = no(1:565)+no2(1:565);
nox_val = no(566:848)+no2(566:848);
clear no;

co_cal = co(1:565);
co_val = co(566:848);
clear co;


X = [ nox_cal(1:end), co_cal(1:end), nox_cal(1:end).*co_cal(1:end), nox_cal(1:end).*nox_cal(1:end), ones(length(y_cal),1)] ; 
Y = y_cal(1:end) ;
theta=X\Y;
Y= X*theta;
R2cal = 1 - sum( (y_cal( 1 : end) - Y( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(length(y_val),1)).^2);
figure; plot([y_cal Y]);
%
X = [ nox_val(1:end), co_val(1:end), nox_val(1:end).*co_val(1:end), nox_val(1:end).*nox_val(1:end), ones(length(y_val),1)] ; 
Y= X*theta;
%
R2val = 1 - sum( (y_val( 1 : end) - Y( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(length(y_val),1)).^2);
figure; plot([y_val Y]); 

%% may

A = xlsread('air_quality_2.xls', 2);
% import ozone concentration(output) 
%1=radiation,2=No2,3=NO,4=CO,5=PM10,6=O3
n = A(:,6);
no= A(:,3);
no2=A(:,2);
co=A(:,4);
rad=A(:,1);
pm=A(:,5);
%clear A;
%figure; plot (n)

%dividing dataset
y_cal = n(1:122); %4 yrs data for calibration
y_val = n(123:181); %2 years data for validation
clear n;

nox_cal = no(1:122)+no2(1:122);
nox_val = no(123:181)+no2(123:181);
clear no;

co_cal = co(1:122);
co_val = co(123:181);
clear co;

X = [ nox_cal(1:end), co_cal(1:end), nox_cal(1:end).*co_cal(1:end), nox_cal(1:end).*nox_cal(1:end), ones(length(y_cal),1)] ; 
Y = y_cal(1:end) ;
theta=X\Y;
Y= X*theta;
R2calmay = 1 - sum( (y_cal( 1 : end) - Y( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(length(y_val),1)).^2);
figure; plot([y_cal Y]);
%
X = [ nox_val(1:end), co_val(1:end), nox_val(1:end).*co_val(1:end), nox_val(1:end).*nox_val(1:end), ones(length(y_val),1)] ; 
Yval= X*theta;
%
R2valmay = 1 - sum( (y_val( 1 : end) - Yval( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(length(y_val),1)).^2);
figure; plot([y_val Yval]); 