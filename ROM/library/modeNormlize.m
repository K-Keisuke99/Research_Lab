function normlizedMode=modeNormlize(mode_shapes)

for mode=1:1:length(mode_shapes(1,:))
    [Maxi,ind]=max(abs(mode_shapes(:,mode)));
    %mode
    %ind
    mode_shapes(:,mode)=mode_shapes(:,mode)/Maxi;
end
normlizedMode=mode_shapes;
end