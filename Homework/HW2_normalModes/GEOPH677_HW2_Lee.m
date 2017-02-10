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


% fft
Y = fft(sumatra);
Amp = abs(Y);
Amp = Amp(1:n/2+1);

% frequency vector
freq = linspace(0,nyq,n/2+1); % [mHz]
freq2 = freq*1000; %micro hertz

% mode locations 
mloc = [646.2,814,841,945.2,1038,1107,1231,1381,1414,1576,1723,1798,1865,...
    1991,2052,2112,2232,2348,2407,2459,2569,2676,2780,2878,2978,3075,3171,...
    3216,3270,3356,3453,3544,3725,3814,3904,3966,4082,4169,4350,4435,4525,...
    4799,5068]; %in microhertz
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
    '_1S_{24}','_0S_{41}','_0S_{44}'};
%% figure to find modes
figure
plot(freq2,Amp)
set( findall( gcf, '-property', 'Interpreter' ), 'Interpreter', 'Latex' );
xlabel('Frequency \mu Hz')
%% Figure
figure(2);
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
xlim([0,5])
text(freq(idx-24),Amp(idx)+.1,mlabels,'fontweight','bold')
xlabel('Frequency mHz')
ylabel('Amplitude')

subplot(3,1,3)
plot(freq,Amp)
xlim([5,15])
text(freq(idx(43:end)-24),Amp(idx(43:end))+.1,mlabels{43:end},'fontweight','bold')
xlabel('Frequency mHz')
ylabel('Amplitude')
%%
% 3. What is the Nyquist Frequency for this signal?

% The nyquist is .05 Hz or 50 mHz

%%