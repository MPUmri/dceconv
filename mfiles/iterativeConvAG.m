function f = iterativeConvAG(a,T,t)
% Another version of iterative conv adapted from: 
% https://bitbucket.org/UmU-Radiofysik/two-compartment-wtls-estimator/src/master/expConv.m
%
% Original header:
%
% Fast and accurate convolution with an exponential function.
% f = a * exp(-t/T) / T. (! Note: The adapted version does a * exp(-t*T) !)
% Reference: D. Flouri, D. Lesnic, and S. P. Sourbron, Fitting the two-compartment model in DCE-MRI by linear inversion, 
%            Magn. Reson. Med., vol. 76, no. 3, pp. 998-1006, Sep. 2016.

 if (T == 0)
     f = a; % Convolution with a delta function.
     return;
 end
 f = zeros(size(t));
 
 % Modification to return exp(-t*T) instead of exp(-t/T)
 T = 1/T;
 
 % Cannot be vectorized! Mex could speed up.
 for ii = 1:(numel(t)-1)
    xi = (t(ii+1)-t(ii))/T;
    api = (a(ii+1)-a(ii))/(t(ii+1)-t(ii));
    E0 = 1-exp(-xi);
    E1 = xi-E0;

    f(ii+1) = f(ii)*exp(-xi) + a(ii)*E0 + api*T*E1;
 end
 
  % Modification to remove 1/T scaling in output
  f = f .* T;
  
end