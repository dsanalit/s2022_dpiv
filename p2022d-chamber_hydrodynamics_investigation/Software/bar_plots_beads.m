close all;
clear all;
init_plots;
Dimension = [1200 640];
%%
folder_name = '3_exps/';
exp_name = 'beads_0.1_f=0.1.mat';
load(strcat('./data/', folder_name, exp_name));
beads_01 = A;

exp_name = 'beads_0.3_f=0.1.mat';
load(strcat('./data/', folder_name, exp_name));
beads_03 = A;

exp_name = 'beads_0.7_f=0.1.mat';
load(strcat('./data/', folder_name, exp_name));
beads_07 = A;

exp_name = 'beads_1_f=0.1.mat';
load(strcat('./data/', folder_name, exp_name));
beads_1 = A;

exp_name = 'beads_10_f=0.1.mat';
load(strcat('./data/', folder_name, exp_name));
beads_10 = A;

mean_beads_01 = mean(beads_01);
mean_beads_03 = mean(beads_03);
mean_beads_07 = mean(beads_07);
mean_beads_1 = mean(beads_1);
mean_beads_10 = mean(beads_10);


std_err_0 = std(beads_01);
std_err_1 = std(beads_03);
std_err_2 = std(beads_07);
std_err_3 = std(beads_1);
std_err_4 = std(beads_10);

mean_err = abs([mean_beads_01', mean_beads_03', mean_beads_07', mean_beads_1' mean_beads_10']);
std_err = abs([std_err_0', std_err_1', std_err_2', std_err_3' std_err_4']);


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
ticks(1) = '$C=0.1 [?]$'; 
ticks(2) = '$C=0.3$'; 
ticks(3) = '$C=0.7$'; 
ticks(4) = '$C=1$'; 
ticks(5) = '$C=10$'; 

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
name_exp = 'bar_plots_PD_beads';
result_dir = 'pdf/'
if save_ck == 1
    set(gcf, 'PaperSize', [15 15]);
    set(gcf, 'PaperPositionMode', 'auto');
    print(fig,'-dpdf',strcat(result_dir,name_exp));
    system(['pdfcrop ',result_dir,name_exp,'.pdf ',result_dir,name_exp,'.pdf']);
end
