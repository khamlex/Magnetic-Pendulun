function [out] = render_old(row_id, col_id, pendulum_l, alpha, beta, magnet, trajectory_magnets, dt, g, k, same_res_all)
    magnets_all = size(trajectory_magnets, 1);
    out = nan(1, col_id);
    for col = 1:col_id
        pendulum = newPendulum(pendulum_l, alpha(1, col), beta(1, col));
        same_res_now = 0;
        iter_now = 0;
        res_prev = 0;
        while same_res_now < same_res_all
            if mod(iter_now, 2) == 0
                if res_prev == convergedTo(pendulum.p, trajectory_magnets)
                    same_res_now =  same_res_now + 1;
                else
                    res_prev = convergedTo(pendulum.p, trajectory_magnets);
                    same_res_now = 0;
                end
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
        out(1, col) = res_prev;
    end
end