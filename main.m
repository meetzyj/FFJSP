clear
clc
close all
% �������ݼ�
load data1 operation_time operation_machine num_machine num_job num_op time operation_long key opmax
%% �Ŵ��㷨������������
MAXGEN = 100;           % ����������
sizepop = 200;          % ��ʼ��Ⱥ����
SR = 0.7;               % ѡ����
CR = 0.3;                % ������
MR = 0.3;                % ������
%% ��Ⱥ��ʼ��
total_op_num=sum(num_op);
chroms = initialization(num_job,num_op,operation_machine,total_op_num,operation_long,sizepop);
[~,~,~,Z,~] = fitness(chroms,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
%% ��ʼ����
for gen=1:MAXGEN
    % ��Ԫ������ѡ��
    chroms_new = select(chroms,Z,SR,total_op_num);
    % �������
    chroms_new = crossover(chroms_new,num_job,total_op_num,CR);
    % �������
    chroms_new = mutation(chroms_new,total_op_num,MR,operation_long,operation_time,operation_machine,num_machine,num_job,num_op,opmax,key,time);
    % ��������ĸ�����Ӧ��
    [~,~,~,Z_new,~] = fitness(chroms_new,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
    % ������Ӧ����ԭ��Ⱥ���Ŵ����������Ⱥ��ѡ��sizepop�����Ÿ���
    [chroms,Z,chrom_best]=update(chroms,chroms_new,Z,Z_new,sizepop);
    % ��¼ÿ��������Ӧ��(ģ��)
    [mean_makespan,Zvalue,min_makespan,~,~] = fitness(chroms,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
    trace(1,gen) = Zvalue;
    trace(2,gen) = mean_makespan;
    gen
end 
%% ============================������=============================
% ����ı仯
figure(1)
plot(trace(1,:));
hold on;
plot(trace(2,:),'-.');grid;
legend('��ı仯','��Ⱥ��ֵ�ı仯');