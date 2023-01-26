function pt=TMDArrangement(N,TMDnum,DelegateNodeNum,Y,Z)
    pt=zeros([N,1]);
    Yd=Y(DelegateNodeNum);
    Zd=Z(DelegateNodeNum);
    fig_temp=figure();
    scatter(Yd,Zd,150,"blue");
    hold on
    plot(Y,Z)
    for i=1:1:length(Yd)
        text(Yd(i)-5, Zd(i)+5, string(i)+"th")
    end
    
    daspect([1 1 1])
    for i=1:1:TMDnum
        [y,z] = ginput(1);
        [dp,Ip] = min((Yd-y).^2+(Zd-z).^2);
        % マウスで選択した位置と最も近いデータ値を取得
        hold on
        scatter(Yd(Ip),Zd(Ip),"red","filled")
        pt(Ip)=1;
    end
    legend("Position of Mass","Profile of Workpiece","Position of TMD")
        saveas(gcf,'Position_of_TMDs.png')
        close(fig_temp);
    
end