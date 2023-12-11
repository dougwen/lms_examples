%% First Example : lets use the adaptive filter to Identify this
%% "unknown" filter, this is the filter pictured on the slide
close all;
filt = dsp.FIRFilter;
filt.Numerator = [-0.0554   -0.0744    0.0926    0.1057   -0.0698   -0.1756    0.0326    0.1964    0.0326   -0.1756   -0.0698    0.1057    0.0926   -0.0744   -0.0554];

x = 0.1*randn(10000,1);
n = 0.01*randn(10000,1);
d = filt(x) + n;
mu = 0.2;
lms = dsp.LMSFilter(30,'StepSize',mu)
[y,e,w] = lms(x,d);

figure();
title('System Identification by Adaptive LMS Algorithm')
legend('Actual filter weights','Estimated filter weights',...
       'Location','NorthEast')


plot(1:10000, [d,y,e])
title('System Identification of an FIR filter')
legend('Desired','Output','Error')
xlabel('Time index')
ylabel('Signal value')


% another experiment - watch how weights adjust over time to match
figure();
n = 0.01*randn(200,1);
for index = 1:4
  x = 0.1*randn(200,1);
  d = filt(x) + n;
  [y,e,w] = lms(x,d);
  subplot(5,1,index);
  stem(w);
end
subplot(5,1,5);
stem(filt.Numerator);


