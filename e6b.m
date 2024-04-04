
l=500;
t = linspace(0, 2, l);
Fs = 50; %1/(10/len)
amp = 5;
f = 2;
x1 = amp*sin(2*pi*f*t);

[delta_out, delta_pred] = delta_adm_modulator(x1);

plot(t,x1);
title('ADM');
xlabel('Time(s)');
ylabel('Amplitude(V)');
hold on;
stairs(t,delta_pred');
legend('Input', 'Adaptive Delta Modulation');

function [y, pred] = delta_adm_modulator(x)
    N = length(x);
    y = zeros(N, 1);
    pred = zeros(N, 1);
    
    % Set initial delta value
    delta = 0.07;
    
    % Set maximum and minimum delta values
    max_delta = delta * 16;
    min_delta = delta / 16;
    
    curr = 0;
    for i = 2:N
        if i > 4
            % Series of 0000 or 1111: increase delta by 2
            if ~xor(y(i-3), y(i-4)) && ~xor(y(i-3), y(i-2)) && ~xor(y(i-2), y(i-1))
                if delta < max_delta
                    delta = delta * 2;
                end
            % Series of 0101 or 1010: reduce delta by 2
            elseif xor(y(i-3), y(i-4)) && xor(y(i-3), y(i-2)) && xor(y(i-2), y(i-1))
                if delta > min_delta
                    delta = delta / 2;
                end
            end
        end
        
        % Compare with the current sample value and set delta positive or negative
        if x(i) >= curr
            y(i) = 1;
            curr = curr + delta;
        else
            y(i) = 0;
            curr = curr - delta;
        end
        
        if y(i) == 0
            err = -1;
        else
            err = 1;
        end
        pred(i) = pred(i-1) + err * delta;
    end
end
