function visualizePhysicalMass(X,Y,Z,DelegateNodeNum,mass,K,fig1,fig2,fig3)
figure(fig1);
    Xorg=X;
    Yorg=Y;
    Zorg=Z;
    X=X(DelegateNodeNum);
    Y=Y(DelegateNodeNum);
    Z=Z(DelegateNodeNum);
    M=diag(mass)';M=rescale(M);M=M+1;
    K=K;
    

grid on
%{
scatter(X,Y,diag(K./max(abs(K)))*140,"red","^")
%}
hold on
scatter3(Xorg,Yorg,Zorg,ones(size(Xorg)),"red");
scatter3(X,Y,Z,diag(mass)*100+1,"blue","filled");

str = {}
t=text(X,Y,Z,str);
for i=1:1:length(X)
    t(i).Color ="black";
    t(i).FontSize = 15;
    t(i).String=string(i)+"th";
end
legend("Original Shape","Lumped Mass")
grid on
title("���_�ʒu�Ƒ傫���C���[�W")
xlabel("Position x[mm]")
ylabel("Position y[mm]")
zlabel("Position z[mm]")

figure(fig2)
bar3(mass)
zlabel("���_����[kg]")
xlabel("Node Index")
ylabel("Node Index")

figure(fig3)
bar3(K)
xlabel("Node Index")
ylabel("Node Index")
zlabel("����[N/m]")


%{
subplot(2,2,4)
    scatter(X,Y,M,"filled");
    hold on
    text="";
    color="red";
    for i=1:1:length(K(:,1))
        for j=1:1:length(K(1,:))
            sz=K(i,j);
            if sz<=0
                color="--g";
                sz=abs(sz);
            else
                color="--r";
            end
            if sz>0
                hold on
            plot([X(i),X(j)],[Y(i),Y(j)],color,"LineWidth",sz)
   
            end
        end
    end
    grid on
    xlabel("Position x[mm]")
    ylabel("Position y[mm]")
    title("�A���΂ˑ傫���C���[�W �ԐF:��,�ΐF:��")
    dim = [.2 .5 .3 .3];
    %c = newline;
    %str = "�_:���_"+c+"�_��:���� *�ԐF:�� ��:��"+c+text;
    %annotation(f,'textbox',dim{4},'String',str,'FitBoxToText','on');
  %}  
end

