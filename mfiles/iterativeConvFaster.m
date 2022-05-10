function [f] = iterativeConvFaster(A,B,t)
    % Does conv(A,exp(-B*t))
    % Based on Flouri et al. (2016) MRM 76(3), doi: 10.1002/mrm.25991
    % This version assumes that t is uniform, resulting in small (~10%)
    % speed improvement.
        
    n = length(t);
	
    x = B * ( t(2) - t(1) );

	E = exp(-x);
	E0 = 1 - E;
	E1 = x - E0;
    
    eA = A * E0;
    dA = diff(A) .* E1 ./ x;
    
    f = zeros(n,1);
    for i=1:n-1
       f(i+1) = f(i) * E + eA(i) + dA(i);
    end
    f = f ./ B;
end