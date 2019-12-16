ax = gca;
xticklabels({})
colorbar('off')
colormap(ax2,cm)
outerpos = ax.OuterPosition;
ti = ax.TightInset;
left = outerpos(1)-0.045;
bottom = outerpos(2) + ti(2)-0.03;
ax_width = outerpos(3) + 0.029;
ax_height = outerpos(4) - ti(2) - ti(4) + 0.05;
ax.Position = [left bottom ax_width ax_height];