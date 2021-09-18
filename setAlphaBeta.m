function [alpha, beta] = setAlphaBeta(pendulum_l, row_pixels, col_pixels, max_size)   
    if col_pixels >= row_pixels
        col_pendulum = max_size;
        row_pendulum = max_size*row_pixels/col_pixels;
    else
        row_pendulum = max_size;
        col_pendulum = max_size*col_pixels/row_pixels;
    end
    row = linspace(-col_pendulum, col_pendulum, col_pixels);
    col = linspace(-row_pendulum, row_pendulum, row_pixels);
    [ROW, COL] = meshgrid(row, col);
    alpha = rad2deg(atan2(COL, ROW));
    beta = rad2deg(asin(sqrt(ROW.*ROW + COL.*COL)/pendulum_l));
end