for i=1:MAXGEN
    figure(1);
    f1 = trace{i}(:,1);
    f2 = trace{i}(:,2);
    scatter(f1,f2);
    xlim([200,410]);
    ylim([20,45]);
    xlabel('Makespan','FontWeight','bold','FontSize',14);
    ylabel('MachineLoad','FontWeight','bold','FontSize',14);
    title(num2str(i), 'FontSize',14);
    drawnow;
    pause(0.1);
end 