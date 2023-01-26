function [Mm,Km,ms_norm_rep_point_amp]=modalMassK(mass,K,mode_shapes,modal_freq)
    Omega=modal_freq*2*pi;
    %�܂��Amode_shapes���A�e���[�h�ōő�U���Ő��K������i����̓��[�_�����ʂ����̓_�ł̃G�l���M�[�ނ荇�킹�ƂƂ邽�߁j
    ms_norm_rep_point_amp=modeNormlize(mode_shapes);
    %����Mm���e���[�h�ɂ��āA���
    num_modes=length(mode_shapes(:,1));
    num_points=length(mode_shapes(1,:));
    Mm=zeros(num_points,num_modes);
    Km=zeros(num_points,num_modes);
    for i=1:1:num_modes
        Mi=ms_norm_rep_point_amp(:,i)'*mass*ms_norm_rep_point_amp(:,i);%mass�͏W�����ʌn�ɂ������
        Mm(i,i)=Mi;
        Ki=Mi*Omega(i)^2;
        Km(i,i)=Ki;
    end
    
end