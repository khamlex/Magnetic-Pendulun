close all
clearvars
clc

dt = 0.05;
g = -9.81;
k = 0.01;
magnets_all = 3;
magnets_R = 6;
magnets_h = 50;
magnets_power = 300;
row_pixels = 2;
col_pixels = 2;
pendulum_l = 48;

[magnet, trajectory_magnets] = trajectoryMagnets(magnets_R , -magnets_h, magnets_all, magnets_power);

[alpha, beta] = setAlphaBeta(pendulum_l, row_pixels, col_pixels, pendulum_l*3/10);


set(gcf,'color','w', 'Position', [960 0 960 1000]);

view_angle = 0;

pendulum = newPendulum(pendulum_l, 0, 20);
pendulum.v = [-3, -4, 0];
trajectory_pendulum = trajectoryPendulum(pendulum.p, [], 1, 100);
same_res_now = 0;
same_res_all = 50;
iter_now = 0;
res_prev = 0;
t0 = clock();
while etime(clock, t0) < 23
    if mod(iter_now, 2) == 0
        trajectory_pendulum = trajectoryPendulum(trajectory_pendulum, pendulum.p, 0, 0);
        clf
        hold on
        plot3(trajectory_pendulum(:, 1), trajectory_pendulum(:, 2), trajectory_pendulum(:, 3), 'black.', MarkerSize=10);
        plot3([0 trajectory_pendulum(1, 1)], [0 trajectory_pendulum(1, 2)], [0 trajectory_pendulum(1, 3)], 'black-');
        plot3(trajectory_pendulum(1, 1), trajectory_pendulum(1, 2), trajectory_pendulum(1, 3), 'black.', MarkerSize=35);
        plot3(trajectory_magnets(:, 1), trajectory_magnets(:, 2), trajectory_magnets(:, 3), 'r.', MarkerSize=35);
        xlim([-pendulum.l/2 pendulum.l/2]);
        ylim([-pendulum.l/2 pendulum.l/2]);
        zlim([-magnets_h 0]);
        view_angle = view_angle + 1;
        view([view_angle/10+5, 25])
        daspect([1 1 1]);
        box on
        grid on
        drawnow
    end
    pendulum.a = updateA(pendulum, forcePullback(g));
    pendulum.a = updateA(pendulum, forceFriction(pendulum, k));
    for kk = 1:magnets_all
        pendulum.a = updateA(pendulum, forceMagnetic(pendulum, magnet(kk)));
    end
    pendulum.a = projectionVector(-pendulum.p, pendulum.a);
    [pendulum.p, pendulum.v, pendulum.a] = updatePVA(pendulum, dt);
    iter_now = iter_now + 1;
end
