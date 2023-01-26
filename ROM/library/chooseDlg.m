function NodeNum=chooseDlg(X,Y,Z,Disp,DelegateNodeNum,now)
        fig_temp=figure();
        Zmax=max(Z);
        ZmaxInd=find(Z==Zmax);
        theta=atan2(Y,X);R=sqrt(X.^2+Y.^2);
        modeX=(R+1000*Disp).*cos(theta);modeY=(R+1000*Disp).*sin(theta);
            plot(X(ZmaxInd),Y(ZmaxInd));
            hold on
            plot(modeX,modeY)
            scatter(X(DelegateNodeNum(1:now-1)),Y(DelegateNodeNum(1:now-1)),"filled")
            %[x,y] = ginput(1)    ;

        daspect([1 1 1])
        for i=1:1:1
            [x,y] = ginput(1);
            [dp,Ip] = min((X-x(i)).^2+(Y-y(i)).^2);
            % マウスで選択した位置と最も近いデータ値を取得



            indX=find(X==X(Ip));
            indY=find(Y==Y(Ip));
            Num=intersect(indX,indY);

            Num=intersect(Num,ZmaxInd);
            NodeNum(i)=Num;
            
            
        end
        close(fig_temp);
end 