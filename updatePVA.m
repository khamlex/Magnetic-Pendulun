function [p, v, a] = updatePVA(pendulum, dt)
    v = pendulum.v + pendulum.a*dt;
    xy = pendulum.p + v*dt;
    xy = xy(1:2);
    p = [xy, -sqrt(pendulum.l^2 - xy*xy')];
    a = [0 0 0];
end