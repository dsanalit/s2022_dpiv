%close all;
clear all;
init_plots;
addpath('./utils');
%%
folder_name = 'EXP_CT_19122022-dev1/Transmission/';
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
legend(ha(i), '$air_{l-off}$', '$air_{l-on}$', '$pbs$','$water_{l-off}$', '$water_{l-on}$','Interpreter','LaTex','FontSize', FontSize_legend);
ylabel('Spectrum','Interpreter','LaTex','FontSize', FontSize_label);

xlabel('$Frequency~[Hz]$','Interpreter','LaTex','FontSize', FontSize_label);

%% Save
save_ck = 1;
name_exp = 'plots_specto_ref';
result_dir = 'pdf/'
if save_ck == 1
    set(gcf, 'PaperSize', [15 15]);
    set(gcf, 'PaperPositionMode', 'auto');
    print(fig,'-dpdf',strcat(result_dir,name_exp));
    system(['pdfcrop ',result_dir,name_exp,'.pdf ',result_dir,name_exp,'.pdf']);
end