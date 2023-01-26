function [mass,k,mode_shapes]=ROM_func(mode_shapes,mode_freqs)
%mass:物理的なモデルでの集中質量系
%k:物理的なモデルでの集中質量系の其々の質量の連成を含めたばね
%mode_shapes:修正したモード形状で、今、振幅の一番大きい所で割って、正規化してる


%ともかく、固有ベクトルは出ているものする
%modeshapes:列がモードで行が点
%固有振動数も出ている
Mesured_points_num=length(mode_shapes(:,1));
Mesured_modes_num=length(mode_shapes(1,:));
%各モードについて、（各点の振幅という意味で）固有ベクトルをいれていく
%列がモード行が点
f=diag(mode_freqs)*2*pi;
%修論メソッドでは、ともかくまずMを計算する
%mode_shapes=modeNormlize(mode_shapes);
mass=return_M(mode_shapes);
%モードと測定点は同じ数の方がよさそう
%修正行列N×M行列で、其々のpq要素には、p,qのための修正項がはいる（Nずつ、２N）これを後で加える？
alpha=0.01;%これ修正係数
return_M(mode_shapes);
num=1;now=eps_asym(mass)
Weight=ones(Mesured_points_num)-eye(Mesured_points_num);
while now>10^-7
    now=eps_asym(mass);
    mode_shapes_cpy=mode_shapes;
for p=1:1:Mesured_points_num
    for q=1:1:Mesured_points_num
        if p~=q
            kando=[mode_shapes(q,:);mode_shapes(p,:)];
            delta=-pinv(kando)*mass(p,q);delta=delta'*alpha;
            mode_shapes_cpy(p,:)=mode_shapes_cpy(p,:)+delta(1,:);
            mode_shapes_cpy(q,:)=mode_shapes_cpy(q,:)+delta(2,:);
            mass=return_M(mode_shapes_cpy);
        end
        end
end
    mode_shapes=mode_shapes_cpy;
    mass=return_M(mode_shapes);%ここで出てくるマスは、ｋｇの単位のやつ。実空間のやつ。
end
k=(mode_shapes')^-1*(f.^2)*(mode_shapes)^-1;%ここで出てくるＫも物理的なじつ空間の奴
mass=(mode_shapes')^-1*(mode_shapes)^-1;
%%%
%ここから、ともかくモードについて、どこか一点で質量を代表させてそれで正規化する
%deleg_point=[1,2,2]%最大値を多分とる（あとでやるわ）
%{
for mode=1:1:Mesured_modes_num
    mode_shapes(:,mode)=mode_shapes(:,mode)/max(abs(mode_shapes(:,mode)));
end
%}
%列がモード行が点
end

function eps=eps_asym(mass)
    eps=0;
    N=length(mass(:,1));M=length(mass(1,:));
    for i=1:1:N
        for j=1:1:M
            if i~=j
                eps=eps+abs(mass(i,j));
            end
        end
    end
end