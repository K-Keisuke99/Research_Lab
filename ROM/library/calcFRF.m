K=[1 1; 2 7.5]*10^7;
M=[1 0;0 1];
alpha=0.000001;beta=0.001;
C=alpha*K+beta*M;
f=linspace(0,3000,2500);
omega=2*pi*f;
text="";
color=["red","blue"]
for i=1:1:2
    g=0
    for j=1:1:2
        gij=FRF(i,j,M,C,K,omega)
        plot(f,log10(abs(gij)),"Color",color(j),"LineStyle","-.")
        hold on
        g=g+gij;
    end
    plot(f,log10(abs(g)),"Color",color(i),"LineStyle","-")
    hold on
end

%%
function G=FRF(p,q,M,C,K,omega)
%p:input,q:output
    G=zeros(1,length(omega));
    for i=1:1:length(omega)
        w=omega(i);
        Gw=-w^2*M+1i*w*C+K;
        invGw=inv(Gw);
        G(i)=invGw(q,p);
    end
end