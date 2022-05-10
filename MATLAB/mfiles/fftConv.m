function out = fftConv(A, B, t)
% Performs the convolution A with exp(-B*t)
% using fft -> multiply -> ifft

    % Pad fft inputs to appropriate length, i.e. 2*length(t)-1
    vecA = padarray(A, length(t)-1, 'post');
    vecB = padarray(exp(-B*t), length(t)-1, 'post');
    
    out = ifft( fft(vecA) .* fft(vecB) );
    out = out(1:length(t),1) .* (t(2)-t(1));
end
