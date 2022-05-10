function [pkparams, resid, exitFlag] = NLSQ(Ct, Cp, t, convFunc)
  % Non-Linear least squares (NLSQ) fitting of Tofts-Key model

  % Initialize matrices
  [~, numVox] = size(Ct);
  pkparams = zeros(numVox, 2);
  resid = zeros(numVox, 1);
  exitFlag = zeros(numVox, 1);

  options=optimset('Algorithm','levenberg-marquardt','display','off');
  pkGuess = Tofts_LLSQ(Ct,Cp,t);
  for i=1:numVox
      [pkparams(i,:), resid(i), ~, exitFlag(i)] = ...
          lsqnonlin(@(x) Ct(:,i) - ToftsKety(Cp,x,t,convFunc), pkGuess(i,:), [], [], options);
  end
end