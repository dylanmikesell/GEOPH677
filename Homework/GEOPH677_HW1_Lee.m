%%
% HW1: GEOPHY677         
% 
% Rebekah Lee                                                        
%
% 1/30/2017 
%% Instrument Responses and Deconvolution
%% Part 1: An electromagnetic velocity sensor
% *A) Explain the Biot-Savart law.*
%
% The Biot-Savart law is gives the magnetic field of a steady line current and is analogous to Coulomb's law in electrostatics:
% 
% 
% $${\bf B}({\bf r}) = \frac{\mu_0}{4\pi} \int \frac{{\bf I \times \hat{r'} }}{r'^2}dl = \frac{\mu_0}{4\pi}I \int \frac{d{\bf l \times \hat{r'} }}{r'^2}dl$$
% 
% Where ${\bf I}$ is the electric current, ${\bf r'}$ is the vector
% from the source to the point ${\bf r}$, dl is an element along the wire
% in the direction of the current and $\mu_0 = 4\pi \times 10^{-7} N/A^2$ is the permeability of free space.
% The units for the magnetic field are newtons per ampere-meter (N/ (A m))
% or teslas (T) and the integral is along the current path in the same
% direction as the flow.
%
% Source: Griffiths, David. Introduction to Electrodynamics. Fourth Edition
% 
% *B) Explain Onsager's reciprocal theorem*
%
% Onsager's reciprocal theorem involves the reciprocity of coupled
% electrical and thermal systems. Lars Onsager's 1931 paper uses the
% following notation:
% 
% 
% $X_1$ and $X_2$ are driving electrical and thermodynamic forces,
% respectively and, if they were independent, could be written as:
% 
% 
% $$X_1 = R_1J_1$$ 
% 
% $$X_2 = R_2J_2$$
%
% where $R_1$ and $R_2$ are the electrical resistivity and thermal resistance,
% respectively. $J_1$ and $J_2$ are electrical and thermal current.
%
% However, these systems are coupled since electrical current is not
% independent of the temperature. Therefore we can add in this dependency
% using cross coefficients $R_{12}$ and $R_{21}$ so that:
% 
% $$X_1 = R_{11}J_1 + R_{12}J_2$, and
% 
% $$X_2 = R_{21}J_1 + R_{22}J_2$
% .
% 
% My understanding of this is that the electrical force is equal to electrical resistance times current
% density plus the current modified scaled by a coeffecient that represents
% the coupling of the thermal heat on the electrical system. 
% 
% Similarly, the thermodynamic force is equal to the thermal resistance
% times thermal current density plus the electrical current density scaled
% by a coeffecient representing the coupling of the electrical system on
% the thermal.
% the reciprocity theorem states that these two coefficients are equal,
%
% $R_{12}=R_{21}$
%
% Sources: 
%
% Onsager,Lars. Reciprocal Relations in Irreversible Processes. I.
% Physical Review, Vol 37. 1931
%
% http://www.iue.tuwien.ac.at/phd/holzer/node24.html
% *C)How would you compute $l$ given a coil with radius $r$ and number of coils $n$?*
%
%       $l = 2\pi rn $
%% Part 2: Creating the frequency response
Meta = rdmseed('../Data/XX.BSM7.HHZ_MC-PH1_0426_20170112_180000.miniseed');
%%
sf= Meta.SampleRate; %sampling frequeny in Hz
ny= .5*sf; % nyquist

frequencies= .001:.0001:ny;
w = frequencies*2*pi;

A0=4.344928e17; % conversion from counts to m/s for this instrument

zeros = [ % the zeros in 1/sec
    0.000000E+00;
    0.000000E+00;
    -3.920000E+02;
    -1.960000E+03;
    -1.490000E+03 + 1i*1.740000E+03;
    -1.490000E+03 + 1i*-1.740000E+03
    ];

poles = [ % the poles in 1/sec
    -3.691000E-02 + 1i* 3.702000E-02;
    -3.691000E-02 + 1i*-3.702000E-02;
    -3.430000E+02 + 1i* 0.000000E+00;
    -3.700000E+02 + 1i* 4.670000E+02;
    -3.700000E+02 + 1i*-4.670000E+02;
    -8.360000E+02 + 1i* 1.522000E+03;
    -8.360000E+02 + 1i*-1.522000E+03;
    -4.900000E+03 + 1i* 4.700000E+03;
    -4.900000E+03 + 1i*-4.700000E+03;
    -6.900000E+03 + 1i* 0.000000E+00;
    -1.500000E+04 + 1i* 0.000000E+00
    ];

% get coefficients for polynomials
num = poly(zeros*2*pi); %convert poles and zeros to rad/s for function
denom= poly(poles*2*pi);

fResponse=A0*freqs(num,denom,w);
mag =abs(fResponse); 
phase = angle(fResponse);
phase = rad2deg(phase);

% get time series amplitudes
Vacausal = ifft(fResponse);
Vacausal = ifftshift(Vacausal);

% get times
n= length(frequencies);
t = linspace(-1/2/0.0001,1/2/0.0001,n);

figure(1);
subplot(4,1,1)
semilogx(frequencies,mag,'LineWidth',2);
axis tight
xlabel('Frequency [Hz]')
ylabel('Amplitude [m/s/Hz]')
title('Amplitude Spectral Density')

subplot(4,1,2)
semilogx(frequencies,phase,'Linewidth',2)
axis tight
ylim([-180 180])
xlabel('Frequency [Hz]')
ylabel('Phase [degree]')
title('Phase Spectra')

subplot(4,1,3)
plot(t,real(Vacausal),'Linewidth',2)
ylim([-1e-4 1e-4])
xlim([-.5 .5])
ylabel('Velocity [m/s]')
xlabel('Time [s]')
title('Acausal version')
