function out = fftConv(A, B, t)
% Performs the convolution A with exp(-B*t)
% using fft -> multiply -> ifft

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
