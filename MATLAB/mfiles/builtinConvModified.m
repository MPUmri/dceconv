function out = builtinConvModified(A, B, t)
% Performs the convolution A with exp(-B*t)
% using matlab's built in function (sliding sums (?))
% Unlike @builtinConv, this version performs the 1/2 scaling correction
% for the first & last elements of the impulse response function
% This tends to be more accurate on QIBA phantom

    irf = exp(-B*t);
    % Correction to get accurate fits
    irf(1) = irf(1)/2;
    irf(end) = irf(end)/2;
    
    out = conv(A,irf);
    % The length of convolved vectors A (X) B is length(A)+length(B)-1
    % Extra length is truncated
    out = out(1:length(t),1) .* (t(2)-t(1));
end
