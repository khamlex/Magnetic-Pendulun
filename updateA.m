function [a] = updateA(pendulum, a_in)
    a = pendulum.a + a_in;
end