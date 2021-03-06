function acc_quad_movies(n)
if n==1
    ax = gca;
    xticklabels({})
    colorbar('off')
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.033;
    bottom = outerpos(2) + ti(2)-0.03;
    ax_width = outerpos(3) + 0.030;
    ax_height = outerpos(4) - ti(2) - ti(4) + 0.05;
    ax.Position = [left bottom ax_width ax_height];
elseif n==2
    ax = gca;
    xticklabels({})
    yticklabels({})
    colorbar('off')
%    colormap(ax2,cm)
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.043;
    bottom = outerpos(2) + ti(2)-0.03;
    ax_width = outerpos(3) + 0.010;
    ax_height = outerpos(4) - ti(2) - ti(4) + 0.05;
    ax.Position = [left bottom ax_width ax_height];
elseif n==3
    ax = gca;
    colorbar('off')
%    colormap(ax3,cm)
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.033;
    bottom = outerpos(2) + ti(2)-0.05;
    ax_width = outerpos(3) + 0.019;
    ax_height = outerpos(4) - ti(2) - ti(4) + 0.07;
    ax.Position = [left bottom ax_width ax_height];
elseif n==4
    ax = gca;
    yticklabels({})
%    colormap(ax4,cm)
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1)-0.050;
    bottom = outerpos(2) + ti(2)-0.05;
    ax_width = outerpos(3) + 0.076;
    ax_height = outerpos(4) - ti(2) - ti(4) + 0.07;
    ax.Position = [left bottom ax_width ax_height];
    colorbar('Position', [left+ax_width+0.010 bottom 0.02 2.14*ax_height])
end
end

