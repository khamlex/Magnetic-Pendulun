function [p] = projectionTrajectory(trajectory, h)
    p = zeros(size(trajectory, 1), 3);
    for i = 1:size(trajectory, 1)
        k = abs(h/trajectory(i, 3));
        p(i, :) = [trajectory(i, 1)*k trajectory(i, 2)*k -abs(h)];
    end
end