function [X_new, Y_new] = rediscretize_curve(X, Y, num_points)
    % Inputs:
    %   X, Y: Original coordinates of the non-linear curve.

    % Calculate the cumulative arc length of the original curve
    arc_length = cumsum(sqrt(diff(X).^2 + diff(Y).^2));

    % Normalize the arc length to [0, 1]
    normalized_arc_length = arc_length / arc_length(end);

    % Generate a normalized parameter vector for the new points
    t_new = linspace(0, 1, num_points);

    % Interpolate to get the new coordinates based on equal arc length
    X_new = interp1([0,normalized_arc_length], X, t_new); %, 'pchip');
    Y_new = interp1([0,normalized_arc_length], Y, t_new); %, 'pchip');
end
