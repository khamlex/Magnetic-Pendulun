function [out] = convergedTo(trajectory_pendulum, trajectory_magnets)
    traj_in = trajectory_magnets - ones(size(trajectory_magnets, 1), 3).*trajectory_pendulum(1, :);
    inner = sum(traj_in.*traj_in, 2);
    minValue = min(inner);
    [row, ~] = find(inner == minValue);
    out = row(1);
end