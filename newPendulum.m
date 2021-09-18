function [structure] = newPendulum(L, alpha, beta)
    structure.p = [sin(deg2rad(beta))*cos(deg2rad(alpha)) sin(deg2rad(beta))*sin(deg2rad(alpha)) -cos(deg2rad(beta))].*L;
    structure.v = [0 0 0];
    structure.a = [0 0 0];
    structure.l = L;
end