function chroms_child = crossover(chroms,num_job,total_op_num,CR)
    popsize = size(chroms,1);
    chroms_child = chroms;
    for i=1:2:popsize-1
        if CR>rand 
            % 父代染色体
            parent1 = chroms(i,:);
            parent2 = chroms(i+1,:);
            % 针对工序部分的pox交叉
            num_JOB1 = fix(rand*num_job);
            num_JOB2 = num_job - num_JOB1;
            JOB = randperm(num_job);
            JOB1 = randperm(num_job, num_JOB1);
            JOB2 = setdiff(JOB, JOB1);
            parent1_op = parent1(1:total_op_num);
            parent2_op = parent2(1:total_op_num);
            index1 = ismember(parent1_op, JOB1);
            index2 = ismember(parent2_op, JOB1);
            child1_op(index1) = parent1_op(index1);
            child1_op(~index1) = parent2_op(~index2);
            index1 = ismember(parent2_op, JOB2);
            index2 = ismember(parent1_op, JOB2);
            child2_op(index1) = parent2_op(index1);
            child2_op(~index1) = parent1_op(~index2);
            chroms_child(i,1:total_op_num) = child1_op;
            chroms_child(i+1,1:total_op_num) = child2_op;
            % 针对机器码部分的交叉
            r = randperm(total_op_num, floor(rand*total_op_num)) + total_op_num; 
            chroms_child(i,r) = parent2(r);
            chroms_child(i+1,r) = parent1(r);
        end 
    end
end