function out = fftConvModified(A, B, t)
% Performs the convolution A with exp(-B*t)
% using fft -> multiply -> ifft
% Unlike @fftConv, this version performs the 1/2 scaling correction
% for the first & last elements of the impulse response function
% This tends to be more accurate on QIBA phantom

    % Pad inputs to appropriate length, i.e. 2*length(t)-1
    vecA = padarray(A, length(t)-1,'post');
    
    tmpB = exp(-B*t);
    % Correction to get accurate fits
    tmpB(1) = tmpB(1)/2;
    tmpB(end) = tmpB(end)/2;
    vecB = padarray(tmpB, length(t)-1, 'post');
    
    out = ifft( fft(vecA) .* fft(vecB) );
    out = out(1:length(t),1) .* (t(2)-t(1));
end
