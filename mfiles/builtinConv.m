function out = builtinConv(A, B, t)
% Performs the convolution A with exp(-B*t)
% using matlab's built in function (sliding sums (?))

    irf = exp(-B*t);
    % Correction to get accurate fits
    irf(1) = irf(1)/2;
    irf(end) = irf(end)/2;
    
    out = conv(A,irf);
    % The length of convolved vectors A (X) B is length(A)+length(B)-1
    % Extra length is truncated
    out = out(1:length(t),1) .* (t(2)-t(1));
end
