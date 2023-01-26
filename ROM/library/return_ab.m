function [a,b]=return_ab(mode_freq,zeta)
    wn=2*pi*mode_freq(end);
    w1=2*pi*mode_freq(1);
    keisu=2*zeta*w1*wn/(wn^2-w1^2);
    a=keisu*(wn-w1);
    b=keisu*(1/w1-1/wn);
end
