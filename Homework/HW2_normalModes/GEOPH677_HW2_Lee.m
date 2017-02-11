%% Homework 2: 
% Normal mode observations, Polarization analysis and component rotation
% Rebekah Lee
% Due 2/13/17

%% Part 1 Normal Mode Observations

% *1. Plot the raw time series; use dimension hours on the time axis*

% Load the data
load('sumatra.txt')

% create the time vector
n = length(sumatra);
dt = 10; %seconds
t = 1:dt:n*10; % time in seconds
t = t./3600; %time in hours

% plot the raw data
figure(1);
plot(t,sumatra)

title('Broadband station PAS (CA)')
xlabel('Time (hours)')
axis tight

%%
% *2. Fourier transform the time series and plot amplitude and unwrapped
% phase spectra; use dimension mHz on the frequency axis*
fs = .1; %Hz
fs = fs*1000; % sampling frequency in mHz
nyq = fs/2; % [mHz]

% frequency vector
freq = linspace(0,nyq,n/2+1); % [mHz]
freq2 = freq*1000; %micro hertz

% fft
Y = fft(sumatra);
Amp = abs(Y);
Amp = Amp(1:n/2+1);
phase = angle(Y);
phase = unwrap(phase(1:n/2+1));
%% Plot Amplitude Spectrum and Phase
figure(2)
subplot(2,1,1)
plot(freq,Amp)
xlabel('Frequency mHz')
title('Amplitude Spectrum')
ylabel('Amplitude')
axis tight


subplot(2,1,2)
plot(freq,phase)
xlabel('Frequency mHz')
ylabel('Radians')
title('Unwrapped Phase')
%% Modes
% mode locations 
mloc = [646.2,814,841,945.2,1038,1107,1231,1381,1414,1576,1723,1798,1865,...
    1991,2052,2112,2232,2348,2407,2459,2569,2676,2780,2878,2978,3075,3171,...
    3216,3270,3356,3453,3544,3725,3814,3904,3966,4082,4169,4350,4435,4525,...
    4799,5068,5091,5147,5201,5247,5359,5505,5583,5872,5992,6221,6225,6327,...
    6593,6640,6698,6780,6865,7151,7232,7427,7465,7633,7699,7807,7888,8250,...
    8343,8407,8439,8544,8806,9008,9095,9201,9304,9363,9583,9770,9813,9909]; %in microhertz
mloc = mloc./1000; % in mHz

% Find index number for frequencies located during manual inspection
nmodes= length(mloc);
idx= zeros(nmodes,1);
for imode =1: nmodes
    [~,idx(imode)] = min(abs(freq-mloc(imode)));
end

% mode labels
mlabels= {'_0S_4','_0S_0','_0S_5','_3S_1','_0S_6','_3S_2','_0S_7','_2S_4'...
    ,'_0S_8','_0S_9','_0S_{10}','_1S_8','_2S_7','_0S_{12}','_2S_8',...
    '_0S_{13}','_0S_{14}','_1S_{11}','_2S_{10}','_0S_{16}','_0S_{17}',...
    '_0S_{18}','_0S_{19}','_0S_{20}','_0S_{21}','_0S_{22}','_0S_{23}',...
    '_8S_{2}','_3S_0','_0S_{25}','_0S_{26}','_0S_{27}','_0S_{29}','_0S_{30}',...
    '_0S_{31}','_3S_{16}','_0S_{33}','_0S_{34}','_0S_{36}','_4S_{14}',...
    '_1S_{24}','_0S_{41}','_0S_{44}','_3S_{23}','_{9}S_{8}','_{4}S_{19}',...
    '_{0}S_{46}','_{4}S_{20}','_{8}S_{10}','_{2}S_{26}','_{8}S_{12}','_{5}S_{19}'...
    ,'_{16}S_{3}','_{2}S_{30}','_{7}S_{16}','_{15}S_{6}','_{5}S_{23}',...
    '_{2}S_{33}','_{0}S_{63}','_{12}S_{10}','_{16}S_{6}','_{6}S_{23}',...
    '_{8}S_{10}','_{17}S_{5}','_{17}S_{7}','_{9}S_{19}','_{14}S_{11}','_{15}S_{10}'...
    ,'_{5}S_{33}','_{7}S_{27}','_{12}S_{15}','_{8}S_{24}','_{7}S_{28}',...
    '_{2}S_{47}','_{22}S_{5}','_{7}S_{31}','_{5}S_{39}','_{0}S_{90}','_{1}S_{62}'...
    ,'_{0}S_{93}','_{0}S_{95}','_{11}S_{25}','_{26}S_{4}'};
%% figure to find modes
figure
plot(freq2,Amp)
set( findall( gcf, '-property', 'Interpreter' ), 'Interpreter', 'Latex' );
xlabel('Frequency \mu Hz')
%% Figure
figure(3);
% plot fft
subplot(3,1,1)
plot(freq,Amp)
xlabel('Frequency mHz')
title('Amplitude Spectrum')
ylabel('Amplitude')
axis tight


% Identify Modes
subplot(3,1,2)
plot(freq,Amp)
hold on
plot(freq(idx(1:42)),Amp(idx(1:42)),'.r')
xlim([0,5])
text(freq(idx(1:42)-24),Amp(idx(1:42))+.1,mlabels(1:42),'fontweight','bold','EdgeColor','black','BackgroundColor',[.94 .94 .94],'fontsize',7,'FontName','Arial')
xlabel('Frequency mHz')
ylabel('Amplitude')

subplot(3,1,3)
plot(freq,Amp)
hold on
plot(freq(idx(42:end)),Amp(idx(42:end)),'.r')
xlim([5,10])
text(freq(idx(43:end)-24),Amp(idx(43:end))+.1,mlabels(43:end),'fontweight','bold','EdgeColor','black','BackgroundColor',[.94 .94 .94],'fontsize',7,'FontName','Arial')
xlabel('Frequency mHz')
ylabel('Amplitude')

set(gcf,'Position',[190 50 1141 740]);
%%
% 3. What is the Nyquist Frequency for this signal?

% The nyquist is .05 Hz or 50 mHz

%%