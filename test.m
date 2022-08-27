load color
[~,Z,pvals,machinecode] = fitness2(chrom_best,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
pval1 = pvals{1,1};
figure(2);
% set(gca, 'position', [0.03,0.10,0.95,0.85]);
xlabel('Time','FontWeight','bold','FontSize',14);
ylabel('Machine','FontWeight','bold','FontSize',14);
for i=1:total_op_num
    b=chrom_best(i); %b��ʾ�ò������Ӧ�ڼ�������
    % x1 = pval1{1,i}; % �����꿪ʼʱ��
    % y1 = [machinecode(i),machinecode(i)-0.4,machinecode(i)]; % ��ʼʱ��������
    % ��ʼʱ��
    v1 = [pval1{1,i}(1) machinecode(i);pval1{1,i}(2) machinecode(i)-0.4;pval1{1,i}(3) machinecode(i)];
    f1 = [1,2,3];
    patch('Faces',f1,'Vertices',v1,'FaceColor',color(b,:));
    % ����ʱ��
    v2 = [pval1{2,i}(1) machinecode(i);pval1{2,i}(2) machinecode(i)+0.4;pval1{2,i}(3) machinecode(i)];
    f2 = [1,2,3];
    patch('Faces',f2,'Vertices',v2,'FaceColor',color(b,:));
end 