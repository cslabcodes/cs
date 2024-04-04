N=1000;
M=50;
M_arr=[1:51];
Rx_av=zeros(1,M+1);
Ry_av=zeros(1,M+1);
Sx_av=zeros(1,M+1);
Sy_av=zeros(1,M+1);

X=rand(1,N)-0.5;
Y(1)=0;
for n=2:N
    Y(n)=0.9*Y(n-1)+X(n);
end
Rx_av=Rx_est(X,M);
Ry_av=Rx_est(Y,M);
Sx_av=fftshift(abs(fft(Rx_av)));
Sy_av=fftshift(abs(fft(Ry_av)));
figure(1);
plot(Rx_av/10);
figure(2);
plot(Ry_av/10);
figure(3);
plot(Sx_av/10);
figure(4);
plot(Sy_av/10);
function [Rx]=Rx_est(X,M)
    N=1000;
    Rx=zeros(1,M+1);
    for m=1:M+1
        for n=1:N-m+1
            Rx(m)=Rx(m)+X(n)*X(n+m-1);
        end
        Rx(m)=Rx(m)/(N-m+1);
    end
end