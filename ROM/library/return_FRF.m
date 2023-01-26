function FRF=return_FRF(physicalMass,physicalK,physicalC,damperMass,damperK,damperC,freq)
    
    Point_num=length(physicalMass(:,1));
    omega=2*pi*freq;
    p=length(damperMass(1,:));N=length(physicalMass);
    
    M=physicalMass;
    M(end+1:end+p,end+1:end+p)=damperMass;
    M(end-p+1:end,1:p)=damperMass;
    convert=[eye(N) zeros(p);-eye(N) eye(p)];
    M=M*convert;
    K=makeKC(physicalK,damperK,convert);
    C=makeKC(physicalC,damperC,convert);
   
    M=reduceMat(M);
    K=reduceMat(K);
    C=reduceMat(C);
    sz=length(M(:,1));
    
    FRF=zeros(sz,sz,length(omega));
    for i=1:1:length(omega)
        w=omega(i);
        G=makeG(w,M,C,K,Point_num);
        FRF(:,:,i)=G;
    end
    
end
function G=makeG(w,M,C,K,Point_num)
    [V,D] = eig(K,M);%A*V = B*V*D
    [D,I]=sort(diag(D),'ascend');
   %sqrt(D)/2/pi
    V2=zeros(size(V));
    %figure()
    for i=1:1:length(I)
       V2(:,i)=V(:,I(i));
     %  if i<9
      % plot(V2(:,i))
      % hold on
       %end
    end
    %legend()
    
    
    V=modeNormlize(V2);
    modalMass=V'*M*V;
    modalK=V'*K*V;%このへんも結果的に等価質量というか、そもそもV2がいらん（ｖの時点で何故か正規化された形ででてくるので、（たぶんマトラボの仕様やけど、一応正規化もしてる））
    %Cはそのうち、レーリー減衰で実装すればよろしい。
    modalC=V'*C*V;
    Comp=-w^2*modalMass+modalK+1i*w*modalC;
    G=zeros(size(Comp));
    Mode=length(modalK(1,:));
    %G=inv(-w^2*M+K+1i*w*C);
    %V2(:,2)=-V2(:,2);V2(:,3)=-V2(:,3);%これ、マルチの方と合わせるためにいれてるけど、汎用性はないし、そもそもいるんかね。
   
    for input=1:1:Point_num%モードの数と点の数が同じなので、モードの数で書いてるだけ
    for output=1:1:Point_num
        for mode=1:1:Mode
            G(input,output)=G(input,output)+V(input,mode)*V(output,mode)/Comp(mode,mode);
        end
        
    end
    end
    
    
    
end
