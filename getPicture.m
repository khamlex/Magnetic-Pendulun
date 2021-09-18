close all
clearvars
clc

dt = 0.05;
g = -9.81;
k = 0.25;
magnets_all = 3;
magnets_R = 6;
magnets_h = 50;
magnets_power = 400;
row_pixels = 600;
col_pixels = 600;
pendulum_l = 48;
[magnet, trajectory_magnets] = trajectoryMagnets(magnets_R , -magnets_h, magnets_all, magnets_power);

[alpha, beta] = setAlphaBeta(pendulum_l, row_pixels, col_pixels, pendulum_l*5/10);

data = nan(row_pixels, col_pixels);
tic
parfor ii = 1:round(row_pixels/2)
    data(ii, :) = render_C(ii, col_pixels, pendulum_l, alpha(ii, :), beta(ii, :), magnet, trajectory_magnets, dt, g, k, 40);
end
for ii = 1:row_pixels/2
    data(row_pixels+1-ii, :) = mod((magnets_all + 1) - data(ii, :), magnets_all) + 1;
end
toc
out = zeros(row_pixels, col_pixels, 3);
for ii = 1:row_pixels
    for jj = 1:col_pixels
        switch data(ii, jj)
            case 1
                out(ii, jj, :) = [1 0 0];
            case 2
                out(ii, jj, :) = [0 1 0];
            case 3
                out(ii, jj, :) = [0 0 1];
        end
    end
end
set(gcf,'color','w', 'Position', [960 0 960 1000]);
imshow(out);
imsave
daspect([1 1 1]);