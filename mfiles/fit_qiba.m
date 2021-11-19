function [fits, errkt, errve] = fit_qiba(convfunc, ct, ca, t, truth)
    
    [nx, ny, nt] = size(ct);
    Ct = reshape(ct, [nx*ny nt])';

    if isempty(convfunc)
        fits = Tofts_LLSQ(Ct,ca,t);
    else
        fits = NLSQ(Ct,ca,t,convfunc);
    end
    
    fits = reshape(fits, [nx ny 2]);
    estkt = fits(:,:,1);
    estve = fits(:,:,1)./fits(:,:,2);
    errkt = PercentError(estkt, truth.kt);
    errve = PercentError(estve, truth.ve);
end

