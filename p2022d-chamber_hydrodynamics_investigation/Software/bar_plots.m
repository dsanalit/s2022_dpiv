%%
close all;
clear all;
init_plots;

%%

OF_1_CAD_1 = 25;
OF_2_CAD_1 = 35;

OF_1_CAD_2 = 35;
OF_2_CAD_2= 57;

OF_1_CAD_3 = 42;
OF_2_CAD_3 = 62;

r1 = [OF_1_CAD_1, OF_1_CAD_2, OF_1_CAD_3];
r2 = [OF_2_CAD_1, OF_2_CAD_2, OF_2_CAD_3];

rt= [r1;r2]

fig = figure('name','Position Error','Position',[Position, Dimension]);
set(fig,'defaulttextinterpreter','latex');
set(fig,'defaultAxesTickLabelInterpreter','latex');  
set(fig,'DefaultTextFontname', 'CMU Time');
ha = tight_subplot(dim_raw,dim_col,[0.2 1],[.16 .1],[.121 .017]); % (dim_h, dim_w, mar_axes[h,w], mar_hBox[b,t], mar_wBox[l,r])
i = 1;
axes(ha(i));
b = bar(rt);
%title(ha(i),'$\bar{V}_x(t)$','FontSize', FontSize_label)
grid on;
legend(ha(i), '$D$-1', '$D$-2','$D$-3','Interpreter','LaTex','FontSize', FontSize_legend);
ylabel('Incident Rays Number','Interpreter','LaTex','FontSize', FontSize_label);
xlim([0.5 2.7]);
ylim([0 70]);

ticks = string(zeros(4,1));
ticks(1) = '$OF_{1}$'; 
ticks(2) = '$OF_{2}$';

% xtips1 = b(1).XEndPoints;
% ytips1 = b(1).YEndPoints;
% labels1 = string(b(1).YData);
% text(xtips1,ytips1,labels1,'HorizontalAlignment','center',...
%     'VerticalAlignment','bottom')
% 
% xtips2 = b(2).XEndPoints;
% ytips2 = b(2).YEndPoints;
% labels2 = string(b(2).YData);
% text(xtips2,ytips2,labels2,'HorizontalAlignment','center',...
%     'VerticalAlignment','bottom')


set(ha(i),'XTicklabels', ticks, 'XTickLabelMode', 'manual','FontSize', FontSize_label);
xlabel('$\textnormal{Output Optical Fibers}$','Interpreter','LaTex','FontSize', FontSize_label);

b(1,1).FaceColor = color(:,1);
b(1,2).FaceColor = color(:,2);
b(1,3).FaceColor = color(:,3);

%% Save
save_ck = 1;
name_exp = 'bar_plots';
result_dir = 'pdf/'
if save_ck == 1
    set(gcf, 'PaperSize', [15 15]);
    set(gcf, 'PaperPositionMode', 'auto');
    print(fig,'-dpdf',strcat(result_dir,name_exp));
    system(['pdfcrop ',result_dir,name_exp,'.pdf ',result_dir,name_exp,'.pdf']);
end