function [c_toi] = integralConvJDG(A,B,t)
% Performs the convolution A with exp(-B*t)
% Adapted from fitdcemri: https://github.com/JDeGrandchamp/fitdcemri

% Header fragment from original code:
%
% Authors:
% Joey DeGrandchamp                 Julio Cardenas-Rodriguez
% University of Arizona             University of Arizona
% jdegrandchamp@email.arizona.edu   cardenaj@email.arizona.edu
%
%                       www.cardenaslab.org
% version 2.0 01/11/2020

n_points=length(t);
c_toi=zeros(n_points,1);

for k = 2:n_points
    int_t = t(k);
    
    crpexp = zeros(k,1);
    for j = 1:k
        dummy_time = t(j);
        expo = exp(-((B.*(int_t-dummy_time)))); %#ok<*AGROW>
        crpexp(j) = A(j)*expo;
    end
    
    t2 = t(1:k);
    %%
    c_toi(k) = trapz(t2,crpexp);
end

end