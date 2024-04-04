N=1000;
for i=1:2:N
    m=0; sigma=1;
    [x1(i),x1(i+1)]=gngauss(m,sigma);
    [x2(i),x2(i+1)]=gngauss(m,sigma);
    echo on;
    A=[1 -0.9]
    B=1;
    Xc=filter(B,A,x1);
    Xs=filter(B,A,x2);
    fc=1000/pi;
end
for i=1:N
    band_pass(i)=Xc(i)*cos(2*pi*fc*i)-Xs(i)*sin(2*pi*fc*i);
    echo off;
end
echo on;
M=50;
bpp_autocorr=Rx_est(band_pass,M);
bpp_spect=fftshift(abs(fft(bpp_autocorr)));
plot(bpp_spect);

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

function [g1,g2]=gngauss(m,sigma)
    U=rand;
    z=sigma*sqrt(2*log(1/(1-U)));
    g1=m+z*cos(2*pi*U);
    g2=m+z*sin(2*pi*U);
end
