function wysiwyg
%% Wie wird es genutzt?
% fnPDF3plts = 'DateiName';
% set(gcf, 'PaperType', 'a4letter');
% set(gcf, 'PaperUnits', 'centimeters');
% set(gcf, 'PaperPosition', [0.0 0.0 25.0 25.0]) --> umso größer, umso
% kleiner Schrift und legende
% wysiwyg
% 
% set(gcf, 'PaperSize', [22.0 10.0]) 
% print(gcf, '-dpdf', ['./figures/', fnPDF3plts]);

%% Beispiel:
%% 4 Zeilen, 1 Spalte
% set(gcf, 'PaperPosition', [-3 -2.75 35.0 40.0])
% set(gcf, 'PaperSize', [29.0 35])
%% 3 Zeilen, 1 Spalte
% set(gcf, 'PaperPosition', [-1.1 -1.1 25 20])
% set(gcf, 'PaperSize', [22 17.1])
%% 2 Zeilen, 1 Spalte
% set(gcf, 'PaperPosition', [-1.5 -0.25 25 15])
% set(gcf, 'PaperSize', [21.5 13.8])
%% 1 Zeile, 1 Spalte
% set(gcf, 'PaperPosition', [-1.5 0.1 25 10])
% set(gcf, 'PaperSize', [21.5 9.5])

unis = get(gcf,'units');
ppos = get(gcf,'paperposition');
set(gcf,'units',get(gcf,'paperunits'));
pos = get(gcf,'position');
pos(3:4) = ppos(3:4);
% pos(1:2) = [1 1];
set(gcf,'position',pos);
set(gcf,'units',unis);
  
