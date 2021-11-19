function out = integralConvDS(A,B,t)
% Performs the convolution A with exp(-B*t)
% Adapted from code by David S. Smith (GNU General Public License v2.0)
% Ref: https://github.com/welcheb/pydcemri/blob/master/dcemri.py

    out = zeros(size(A));

    % Calculate concentration at each time point
    for k=1:length(t)
        out(k) = trapz(A(1:k) .* exp(B*(t(1:k)-t(k))));
    end

    % Scale by temporal resolution, and transpose (transpose is personal preference)
    out = (t(2)-t(1)) * out';

end