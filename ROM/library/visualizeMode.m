function visualizeMode(pastMode,newMode,fig,mode_shapes_angle)
N=length(pastMode);
%color=["red","blue","green","cyan","magenta","black","yellow","white"];
pastMode=modeNormlize(pastMode);
newMode=modeNormlize(newMode);

[angle,I] = sort(mode_shapes_angle);


for i=1:1:N
    %subplot(N,1,i)
    temp_f=figure();
    fig{i}=temp_f;
    temp_f.Name='Mode Shapes of Lumped mass System and Original System'+string(i);
    temp_f.Visible="on";
    pastMode_sorted=pastMode(:,i);pastMode_sorted=pastMode_sorted(I);
    newMode_sorted=newMode(:,i);newMode_sorted=newMode_sorted(I);
    polarplot([angle;angle(1)],1+[pastMode_sorted;pastMode_sorted(1)],"-","LineWidth",2)
    hold on
    polarplot([angle;angle(1)],1+[newMode_sorted;newMode_sorted(1)],"--","LineWidth",2)
    rlim([-2,2])
    legend("Given","Lumped")
end
title("Lumped Mass Model of Vibration of Cantilever")
%xlabel("Node")
%ylabel("Amplitude")
%strs=string(zeros(1,2*N));
%{
for i=1:1:N
    %subplot(N,1,i)
    figure(fig{i});
    ordstr = iptnum2ordinal(i);
    ordstr(1)=upper(ordstr(1));
    strs(i)=ordstr+" Given";
    legend(strs(i))
end
for i=1:1:N
    %subplot(N,1,i)
    figure(fig{i});
    ordstr = iptnum2ordinal(i);
    ordstr(1)=upper(ordstr(1));
    strs(N+i)=ordstr+" Lumped";
    legend(strs(N+i))
end
%}
%legend(strs)
grid on
end
