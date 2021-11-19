function showErrMap(myMap, myMax, axisVals)

    if nargin<2
        myMax = quantile(abs(myMap(:)),1);
    end
    myCLim = [-myMax myMax];
    
    if nargin<3
        imagesc(myMap, myCLim)
    else
        imagesc(axisVals{1}, axisVals{2}, myMap, myCLim);
    end
    
    myCMap = flipud(lbmap(256, 'BrownBlue'));
    colormap(myCMap)

end
