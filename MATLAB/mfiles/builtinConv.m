function out = builtinConv(A, B, t)
% Performs the convolution A with exp(-B*t)
% using matlab's built in function (sliding sums)

    irf = exp(-B*t);
    % No further corrections/scaling of irf
    
    out = conv(A,irf);
    % The length of convolved vectors A (X) B is length(A)+length(B)-1
    % Extra length is truncated
    out = out(1:length(t),1) .* (t(2)-t(1));
end
