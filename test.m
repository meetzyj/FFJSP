load color
[~,Z,pvals,machinecode] = fitness2(chrom_best,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
pval1 = pvals{1,1};
figure(2);
% set(gca, 'position', [0.03,0.10,0.95,0.85]);
xlabel('Time','FontWeight','bold','FontSize',14);
ylabel('Machine','FontWeight','bold','FontSize',14);
for i=1:total_op_num
    b=chrom_best(i); %b表示该步工序对应第几个工件
    % x1 = pval1{1,i}; % 横坐标开始时间
    % y1 = [machinecode(i),machinecode(i)-0.4,machinecode(i)]; % 开始时间纵坐标
    % 开始时间
    v1 = [pval1{1,i}(1) machinecode(i);pval1{1,i}(2) machinecode(i)-0.4;pval1{1,i}(3) machinecode(i)];
    f1 = [1,2,3];
    patch('Faces',f1,'Vertices',v1,'FaceColor',color(b,:));
    % 结束时间
    v2 = [pval1{2,i}(1) machinecode(i);pval1{2,i}(2) machinecode(i)+0.4;pval1{2,i}(3) machinecode(i)];
    f2 = [1,2,3];
    patch('Faces',f2,'Vertices',v2,'FaceColor',color(b,:));
end 