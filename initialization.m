% 随机生成方式产生的pop个种群
function chroms=initialization(num_job,num_op,operation_machine,total_op_num,operation_long,pop)
    % 工序排序部分
    os = [];
    for i=1:num_job
        op = [];
        op(1:num_op(i))=i;
        os = [os,op];
    end 
    temp = os;
    os = repmat(os,pop,1);
    [~,index] = sort(rand(pop,total_op_num),2);
    os = temp(index);
    % 机器选择部分(编码代表的具体选择的哪个机器)
    for j=1:pop
        for i=1:total_op_num
            job = operation_long{i}(1);
            op = operation_long{i}(2);
            machineset = operation_machine{job}{op};
            n = size(machineset,1);
            ms(j,i)=machineset(randperm(n, 1));
        end 
    end
    chroms = [os,ms];
end 
