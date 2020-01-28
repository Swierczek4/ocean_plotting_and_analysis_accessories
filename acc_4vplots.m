function acc_4vplots(n)
%% plotting tool

if n==1
    ax = gca;
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) - 0.065;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) + 0.05;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.075;
    ax.Position = [left bottom ax_width ax_height];
elseif n==2
    ax = gca;
    yticklabels({})
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) - 0.04;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) + 0.05;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.075;
    ax.Position = [left bottom ax_width ax_height];
elseif n==3
    ax = gca;
    yticklabels({})
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) - 0.015;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) + 0.05;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.075;
    ax.Position = [left bottom ax_width ax_height];
elseif n==4
    ax = gca;
    yticklabels({})
    outerpos = ax.OuterPosition;
    ti = ax.TightInset;
    left = outerpos(1) + ti(1) + 0.01;
    bottom = outerpos(2) + ti(2) + 0.01;
    ax_width = outerpos(3) - ti(1) - ti(3) + 0.035;
    ax_height = outerpos(4) - ti(2) - ti(4) - 0.075;
    ax.Position = [left bottom ax_width ax_height];
end

end
