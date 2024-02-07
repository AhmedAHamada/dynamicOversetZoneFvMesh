clear; clc; close all;
% Example: Define a non-linear curve (circle)
theta = linspace(0, 2*pi, 100);
X_original = cos(theta);
Y_original = sin(theta);

% Rediscretize the curve with 50 points
num_points_new = 50;
[X_new, Y_new] = rediscretize_curve(X_original, Y_original, num_points_new);
