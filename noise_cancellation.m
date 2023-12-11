%% Second Example : lets use the adaptive filter to remove noise
%% from an unknown system
%% So, we can receive signal+noise somewhere, and we also have another
%% measure of noise from an independent source
close all;
numpoints = 480000;

t = linspace(1,numpoints,numpoints);
x = 0.1*sin(2*pi*t*1/50).';
n = 0.05*randn(numpoints,1); % this is the value of the noise we've measured (correlated to what is in the signal)

% load a lawnmower audio file, 10 seconds worth at 48000 samples/sec
mower = audioread("lawn-mower-01.wav");
mower_undelayed = mower(20:numpoints+19,1);
mower_delayed = mower(1:numpoints,1);

gettysburg = audioread('gettysburg.wav');
g = resample(gettysburg,48000,24400);
g = g(1:numpoints);

% now, lets make the signal received by the car microphone get our pure
% information signal x but also added to it is some transformation of the
% vehicle noise, we will multiply it by 2 and also filter it with our other
% filter from part I
d = g + mower_delayed*2;
mu = 0.002;
lms = dsp.LMSFilter(60,'StepSize',mu)
[y,e,w] = lms(mower_undelayed,d);

figure();

plot(1:numpoints, [d,y,e])
title('LMS FIR filter for Noise Cancellation')
legend('Desired','Output','Error')
xlabel('Time index')
ylabel('Signal value')

soundsc(e,48000);


