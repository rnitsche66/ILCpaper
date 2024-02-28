%% load data
path = 'Messungen\';
load(append(path,'ILC_Sollsignal_DR70_Shruti_fric.mat'));
messung = ILC_Sollsignal_DR70_Shruti_fric;

%% extract values
% e_max = PA_getDSpaceDataByLabel(messung,'e_p4_max');
% e_rms = PA_getDSpaceDataByLabel(messung,'e_p4_rms');
% e_k = PA_getDSpaceDataByLabel(messung,'e_p4_k');
% y_d = PA_getDSpaceDataByLabel(messung,'p_d_bar');
% y_m = PA_getDSpaceDataByLabel(messung,'p_m_bar');
e_max = PA_getDSpaceDataByLabel(messung,'e_phi_max');
e_rms = PA_getDSpaceDataByLabel(messung,'e_phi_rms');
e_k = PA_getDSpaceDataByLabel(messung,'e_phi_k');
y_d = PA_getDSpaceDataByLabel(messung,'phi_d_deg');
y_m = PA_getDSpaceDataByLabel(messung,'phi_m_deg');
%
Nseq_tmp = PA_getDSpaceDataByLabel(messung,'Nseq');
t = PA_getDSpaceTime(messung);

t_max = 28; % 28 / 19
%% Nseq
% teilweise schwierig wegen downsampling in dSpace
Nseq = Nseq_tmp(1) * 2.5;
% Nseq = 95000;
%% 
iter_y = [1 2 5 20];
delta_t = 2;

iter_e = 1:99;
delta_j = 10;
e_log = logspace(-4,0,3); % erste Zahl vielfaches von letzter Zahl -1
%% plot
subplot(311);clf
plot(t(1:Nseq),y_d(1:Nseq),'red','LineWidth',2,'DisplayName','y_d')
hold on
% y_m_plot = zeros(1,Nseq);
lines = {'--', ':', '-.','--',':','-.'};
color = {'#0072BD','#D95319','#EDB120','#7E2F8E','#77AC30','#4DBEEE'};
i = 1;
for n = iter_y
    y_m_plot = y_m((n-1) * Nseq + 1: (n-1) * Nseq + Nseq );
    e_k_plot = e_k((n-1) * Nseq + 1: (n-1) * Nseq + Nseq );
    subplot(311)
    if n == 1
        plot(t(1:Nseq),y_m_plot,string(lines(i)),'DisplayName',['{\it y}_m after ',num2str(n),' iteration'],'LineWidth',2,'Color',string(color(i)));
    else
        plot(t(1:Nseq),y_m_plot,string(lines(i)),'DisplayName',['{\it y}_m after ',num2str(n),' iterations'],'LineWidth',2,'Color',string(color(i)));
    end
    hold on
    subplot(312)
    if n == 1
        plot(t(1:Nseq),e_k_plot,string(lines(i)),'DisplayName',['{\it e}_k after ',num2str(n),' iteration'],'LineWidth',2,'Color',string(color(i)));
    else
        plot(t(1:Nseq),e_k_plot,string(lines(i)),'DisplayName',['{\it e}_k after ',num2str(n),' iterations'],'LineWidth',2,'Color',string(color(i)));
    end
    hold on
    i = i + 1;
end
subplot(311);
set(gca, 'Fontsize', 14);
xlabel('{\it t}[s]','Interpreter','latex','FontSize', 20)
ylabel('$ \varphi_\mathrm{d}, \varphi_\mathrm{m} [^\circ] $','Interpreter','latex','FontSize', 20)
% ylabel('$p_\mathrm{d}, p_\mathrm{m} [\mathrm{bar}]$','Interpreter','latex','FontSize', 20)
xlim([0 t_max]);
set (gca, 'Xtick', 0:delta_t:t_max+delta_t);
ylim 'padded'
grid on
legend('Location','best','Fontsize',6)
% title('kp = $\pi$','Interpreter','latex','FontSize', 16)

subplot(312)
set(gca, 'Fontsize', 14);
xlabel('{\it t}[s]','Interpreter','latex','FontSize', 20)
ylabel('$e_{\mathrm{k}}[^\circ]$','Interpreter','latex','FontSize', 20)
% ylabel('$e_\mathrm{k}[\mathrm{bar}]$','Interpreter','latex','FontSize', 20)
grid on
xlim([0 t_max]);
set (gca, 'Xtick', 0:delta_t:t_max+delta_t);
ylim 'padded'
legend('Location','best','Fontsize',6)


%%
subplot(313);
% Nseq=420;
Nseq=28000; % Number of Elements per Sequenz
e_max_plot = zeros(1,numel(iter_e));
e_rms_plot = zeros(1,numel(iter_e));
for i = iter_e
    e_max_plot(i+1-iter_e(1)) = e_max(Nseq*i+1);
    e_rms_plot(i+1-iter_e(1)) = e_rms(Nseq*i+1);
end
e_infty_max = min(e_max_plot(10:end));
e_infty_rms = min(e_rms_plot(10:end));
semilogy(iter_e,e_max_plot,'LineWidth',2,'DisplayName','{\it e}_{max}')
hold on
semilogy(iter_e,e_rms_plot,'LineWidth',2,'DisplayName','{\it e}_{rms}')
set(gca, 'Fontsize', 14);
xlabel('Iterations','Interpreter','latex','FontSize', 20);
ylabel('$e_{\mathrm{max}}, e_{\mathrm{rms}}[^\circ]$','Interpreter','latex','FontSize', 20)
% ylabel('$e_{\mathrm{max}}, e_{\mathrm{rms}}[\mathrm{bar}]$','Interpreter','latex','FontSize', 20)
title(['$e_{\mathrm{max},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_max,'%.1e'), ' $^\circ \quad e_{\mathrm{rms},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_rms,'%.1e'),' $^\circ$'],'Interpreter','latex','FontSize', 20);
% title(['$e_{\mathrm{max},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_max,'%.1e'), ' bar \quad $e_{\mathrm{rms},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_rms,'%.1e'),' bar'],'Interpreter','latex','FontSize', 20);
grid on
set (gca, 'Xtick', 0:delta_j:max(iter_e)+delta_j);
set (gca, 'Ytick', e_log);

ylim 'padded'
lim_y = ylim;
% ylim([min(e_log) lim_y(2)]);
ylim([1e-2 lim_y(2)]);
% xlim([1 max(iter_e)]);
xlim([3 70]);
legend('Location','best','Fontsize',12)



%% pdf
fig_path = '.\';
fnPDF3plts = 'dSpace_Messung_ILC_DR70_Shruti2';
set(gcf, 'PaperType', 'a4letter');
set(gcf,'Color',[0.8471 0.8627 0.8824])
 
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [-1.0 -1.1 25 20])
PDF_cut
set(gcf, 'PaperSize', [22 17.1])
 
print(gcf, '-dpdf', [fig_path,fnPDF3plts])