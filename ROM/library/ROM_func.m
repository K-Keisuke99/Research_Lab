function [mass,k,mode_shapes]=ROM_func(mode_shapes,mode_freqs)
%mass:�����I�ȃ��f���ł̏W�����ʌn
%k:�����I�ȃ��f���ł̏W�����ʌn�̑��X�̎��ʂ̘A�����܂߂��΂�
%mode_shapes:�C���������[�h�`��ŁA���A�U���̈�ԑ傫�����Ŋ����āA���K�����Ă�


%�Ƃ������A�ŗL�x�N�g���͏o�Ă�����̂���
%modeshapes:�񂪃��[�h�ōs���_
%�ŗL�U�������o�Ă���
Mesured_points_num=length(mode_shapes(:,1));
Mesured_modes_num=length(mode_shapes(1,:));
%�e���[�h�ɂ��āA�i�e�_�̐U���Ƃ����Ӗ��Łj�ŗL�x�N�g��������Ă���
%�񂪃��[�h�s���_
f=diag(mode_freqs)*2*pi;
%�C�_���\�b�h�ł́A�Ƃ������܂�M���v�Z����
%mode_shapes=modeNormlize(mode_shapes);
mass=return_M(mode_shapes);
%���[�h�Ƒ���_�͓������̕����悳����
%�C���s��N�~M�s��ŁA���X��pq�v�f�ɂ́Ap,q�̂��߂̏C�������͂���iN���A�QN�j�������ŉ�����H
alpha=0.01;%����C���W��
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
    mass=return_M(mode_shapes);%�����ŏo�Ă���}�X�́A�����̒P�ʂ̂�B����Ԃ̂�B
end
k=(mode_shapes')^-1*(f.^2)*(mode_shapes)^-1;%�����ŏo�Ă���j�������I�Ȃ���Ԃ̓z
mass=(mode_shapes')^-1*(mode_shapes)^-1;
%%%
%��������A�Ƃ��������[�h�ɂ��āA�ǂ�����_�Ŏ��ʂ��\�����Ă���Ő��K������
%deleg_point=[1,2,2]%�ő�l�𑽕��Ƃ�i���Ƃł���j
%{
for mode=1:1:Mesured_modes_num
    mode_shapes(:,mode)=mode_shapes(:,mode)/max(abs(mode_shapes(:,mode)));
end
%}
%�񂪃��[�h�s���_
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