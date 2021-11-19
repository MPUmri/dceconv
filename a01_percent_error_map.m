% This script will plot the %error between fitted parameters and ground
% truth using the QIBA v6 Tofts model digital phantom.
% Different convolution implementations are used to fit the data.


%% Setup
% Controls what convolution implementations will be used.
% Please make sure there are 6 or fewer options selected
% Options: 
%   @builtinConv, @builtinConvUncorrected
%   @fftConv, @fftConvUncorrected
%   @integralConv, @integralConvDS, @integralConvJGD
%   @iterativeConv, @iterativeConvAG
%   []  <--- this will use linear least squares
convfunctions = {@builtinConv, @builtinConvUncorrected, @iterativeConv, @fftConv, @integralConv, []};

%% Load data
addpath("./mfiles")
load("./data/qiba.mat")

% Determine the x and y axis tick values
xaxis = unique(truth.ve);
yaxis = (unique(truth.kt));

%% Plot error in Ktrans
figure('Position',[0,0,1400,900])
for i=1:numel(convfunctions)
    convfunction = convfunctions{i};
    [~, errkt] = fit_qiba(convfunction, ct, ca, t, truth);
    subplot(2,3,i)
    showErrMap(errkt, 0.5)
    xticks(1:length(xaxis))
    xticklabels(xaxis)
    yticks(1:length(yaxis))
    yticklabels(yaxis)
    ylabel("True Ktrans [1/min]")
    xlabel("True ve [fractional]")
    set(gca,'YDir','normal')
    if isempty(convfunction)
        title("Linear least squares (LLSQ)")
    else
        title(func2str(convfunction))
    end
end
suptitle("%Error in Ktrans")

%% Plot error in ve
figure('Position',[0,0,1400,900])
for i=1:numel(convfunctions)
    convfunction = convfunctions{i};
    [~, ~, errve] = fit_qiba(convfunction, ct, ca, t, truth);
    subplot(2,3,i)
    showErrMap(errve, 0.5)
    xticks(1:length(xaxis))
    xticklabels(xaxis)
    yticks(1:length(yaxis))
    yticklabels(yaxis)
    ylabel("True Ktrans [1/min]")
    xlabel("True ve [fractional]")
    set(gca,'YDir','normal')
    if isempty(convfunction)
        title("Linear least squares (LLSQ)")
    else
        title(func2str(convfunction))
    end
end
suptitle("%Error in ve")