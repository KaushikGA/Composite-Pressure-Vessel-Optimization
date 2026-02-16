 function getDiagnosticPlots (optRec )

fig=figure(1);
%fig.WindowState='maximized'

xAxis=[0 1:length(optRec.objectiveHistory)-1];


plot(xAxis,optRec.objectiveHistory,'-bo','LineWidth',2.0);

    hold on
plot(xAxis,optRec.meanTopPerformances,'-ro','LineWidth',2.0);    
    xlim([0 xAxis(end)+1]);xlabel('Gen');ylabel('Objective');
    title(['Current objective: ',num2str(optRec.objectiveHistory(end))]);
  drawnow;  
if length(xAxis)>4
    
fitobject = fit(xAxis',optRec.objectiveHistory','poly2');



plot(fitobject,'--r')
legend('Objective history','Mean top performers','Smoothed','FontSize',16)
else
legend('Objective history','Mean top performers','FontSize',16)
end
xlabel('Generation','FontSize',20,'FontWeight','bold')
ylabel('Objective','FontSize',20,'FontWeight','bold')
t=title('Optimization history');
t.FontSize = 20;


hold off

end