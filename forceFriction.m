function [a] = friction(pendulum, k)
    a = pendulum.a - pendulum.v*k;
end