% This script will check how long it takes to fit the QIBA v6 Tofts model 
% digital phantom using different convolution implementations

clearvars
%% Setup
% Controls what convolution implementations will be used.
% Options: 
%   @builtinConv, @builtinConvModified
%   @fftConv, @fftConvModified
%   @integralConv, @integralConvDS, @integralConvJGD
%   @iterativeConv, @iterativeConvAG, @iterativeConvFaster
%   []  <--- this will use linear least squares
convfunctions = {@iterativeConvFaster, @integralConv, @fftConv, @builtinConv, @builtinConvModified, []};

% Controls how many time the fit is repeated
% e.g. nrep=2 means that an average from 2 fits will be used
% (Higher number = script takes longer to run)
nrep = 3;

% Temporally downsample the data to make the fitting faster for all
% implementations. (set to 1 to disable downsampling)
% Original data has 1321 time points. 
% Downsampled data will have 1321/downsampleFactor timepoints
downsampleFactor = 1;

%% Load data
addpath("./mfiles")
load("./data/qiba.mat")

% Re-shape to make future functions happy
[nx, ny, nt] = size(ct);
ct = reshape(ct, [nx*ny nt])';

% Apply downsampling, if applicable
t = downsample(t, downsampleFactor);
ca = downsample(ca, downsampleFactor);
ct = downsample(ct, downsampleFactor);


%% Warm-up run

% Recent Matlab versions do some kind of JIT-compiling, so first run could
% be substantially slower than proceeding runs. So we run everything once
% so that we're not measuring the initial slow run.

for i=1:numel(convfunctions)
    convfunction = convfunctions{i};
    if isempty(convfunction)
        % Empty = linear least squares
        Tofts_LLSQ(ct,ca,t);
        continue
    end
    % Using NLSQ directly instead of fit_qiba() to skip reformatting fits
    NLSQ(ct,ca,t, convfunction);
end

%% Start timing

disp("===========================")
disp("Time needed to fit 30 voxels with " + num2str(length(t)) + " timepoints:")
disp(" ")

for i=1:numel(convfunctions)
    convfunction = convfunctions{i};
    x = tic();
    if isempty(convfunction)
        convfunction = @LLSQ;
        for i=1:nrep
            Tofts_LLSQ(ct,ca,t);
        end
    else
        for i=1:nrep
            NLSQ(ct,ca,t, convfunction);
        end
    end
    disp("Fitting " + func2str(convfunction) + " took " + num2str(round(1000*toc(x)/nrep)) + " ms")
end
%%