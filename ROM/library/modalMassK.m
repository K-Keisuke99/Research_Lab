function [Mm,Km,ms_norm_rep_point_amp]=modalMassK(mass,K,mode_shapes,modal_freq)
    Omega=modal_freq*2*pi;
    %まず、mode_shapesを、各モードで最大振幅で正規化する（これはモーダル質量をその点でのエネルギー釣り合わせととるため）
    ms_norm_rep_point_amp=modeNormlize(mode_shapes);
    %次にMmを各モードについて、作る
    num_modes=length(mode_shapes(:,1));
    num_points=length(mode_shapes(1,:));
    Mm=zeros(num_points,num_modes);
    Km=zeros(num_points,num_modes);
    for i=1:1:num_modes
        Mi=ms_norm_rep_point_amp(:,i)'*mass*ms_norm_rep_point_amp(:,i);%massは集中質量系にしたやつ
        Mm(i,i)=Mi;
        Ki=Mi*Omega(i)^2;
        Km(i,i)=Ki;
    end
    
end