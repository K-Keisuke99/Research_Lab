function equib_mass=equiblim_mass(mode_shapes,mass)
    equib_mass=zeros(1,length(mode_shapes));
    for mode=1:1:length(mode_shapes(:,1))
        [ind,maxPoint]=max(abs(mode_shapes(:,mode)));
        Mj=(mode_shapes(:,mode)./maxPoint)'*mass*(mode_shapes(:,mode)./maxPoint);
        equib_mass(mode)=sqrt(Mj);
    end
    equib_mass
end