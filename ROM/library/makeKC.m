function K=makeKC(physicalK,damperK,convert)
    K=physicalK;
    N=length(K(:,1));p=length(damperK(1,:));
    K(N+1:N+p,N+1:N+p)=damperK;
    K(1:N,N+1:N+p)=-damperK;
    K(N+1:N+p,1:N)=zeros(p,N);
    K=K*convert;
end