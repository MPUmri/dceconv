function Ct = integralConv(Cp, kep, T1)
% Performs the convolution Cp with exp(-kep*T1)
% Adapted from https://github.com/petmri/ROCKETSHIP/blob/master/dce/model_tofts_cfit.m
% (GNU General Public License v2.0)

% Original header fragment:
%
% Copyright (c) 2016, Thomas Ng, Samuel Barnes
% All rights reserved.
% 
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% Contains program and associated files to process and analyze parametric MRI and DCE-MRI files. Developed at the Biological Imaging Center at the California Institute of Technology. 
% 
% SEE GITHUB WIKI FOR HELP:
% https://github.com/petmri/ROCKETSHIP/wiki
% 
% Please see Barnes, Ng et al BMC Bioinformatics (2015) for more information.
% 
% Thomas Ng 	thomasn@caltech.edu
% Samuel Barnes 	srbarnes@caltech.edu


Cp = Cp(:);
T1 = T1(:);

% Pre-alocate for speed
Ct = zeros(1,numel(T1));
for k = 1:numel(T1)
    
    % The time for T
    T = T1(1:k);
    CP= Cp(1:k);
    
    F = CP.*exp((-kep).*(T(end)-T));
    
    if(numel(T) == 1)
        %need this as trapz interprets non array as
        %Y,DIM input instead of X,Y
        M = 0;
    else
        % 54 times faster than sampleintegration
        M = trapz(T,F);
    end
    
    Ct(k) = M;
end
Ct = Ct';
