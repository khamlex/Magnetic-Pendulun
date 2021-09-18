function [magnet, trajectoryMagnets] =trajectoryMagnets(R, H, all_magnets, power)
    counter = 1;
    trajectoryMagnets = zeros(all_magnets, 3);
    for ii = 1:360/all_magnets:360
        angle = deg2rad(ii);
        magnet(counter) = newMagnet(R*cos(angle), R*sin(angle), H, power);
        trajectoryMagnets(counter, :) = magnet(counter).p;
        counter = counter + 1;
    end
end