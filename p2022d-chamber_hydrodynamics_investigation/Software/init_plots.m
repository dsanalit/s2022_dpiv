%TBD
% t_start, t_end
% flag to generate a pdf

% General variables
% colors
blue = [0    0.4470    0.7410];
red = [0.8500    0.3250    0.0980];
yellow = [0.9290    0.6940    0.1250];
green = [0.4660    0.6740    0.1880];


LineWidth = 2;
FontSize = 28; %20
FontSize_label = 28;
FontSize_axes = 22; %20
FontSize_legend = 18;
Position = [200 120];
Dimension = [1200 640];

r2d = 180/pi;
d2r = pi/180;
dim_raw = 1;
dim_col = 1;
ylabh = zeros(dim_raw*dim_col,1);
ylabPos = zeros(3,dim_raw*dim_col);
color = [blue' red' green' yellow'];
