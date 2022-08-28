load color
chrom_best = chroms(1,:);
[Z,pvals,machinecode] = fitness(chrom_best,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
pval1 = pvals{1,1};
figure(2);
% set(gca, 'position', [0.03,0.10,0.95,0.85]);
y = [];
label = cell(1,num_machine);
for m=1:num_machine
    y = [y,m];
    n = ['Machine',num2str(m)];
    label{1,m} = n;
end 
yticks(y);
yticklabels(label);
% set(gca,'YTickLabel', 'FontSize',14)
xlabel('Time','FontWeight','bold','FontSize',14);
% ylabel('Machine','FontWeight','bold','FontSize',14);
job_op=zeros(1,num_job);    % 记录工件进行到第几步工序
for i=1:total_op_num
    job_op(chrom_best(i)) = job_op(chrom_best(i)) + 1;
    b=chrom_best(i); %b表示该步工序对应第几个工件
    innertext = [num2str(b),'-',num2str(job_op(b))];
    outtext1 = ['(',num2str(pval1{1,i}(1)),',',num2str(pval1{1,i}(2)),',',num2str(pval1{1,i}(3)),')'];
    outtext2 = ['(',num2str(pval1{2,i}(1)),',',num2str(pval1{2,i}(2)),',',num2str(pval1{2,i}(3)),')'];
    % 开始时间
    v1 = [pval1{1,i}(1) machinecode(i);pval1{1,i}(2) machinecode(i)-0.4;pval1{1,i}(3) machinecode(i)];
    f1 = [1,2,3];
    patch('Faces',f1,'Vertices',v1,'FaceColor',color(b,:),'FaceAlpha',0.3);
    if pval1{1,i}(2)~=0
        text(pval1{1,i}(2),machinecode(i)-0.15,innertext,'HorizontalAlignment','center','fontsize',9);
        text(pval1{1,i}(2),machinecode(i)-0.4,outtext1,'fontsize',8);
    end 
    % 结束时间
    v2 = [pval1{2,i}(1) machinecode(i);pval1{2,i}(2) machinecode(i)+0.4;pval1{2,i}(3) machinecode(i)];
    f2 = [1,2,3];
    patch('Faces',f2,'Vertices',v2,'FaceColor',color(b,:),'FaceAlpha',0.3);
    text(pval1{2,i}(2),machinecode(i)+0.15,innertext,'HorizontalAlignment','center','fontsize',9);
    text(pval1{2,i}(2),machinecode(i)+0.4,outtext2,'fontsize',8);
end 