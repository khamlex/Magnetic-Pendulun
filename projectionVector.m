function [out] = projectionVrctor(plane_norm, vector)
    a = cross(plane_norm, cross(plane_norm, vector));
    alpha = a*vector'/(a*a');
    out = a*alpha;
end