function A=reduceMat(A)
    
    xx=sum(abs(A),2);
    ind=xx==0;
    
    A(ind,:)=[];
    A(:,ind)=[];
end