close all;
clear all;
init_plots;
Dimension = [1200 640];
%%
folder_name = '2_references/';
exp_name = 'a_ref_light_off.mat';
load(strcat('./data/', folder_name, exp_name));
air_ref_light_off = A;

exp_name = 'a_ref_light_on.mat';
load(strcat('./data/', folder_name, exp_name));
air_ref_light_on = A;

exp_name = 'w_ref_light_off.mat';
load(strcat('./data/', folder_name, exp_name));
water_ref_light_off = A;

exp_name = 'w_ref_light_on.mat';
load(strcat('./data/', folder_name, exp_name));
water_ref_light_on = A;


mean_air_ref_light_off = mean(air_ref_light_off);
mean_air_ref_light_on = mean(air_ref_light_on);
mean_water_ref_light_off = mean(water_ref_light_off);
mean_water_ref_light_on = mean(water_ref_light_on);


std_err_0 = std(air_ref_light_off);
std_err_1 = std(air_ref_light_on);
std_err_2 = std(water_ref_light_off);
std_err_3 = std(water_ref_light_on);

mean_err = abs([mean_air_ref_light_off', mean_air_ref_light_on', mean_water_ref_light_off', mean_water_ref_light_on']);
std_err = abs([std_err_0', std_err_1', std_err_2', std_err_3']);

exp_name = 'pbs.mat';
if isfile(strcat('./data/', folder_name, exp_name))
    load(strcat('./data/', folder_name, exp_name));
    pbs = A;
    mean_pbs = mean(water_ref_light_on);
    std_err_4 = std(pbs);
    mean_err = abs([mean_air_ref_light_off', mean_air_ref_light_on', mean_water_ref_light_off', mean_water_ref_light_on' mean_pbs']);
    std_err = abs([std_err_0', std_err_1', std_err_2', std_err_3' std_err_4']);
    
end

clear A Length RequestedLength Tinterval Tstart Version ExtraSamples

%% Figure
fig = figure('name','Transmission Rate','Position',[Position, Dimension]);
set(fig,'defaulttextinterpreter','latex');
set(fig,'defaultAxesTickLabelInterpreter','latex');  
set(fig,'DefaultTextFontname', 'CMU Time');
ha = tight_subplot(dim_raw,dim_col,[0.1 0.1],[.16 .1],[.121 .017]); % (dim_h, dim_w, mar_axes[h,w], mar_hBox[b,t], mar_wBox[l,r])
i = 1;
axes(ha(i));
b = bar(mean_err);
%title(ha(i),'$\bar{V}_x(t)$','FontSize', FontSize_label)
grid on;
%legend(ha(i), '$\hat{\alpha}_{12}$', '$\hat{\alpha}_{34}$','$\hat{\alpha}_{56}$','Interpreter','LaTex','FontSize', FontSize);
ylabel('Voltage $[V]$','Interpreter','LaTex','FontSize', FontSize_label);
ylim([0 0.04]);

clear string;
ticks = string(zeros(4,1));
ticks(1) = '$air_{l_{off}}$'; 
ticks(2) = '$air_{l_{on}}$'; 
ticks(3) = '$water_{l_{off}}$'; 
ticks(4) = '$water_{l_{on}}$'; 

ticks(5) = '$pbs$'; 

set(ha(i),'XTicklabels', ticks, 'XTickLabelMode', 'manual','FontSize', FontSize_label);

% Find the number of groups and the number of bars in each group
[ngroups, nbars] = size(mean_err');

% Calculate the width for each bar group
groupwidth = min(0.8, nbars/(nbars + 1.5));
hold on;
% Set the position of each error bar in the centre of the main bar
% Based on barweb.m by Bolu Ajiboye from MATLAB File Exchange
for kk = 1:nbars
    % Calculate center of each bar
    x = (1:ngroups) - groupwidth/2 + (2*kk-1) * groupwidth / (2*nbars);
    errorbar(x, mean_err(kk,:), std_err(kk,:), 'k', 'linestyle', 'none', 'HandleVisibility','off');
end
hold off

%% Save
save_ck = 1;
name_exp = 'bar_plots_PD_ref';
result_dir = 'pdf/'
if save_ck == 1
    set(gcf, 'PaperSize', [15 15]);
    set(gcf, 'PaperPositionMode', 'auto');
    print(fig,'-dpdf',strcat(result_dir,name_exp));
    system(['pdfcrop ',result_dir,name_exp,'.pdf ',result_dir,name_exp,'.pdf']);
end
