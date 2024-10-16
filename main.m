clear
clc
close all
% 加载数据集
load data1 operation_time operation_machine num_machine num_job num_op time operation_long key opmax
%% 遗传算法基本参数设置
MAXGEN = 200;           % 最大迭代次数
sizepop = 200;          % 初始种群个数
SR = 0.7;               % 选择率
CR = 0.7;                % 交叉率
MR = 0.3;                % 变异率
%% 种群初始化
total_op_num=sum(num_op);
chroms = initialization(num_job,num_machine,num_op,operation_machine,operation_time,total_op_num,operation_long,sizepop);
[Z,~,~] = fitness(chroms,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
%% 开始迭代
for gen=1:MAXGEN
    % 三元锦标赛选择
    chroms_new = select(chroms,Z,SR,total_op_num);
    % 交叉操作
    chroms_new = crossover(chroms_new,num_job,total_op_num,CR);
    % 变异操作
    chroms_new = mutation(chroms_new,total_op_num,MR,operation_long,operation_time,operation_machine,num_machine,num_job,num_op,opmax,key,time);
    % 交叉变异后的个体适应度
    [Z_new,~,~] = fitness(chroms_new,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
    % 根据适应度在原种群和遗传操作后的种群中选出sizepop个更优个体
    [chroms,Z]=update(chroms,chroms_new,Z,Z_new,sizepop);
    gen
    [FrontValue,~] = NonDominateSort(Z);
    index = find(FrontValue==1);
    trace{gen} = Z(index,:);
end 