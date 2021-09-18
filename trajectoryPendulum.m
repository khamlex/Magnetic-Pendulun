function [trajectoryPendulum_out] = trajectoryPendulum(trajectoryPendulum, newData, inicialisation, trajectoryLength)
    if inicialisation
        trajectoryPendulum_out = ones(trajectoryLength, 3).*trajectoryPendulum;
    else
        trajectoryPendulum_out = circshift(trajectoryPendulum, 1);
        trajectoryPendulum_out(1, :) = newData;
    end
end