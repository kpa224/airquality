%% Exercise 16 Air quality surrogate model
% Carol Segenti Kushagra Pandey
%% import data, define variables
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
rad=A(:,1);
pm=A(:,5);
%clear A;
%figure; plot (n)

%dividing dataset
y_cal = n(1:565); %4 yrs data for calibration
[ mi , m ] = moving_average( y_cal , length(y_cal) , 5 ); % moving average of streamflow
y_val = n(566: 848); %2 years data for validation

clear n;

no_cal = no(1:565);
no_val = no(566:848);
clear no;

no2_cal = no2(1:565);
no2_val = no2(566:848);
clear no2

co_cal = co(1:565);
co_val = co(566:848);
clear co;

rad_cal = rad(1:565); 
rad_val = rad(566:848);
clear rad;

pm_cal = pm(1:565);
pm_val = pm(566:848);
clear rad;


% I opt to use an ANN Artificial Neural Network
% define input and target vectors
%input vector has NO,NO2,CO,solar radiance
X = [ no_cal(1:end) no2_cal(1:end) co_cal(1:end) rad_cal(1:end) pm_cal(1:end)]' ; 
Y = y_cal(1:end)' ;

N_runs= 20;
R_i =zeros(N_runs,1);
for i = 1:N_runs
    net_i= newff(X, Y, 4);
    net_i= train( net_i, X, Y);
    Y_ =sim(net_i,X )';
    R_i(i) = 1 - sum( (y_cal( 1 : end) - Y_( 1 : end)).^2) / sum((y_cal( 1: end )- mean(y_cal( 1: end))*ones(565,1)).^2);
    if R_i(i) >= max(R_i)
        net_opt = net_i;
    end
end
R_cal(1)=max(R_i);

% validation on ANN 

% define input and output on validation dataset
X_val = [no_val(1:end) no2_val(1:end) co_val(1:end) rad_val(1:end) pm_val(1:end)]';
Y_val = y_val(1:end)';

% predict output and reaseasonalize
Y_val_= sim(net_opt, X_val);
Y_val_=Y_val_';
%mean square error and the coef of determination

e = y_val( 1  : end ) - Y_val_( 1 : end );
figure ; plot(e);
Q = mean( e.^2 ); %mean square error
% coefficient of determintation R2
R2 = 1 - sum( (y_val( 1 : end) - Y_val_( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(283,1)).^2); 
R_val(1)= R2;
figure;
plot([y_val, Y_val_]); legend('Y', 'g');

%% 
%Maggio
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

no_cal = no(1:122);
no_val = no(123:181);
clear no;

no2_cal = no2(1:122);
no2_val = no2(123:181);
clear no2

co_cal = co(1:122);
co_val = co(123:181);
clear co;

rad_cal = rad(1:122); 
rad_val = rad(123:181);
clear rad;

pm_cal = pm(1:122);
pm_val = pm(123:181);
clear rad;


% I opt to use an ANN Artificial Neural Network
% define input and target vectors
%input vector has NO,NO2,CO,solar radiance
X = [ no_cal(1:end) no2_cal(1:end) co_cal(1:end) rad_cal(1:end) pm_cal(1:end)]' ; 
Y = y_cal(1:end)' ;

N_runs= 20;
R_i =zeros(N_runs,1);
for i = 1:N_runs
    net_i= newff(X, Y, 4);
    net_i= train( net_i, X, Y);
    Y_ =sim(net_i,X )';
    R_i(i) = 1 - sum( (y_cal( 1 : end) - Y_( 1 : end)).^2) / sum((y_cal( 1: end )- mean(y_cal( 1: end))*ones(122,1)).^2);
    if R_i(i) >= max(R_i)
        net_opt = net_i;
    end
end

R_cal(2)=max(R_i);
%validation on ANN 

% define input and output on validation dataset
X_val = [no_val(1:end) no2_val(1:end) co_val(1:end) rad_val(1:end) pm_val(1:end)]';
Y_val = y_val(1:end)';

% predict output and reaseasonalize
Y_val_= sim(net_opt, X_val);
Y_val_=Y_val_';
%mean square error and the coef of determination

e = y_val( 1  : end ) - Y_val_( 1 : end );
%figure ; plot(e);
Q = mean( e.^2 ); %mean square error

R2 = 1 - sum( (y_val( 1 : end) - Y_val_( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(59,1)).^2);
R_val(2)= R2;
figure; plot([y_val, Y_val_]); legend('Y', 'g');
%% Giugno
A = xlsread('air_quality_2.xls', 3);
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
y_cal = n(1:103); %4 yrs data for calibration
y_val = n(104:157); %2 years data for validation
clear n;

no_cal = no(1:103);
no_val = no(104:157);
clear no;

no2_cal = no2(1:103);
no2_val = no2(104:157);
clear no2

co_cal = co(1:103);
co_val = co(104:157);
clear co;

rad_cal = rad(1:103); 
rad_val = rad(104:157);
clear rad;

pm_cal = pm(1:103);
pm_val = pm(104:157);
clear rad;


% I opt to use an ANN Artificial Neural Network
% define input and target vectors
%input vector has NO,NO2,CO,solar radiance
X = [ no_cal(1:end) no2_cal(1:end) co_cal(1:end) rad_cal(1:end) pm_cal(1:end)]' ; 
Y = y_cal(1:end)' ;

N_runs= 20;
R_i =zeros(N_runs,1);
for i = 1:N_runs
    net_i= newff(X, Y, 4);
    net_i= train( net_i, X, Y);
    Y_ =sim(net_i,X )';
    R_i(i) = 1 - sum( (y_cal( 1 : end) - Y_( 1 : end)).^2) / sum((y_cal( 1: end )- mean(y_cal( 1: end))*ones(103,1)).^2);
    if R_i(i) >= max(R_i)
        net_opt = net_i;
    end
end

R_cal(3)=max(R_i);

% validation on ANN 

% define input and output on validation dataset
X_val = [no_val(1:end) no2_val(1:end) co_val(1:end) rad_val(1:end) pm_val(1:end)]';
Y_val = y_val(1:end)';

% predict output and reaseasonalize
Y_val_= sim(net_opt, X_val);
Y_val_=Y_val_';
%mean square error and the coef of determination

e = y_val( 1  : end ) - Y_val_( 1 : end );
%figure ; plot(e);
Q = mean( e.^2 ); %mean square error

R2 = 1 - sum( (y_val( 1 : end) - Y_val_( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(54,1)).^2);
R_val(3)= R2;
figure; plot([y_val, Y_val_]); legend('Y', 'g');

%% LUGLIO
A = xlsread('air_quality_2.xls', 4);
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
y_val = n(123:178); %2 years data for validation
clear n;

no_cal = no(1:122);
no_val = no(123:178);
clear no;

no2_cal = no2(1:122);
no2_val = no2(123:178);
clear no2

co_cal = co(1:122);
co_val = co(123:178);
clear co;

rad_cal = rad(1:122); 
rad_val = rad(123:178);
clear rad;

pm_cal = pm(1:122);
pm_val = pm(123:178);
clear rad;


% I opt to use an ANN Artificial Neural Network
% define input and target vectors
%input vector has NO,NO2,CO,solar radiance
X = [ no_cal(1:end) no2_cal(1:end) co_cal(1:end) rad_cal(1:end) pm_cal(1:end)]' ; 
Y = y_cal(1:end)' ;

N_runs= 20;
R_i =zeros(N_runs,1);
for i = 1:N_runs
    net_i= newff(X, Y, 4);
    net_i= train( net_i, X, Y);
    Y_ =sim(net_i,X )';
    R_i(i) = 1 - sum( (y_cal( 1 : end) - Y_( 1 : end)).^2) / sum((y_cal( 1: end )- mean(y_cal( 1: end))*ones(122,1)).^2);
    if R_i(i) >= max(R_i)
        net_opt = net_i;
    end
end

R_cal(4)=max(R_i);

% validation on ANN 

% define input and output on validation dataset
X_val = [no_val(1:end) no2_val(1:end) co_val(1:end) rad_val(1:end) pm_val(1:end)]';
Y_val = y_val(1:end)';

% predict output and reaseasonalize
Y_val_= sim(net_opt, X_val);
Y_val_=Y_val_';
%mean square error and the coef of determination

e = y_val( 1  : end ) - Y_val_( 1 : end );
%figure ; plot(e);
Q = mean( e.^2 ); %mean square error

R2 = 1 - sum( (y_val( 1 : end) - Y_val_( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(56,1)).^2);
R_val(4)= R2;
figure; plot([y_val, Y_val_]); legend('Y', 'g');

%% AUGUST
A = xlsread('air_quality_2.xls', 5);
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
y_cal = n(1:116); %4 yrs data for calibration
y_val = n(117:170); %2 years data for validation
clear n;

no_cal = no(1:116);
no_val = no(117:170);
clear no;

no2_cal = no2(1:116);
no2_val = no2(117:170);
clear no2

co_cal = co(1:116);
co_val = co(117:170);
clear co;

rad_cal = rad(1:116);
rad_val = rad(117:170);
clear rad;

pm_cal = pm(1:116);
pm_val = pm(117:170);
clear rad;


% I opt to use an ANN Artificial Neural Network
% define input and target vectors
%input vector has NO,NO2,CO,solar radiance
X = [ no_cal(1:end) no2_cal(1:end) co_cal(1:end) rad_cal(1:end) pm_cal(1:end)]' ; 
Y = y_cal(1:end)' ;

N_runs= 20;
R_i =zeros(N_runs,1);
for i = 1:N_runs
    net_i= newff(X, Y, 4);
    net_i= train( net_i, X, Y);
    Y_ =sim(net_i,X )';
    R_i(i) = 1 - sum( (y_cal( 1 : end) - Y_( 1 : end)).^2) / sum((y_cal( 1: end )- mean(y_cal( 1: end))*ones(116,1)).^2);
    if R_i(i) >= max(R_i)
        net_opt = net_i;
    end
end

R_cal(5)=max(R_i);

% validation on ANN 

% define input and output on validation dataset
X_val = [no_val(1:end) no2_val(1:end) co_val(1:end) rad_val(1:end) pm_val(1:end)]';
Y_val = y_val(1:end)';

% predict output and reaseasonalize
Y_val_= sim(net_opt, X_val);
Y_val_=Y_val_';
%mean square error and the coef of determination

e = y_val( 1  : end ) - Y_val_( 1 : end );
%figure ; plot(e);
Q = mean( e.^2 ); %mean square error

R2 = 1 - sum( (y_val( 1 : end) - Y_val_( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(54,1)).^2);
R_val(5)= R2;
figure; plot([y_val, Y_val_]); legend('Y', 'g');
%% SEPTEMBER
A = xlsread('air_quality_2.xls', 6);
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
y_cal = n(1:99); %4 yrs data for calibration
y_val = n(100:157); %2 years data for validation
clear n;

no_cal = no(1:99);
no_val = no(100:157);
clear no;

no2_cal = no2(1:99);
no2_val = no2(100:157);
clear no2

co_cal = co(1:99);
co_val = co(100:157);
clear co;

rad_cal = rad(1:99); 
rad_val = rad(100:157);
clear rad;

pm_cal = pm(1:99);
pm_val = pm(100:157);
clear rad;


% I opt to use an ANN Artificial Neural Network
% define input and target vectors
%input vector has NO,NO2,CO,solar radiance
X = [ no_cal(1:end) no2_cal(1:end) co_cal(1:end) rad_cal(1:end) pm_cal(1:end)]' ; 
Y = y_cal(1:end)' ;

N_runs= 20;
R_i =zeros(N_runs,1);
for i = 1:N_runs
    net_i= newff(X, Y, 4);
    net_i= train( net_i, X, Y);
    Y_ =sim(net_i,X )';
    R_i(i) = 1 - sum( (y_cal( 1 : end) - Y_( 1 : end)).^2) / sum((y_cal( 1: end )- mean(y_cal( 1: end))*ones(99,1)).^2);
    if R_i(i) >= max(R_i)
        net_opt = net_i;
    end
end

R_cal(6)=max(R_i);

 %validation on ANN 

% define input and output on validation dataset
X_val = [no_val(1:end) no2_val(1:end) co_val(1:end) rad_val(1:end) pm_val(1:end)]';
Y_val = y_val(1:end)';

% predict output an

Y_val_= sim(net_opt, X_val);
Y_val_=Y_val_';
%mean square error and the coef of determination

e = y_val( 1  : end ) - Y_val_( 1 : end );
%figure ; plot(e);
Q = mean( e.^2 ); %mean square error

R2 = 1 - sum( (y_val( 1 : end) - Y_val_( 1 : end)).^2) / sum( (y_val( 1: end )- mean(y_val( 1: end))*ones(58,1)).^2);
R_val(6)= R2;
figure; plot([y_val, Y_val_]); legend('Y', 'g');
