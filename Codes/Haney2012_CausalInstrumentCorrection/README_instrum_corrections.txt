
README file for codes discussed in: 

"Causal instrument corrections for short-period and broadband seismometers" 
by Haney, Power, West, and Michaels


The purpose of this README file is to discuss 5 practical issues encountered in using the Matlab codes described in the paper by Haney et al. for instrument response correction. The various issues are numbered in a list below.


1. The poles and zeros of the instrument are needed in radians/sec, not Hertz (Hz). Converting from Hz to radians/sec requires multiplying the poles and zeros in Hz by 2 times \pi (i.e., 2 x 3.14159).

In SEED format and in RESP files, poles are zeros are oftentimes given in terms of the Laplace domain variable s, which is in radians/sec (rad/s). Furthermore, the poles and zeros listed on the IRIS/PASSCAL website are given in terms of rad/s:

http://www.passcal.nmt.edu/content/instrumentation/sensors/sensor-comparison-chart/poles-and-zeroes

The Laplace domain variable s is related to the Fourier domain variable \omega or angular frequency as:

s = i\omega

where i is the imaginary number. Note that both s and \omega have units of radians/sec; however, the two variables differ by a factor of i. It is important to keep in mind that the poles and zeros in SEED format, in RESP files, and on the IRIS/PASSCAL website are given in terms of the Laplace domain variable s.

Sometimes, for example in Guralp product sheets, the poles and zeros are given in Hertz (Hz). Recall that linear frequency f has dimensions of Hz - its relation to angular frequency \omega is:

2 \pi f = \omega

If we consider a variable called d that is related to s in an analogous way as f is related to \omega, then 

2 \pi d = s

and

d = if

When poles and zeros are given in Hz in Guralp product sheets, they are given in terms of this variable d - the linear frequency analogy for the Laplace domain variable s. It is important to keep these points in mind so as to avoid mistakenly specifying the poles and zeros.


2. Take note of how many zeros are equal to 0. For a transfer function converting particle velocity to volts or counts, there should be 2 zeros equal to 0. Keep in mind that there may be more zeros that are not equal to 0. For a transfer function converting displacement to volts or counts, there should be 3 zeros equal to 0. Finally, an accelerometer should have only 1 zero equal to 0.


3. In the codes provided, all filtering is causal, including Butterworth bandpass filtering at high and low frequency cutoffs. For comparison to other codes, ensure that all filtering is causal. For example, in the paper a comparison is made to the SAC instrument correction code and attention was paid to how to keep the filtering causal within SAC.


4. Currently the codes have the following requirements hardcoded:

4a. The trace length of the data (the total recording time) must be at least 5 times the longest period desired or 1/flo, where flo is the low frequency cutoff.
4b. The ends of the raw data time series are tapered prior to instrument-correction with a taper of length equal to either 10% of the total recording time or 1/flo, depending one which of these two parameters is the smallest.
4c. The filter order of the Butterworth filter used for low-pass must be from 3 to 7. For high-pass filtering, it must be from 2 to 4.
4d. The causal Butterworth bandpass filter is specified by low and high frequency cutoffs flo and fhi. We require that the high frequency cutoff fhi should be larger than the low frequency cutoff flo by an amount at least 10 times the frequency discretization df, which is given by:

df = 1/(N dt)

where N is the number of samples and dt is the time sampling interval (the inverse of the sampling rate). Thus, fhi should satisfy the following inequality:

fhi > flo + (10 x df)

This ensures that the passband is not too narrow.

In the case of 4a, 4c, and 4d, if the input parameters do not satisfy these criteria, the code encounters an ERROR statement and stops. The error message gives some suggestions for what changes to make to the parameters to successfully run the code.


5. For stability purposes, we enforce criteria for low filter orders and sufficient bandwidth as described in items 4c and 4d listed above. If causal filtering within a narrower bandpass is desired, below we give a simple example of how to perform causal Butterworth bandpass filtering in Matlab on an instrument-corrected seismogram denoted as "data". The bandpass filtering is done as the cascade of successive lowpass and highpass filters. However, we caution the user that this code example, when used on the output of our codes, may become unstable if the bandpass is too narrow or the orders of the filters are too high.

The example code is the following:

[bb aa] = butter(lpord,(maxHz/fnyq),'low');data=filter(bb,aa,data);[bb aa] = butter(hpord,(minHz/fnyq),'high');data=filter(bb,aa,data);

where the variables are:

lpord = order of the lowpass filter (e.g., 5)
hpord = order of the highpass filter (e.g., 3)
fnyq = Nyquist frequency (half of the sampling rate)
minHz = frequency cutoff for the highpass filter
maxHz = frequency cutoff for the lowpass filter

We also point out that in the data example we have chosen the orders of the low-pass and high-pass filters, equal to 5 and 3 respectively, because we felt they provided a good tradeoff between stability and sharpness of the band edge.


The file on the internet containing the codes is located at the following URL:

http://cgiss.boisestate.edu/~matt/causal_instrument_corrections_final.zip

The ZIP file contains Matlab codes and a data example of instrument corrections as discussed in the paper. An appendix of the paper (Appendix B) describes how to execute these codes with the data example.
















