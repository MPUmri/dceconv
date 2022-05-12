# dceconv

The matlab implementation is in the `MATLAB` folder. There are two scripts there:

1. `./MATLAB/a01_percent_error_map.m` - this will evaluate the accuracy of the different convolution implementations
2. `./MATLAB/a02_speed_test.m` - this will compare the computation speed

The julia implementation is in the notebook located in the `Julia` folder. [Click here to see the rendered notebook](https://nbviewer.org/github/MPUmri/dceconv/blob/main/Julia/dceConv.ipynb)

**Notes**

- The convolution implementations for matlab are in `./MATLAB/mfiles`, in files that end in `*conv.m`
  - The "summation" technique in the abstract is called `integralconv*.m` in the code
  - There is a `*modified.m` version for the builtin and fft-based implementations. The modified applies a scaling which tends to improve accuracy on the QIBA phantom. 
