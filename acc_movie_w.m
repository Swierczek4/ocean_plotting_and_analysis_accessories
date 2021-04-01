set(gca, 'defaultUicontrolFontName', 'Ubuntu')
set(gca, 'defaultUitableFontName', 'Ubuntu')
set(gca, 'defaultAxesFontName', 'Ubuntu')
set(gca, 'defaultTextFontName', 'Ubuntu')
set(gca, 'defaultUipanelFontName', 'Ubuntu')
% set(gca,'defaultAxesFontSize', 16)
% set(gca,'defaultTextFontSize', 16)
% fig = gcf;
% set(findall(fig, '-property', 'FontSize'), 'FontSize', 20)
ax = gca;
ax.FontSize = 23; 
set(gca, 'visible', 'on')
set(gca, 'color','w')
set(gcf,'color','w'); 
ax.LineWidth = 1.2;
ax.GridAlpha = 0.8;
ax.TickLength = [.02, 0.02];