%close all;
clear all;
init_plots;
addpath('./utils');
%%
folder_name = 'EXP_CT_19122022-dev2/Transmission/';
exp_name = '*.ProcSpec';
spectrum = importOceanOptics(strcat('./data/', folder_name, exp_name));

fig = figure('name','Spectrum','Position',[Position, Dimension]);
set(fig,'defaulttextinterpreter','latex');
set(fig,'defaultAxesTickLabelInterpreter','latex');  
set(fig,'DefaultTextFontname', 'CMU Time');
ha = tight_subplot(dim_raw,dim_col,[0.2 1],[.16 .1],[.121 .017]); % (dim_h, dim_w, mar_axes[h,w], mar_hBox[b,t], mar_wBox[l,r])
i = 1;
axes(ha(i));

for k=1:length(spectrum)
    plot(spectrum(k).spectrum, 'LineWidth', LineWidth);
    hold on;
end
grid on;
legend(ha(i), '$air_{l-off}$', '$air_{l-on}$', '$beads_{0.1}$' ,'$beads_{1}$', ' ', '$beads_{0.3}$', '$beads_{0.7}$', '$beads_{10}$', '$ipa$', '$pbs$','$water_{l-off}$', '$water_{l-on}$','Interpreter','LaTex','FontSize', FontSize_legend);
ylabel('Spectrum','Interpreter','LaTex','FontSize', FontSize_label);

xlabel('$Frequency~[Hz]$','Interpreter','LaTex','FontSize', FontSize_label);