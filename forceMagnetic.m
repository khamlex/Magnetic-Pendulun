function [a] = magnetic(pendulum, magnet)
    vec = magnet.p - pendulum.p;
    a = magnet.k*vec/(vec*vec')^(3/2);
end