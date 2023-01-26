function mass=return_M(mode_shapes)

    mass=mode_shapes*mode_shapes';
    %mass=inv(mass);
end 