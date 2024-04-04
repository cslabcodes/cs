close all;
clear;
clc;
t = 0:0.01:10;
a = sin(t);
[sqnr8, aquan8] = u_pcm(a, 8);
[sqnr16, aquan16] = u_pcm(a, 16);
disp('sqnr8');
disp(sqnr8);
disp('sqnr16');
disp(sqnr16);

% Plot original signal and both quantized signals on the same plot
plot(t, a, '-', t, aquan8, '--', t, aquan16, '-.');
legend('Original Signal', '8-level Quantized Signal', '16-level Quantized Signal');
title('Comparison of Quantized Signals');
xlabel('Time');
ylabel('Amplitude');

function [sqnr, a_quan] = u_pcm(a, n)
    amax = max(abs(a));  % Maximum absolute value of input signal
    a_quan = a / amax;   % Normalize input signal to [-1, 1]
    d = 2 / n;           % Quantization step size
    q = d *( [0:n-1] - ((n-1)/2));  % Quantization levels

    % Quantization process
    for i = 1:n
        a_quan((q(i)-d/2<=a_quan)&(a_quan<=q(i)+d/2))=q(i);  % Assign quantized value to samples within the range
    end

    a_quan = a_quan * amax;  % Scale back to original amplitude
    sqnr = 20 * log10(norm(a) / norm(a - a_quan));  % Signal-to-Quantization-Noise Ratio
end

