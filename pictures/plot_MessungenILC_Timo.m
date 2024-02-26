% Messungen von Timo laden und visualisieren - 22.02.2024/nitr
addpath('./Messungen')
% messung = load('P_Type_pJoint_PI_ILC.mat');
messung = load('P_Typ_PT1_ILC_kp_15_PID_P_6_1_I_2_9_para.mat');
rmpath('./Messungen')

e_max = messung.data.getElement('e_max').Values.Data;
e_rms = messung.data.getElement('e_rms').Values.Data;
e_k = messung.data.getElement('e_k').Values.Data;
% y_d = messung.data.getElement('y_d').Values.Data;
% y_m = messung.data.getElement('y_m').Values.Data;
y_d = messung.data.getElement('phi_d').Values.Data;
y_m = messung.data.getElement('phi_m').Values.Data;
% Nseq = messung.data.getElement('Nseq').Values.Data;
Nseq = 28000;
t = messung.data.getElement('e_k').Values.Time;

%% Parameter je nach Messung
t_max = 28;  % 19 für konstantes Volumen, 42 für lineare Systeme, 28 pJoint

% y und e Schaubild
iter_y = [1 2 5 20];
% iter_y = [1 2]; % für G_inv
delta_t = 4;

% e_inf Schaubild
iter_e = 1:500;
delta_j = 50;
e_log = logspace(-3,0,2); % erste Zahl vielfaches von letzter Zahl -1
%%
subplot(311)
plot(t(1:Nseq),y_d(1:Nseq),'red','LineWidth',2,'DisplayName','{\it y}_d')
hold on
y_m_plot = zeros(1,Nseq);
lines = {'--', ':', '-.','--',':','-.'};
color = {'#0072BD','#D95319','#EDB120','#7E2F8E','#77AC30','#4DBEEE'};
i = 1;
for n = iter_y
    y_m_plot = y_m((n-1) * Nseq + 1: (n-1) * Nseq + Nseq );
    e_k_plot = e_k((n-1) * Nseq + 1: (n-1) * Nseq + Nseq );
    subplot(311)
    if n == 1
        plot(t(1:Nseq),y_m_plot,string(lines(i)),'DisplayName',['{\it y}_m nach ',num2str(n),' Iteration'],'LineWidth',2,'Color',string(color(i)));
    else
        plot(t(1:Nseq),y_m_plot,string(lines(i)),'DisplayName',['{\it y}_m nach ',num2str(n),' Iterationen'],'LineWidth',2,'Color',string(color(i)));
    end
    hold on
    subplot(312)
    if n == 1
        plot(t(1:Nseq),e_k_plot,string(lines(i)),'DisplayName',['{\it e}_k nach ',num2str(n),' Iteration'],'LineWidth',2,'Color',string(color(i)));
    else
        plot(t(1:Nseq),e_k_plot,string(lines(i)),'DisplayName',['{\it e}_k nach ',num2str(n),' Iterationen'],'LineWidth',2,'Color',string(color(i)));
    end
    hold on
    i = i + 1;
end
subplot(311)
set(gca, 'Fontsize', 14);
xlabel('{\it t}[s]','Interpreter','latex','FontSize', 20)
ylabel('$\varphi_\mathrm{d}, \varphi_\mathrm{m} [^\circ]$','Interpreter','latex','FontSize', 20)
% ylabel('$p_\mathrm{d}, p_\mathrm{m} [\mathrm{bar}]$','Interpreter','latex','FontSize', 20)
% ylabel('$p_\mathrm{d}, p_\mathrm{m}$','Interpreter','latex','FontSize', 20)
xlim([0 t_max]);
set (gca, 'Xtick', 0:delta_t:t_max+delta_t);
ylim 'padded'
grid on
legend('Location','best','Fontsize',6)

subplot(312)
set(gca, 'Fontsize', 14);
xlabel('{\it t}[s]','Interpreter','latex','FontSize', 20)
ylabel('$e_\mathrm{k}[^\circ]$','Interpreter','latex','FontSize', 20)
% ylabel('$e_\mathrm{k}[\mathrm{bar}]$','Interpreter','latex','FontSize', 20)
% ylabel('$e_\mathrm{k}$','Interpreter','latex','FontSize', 20)
grid on
xlim([0 t_max]);
set (gca, 'Xtick', 0:delta_t:t_max+delta_t);
ylim 'padded'
legend('Location','best','Fontsize',6)
%%
%subplot(312)


%%
subplot(313)
%Nseq=420;
e_max_plot = zeros(1,numel(iter_e));
e_rms_plot = zeros(1,numel(iter_e));
for i = iter_e
    e_max_plot(i+1-iter_e(1)) = e_max(Nseq*i+1);
    e_rms_plot(i+1-iter_e(1)) = e_rms(Nseq*i+1);
end
e_infty_max = min(e_max_plot);
e_infty_rms = min(e_rms_plot);
semilogy(iter_e,e_max_plot,'LineWidth',2,'DisplayName','{\it e}_{max}')
hold on
semilogy(iter_e,e_rms_plot,'LineWidth',2,'DisplayName','{\it e}_{rms}')
set(gca, 'Fontsize', 14);
xlabel('Iterationen','Interpreter','latex','FontSize', 20);
ylabel('$e_{\mathrm{max}}, e_{\mathrm{rms}}[^\circ]$','Interpreter','latex','FontSize', 20)
% ylabel('$e_{\mathrm{max}}, e_{\mathrm{rms}}[\mathrm{bar}]$','Interpreter','latex','FontSize', 20)
% ylabel('$e_{\mathrm{max}}, e_{\mathrm{rms}}$','Interpreter','latex','FontSize', 20)
title(['$e_{\mathrm{max},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_max,'%.1e'), ' $^\circ$ \quad $e_{\mathrm{rms},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_rms,'%.1e'),' $^\circ$'],'Interpreter','latex','FontSize', 20);
% title(['$e_{\mathrm{max},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_max,'%.1e'), ' bar \quad $e_{\mathrm{rms},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_rms,'%.1e'),' bar'],'Interpreter','latex','FontSize', 20);
% title(['$e_{\mathrm{max},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_max,'%.1e'), '\quad $e_{\mathrm{rms},',num2str(size(e_max_plot,2)),'} = $ ',num2str(e_infty_rms,'%.1e')],'Interpreter','latex','FontSize', 20);
grid on
set (gca, 'Xtick', 0:delta_j:max(iter_e)+delta_j);

set (gca, 'Ytick', e_log);
ylim 'padded'
lim_y = ylim;
% ylim([min(e_log) lim_y(2)]);
xlim([1 max(iter_e)]);
legend('Location','best','Fontsize',12)

% % 
fnPDF3plts = 'Messung_pJoint';
set(gcf, 'PaperType', 'a4letter');
%set(gcf,'Color',[0.8471 0.8627 0.8824])

set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperPosition', [-1.1 -1.1 25 20])
PDF_cut
set(gcf, 'PaperSize', [22 17.1])
print(gcf, '-dpdf', ['./',fnPDF3plts])