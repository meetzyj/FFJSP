function chroms=initialization(num_job,num_machine,num_op,operation_machine,operation_time,total_op_num,operation_long,pop)
    % 工序排序部分,只采用随机初始化的方法
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
%% 机器选择部分(编码代表的具体选择的哪个机器)
    % 随机选择
    for j=1:pop*0.6
        for i=1:total_op_num
            job = operation_long{i}(1);
            op = operation_long{i}(2);
            machineset = operation_machine{job}{op};
            n = size(machineset,1);
            ms(j,i)=machineset(randperm(n, 1));
        end 
    end
    % globalselect
    for jj=1:pop*0.2
        machine_time = zeros(1,num_machine);
        chrom = zeros(1,total_op_num);
        for i=1:total_op_num
            m = operation_long{i}(1); % m为工件号
            n = operation_long{i}(2); % n为m工件的第n步
            machineset = operation_machine{m}{n}; % m工件n步的可选机器集
            timeset = operation_time{m}{n}(:,3) - operation_time{m}{n}(:,1); % 转化成了面积
            temp = zeros(1,num_machine);
            for j=1:size(machineset,1)
                temp(machineset(j)) = timeset(j);
            end
            temp=temp+machine_time;
            a = temp(machineset);
            [time_min,index] = min(a); % 该步工序选择的是第Index个机器
            machine_time(index) = a(index)+time_min;
            chrom(i) = machineset(index);
        end 
        ms = [ms;chrom];
    end 
    % localselect
    for jj=1:pop*0.2
        machine_time = zeros(1,num_machine);
        chrom = zeros(1,total_op_num);
        for i=1:total_op_num
            m = operation_long{i}(1); % m为工件号
            jobdata(i)=m;
            if (i>1) && (jobdata(i)~=jobdata(i-1))
                machine_time = zeros(1,num_machine);
            end 
            n = operation_long{i}(2); % n为m工件的第n步
            machineset = operation_machine{m}{n}; % m工件n步的可选机器集
            timeset = operation_time{m}{n}(:,3) - operation_time{m}{n}(:,1); % 转化成了面积
            temp = zeros(1,num_machine);
            for j=1:size(machineset,1)
                temp(machineset(j)) = timeset(j);
            end
            temp=temp+machine_time;
            a = temp(machineset);
            [time_min,index] = min(a); % 该步工序选择的是第Index个机器
            machine_time(index) = a(index)+time_min;
            chrom(i) = machineset(index);
        end 
        ms = [ms;chrom];
    end 
    chroms = [os,ms];
end 
