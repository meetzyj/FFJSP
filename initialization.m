function chroms=initialization(num_job,num_machine,num_op,operation_machine,operation_time,total_op_num,operation_long,pop)
    % �������򲿷�,ֻ���������ʼ���ķ���
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
%% ����ѡ�񲿷�(�������ľ���ѡ����ĸ�����)
    % ���ѡ��
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
            m = operation_long{i}(1); % mΪ������
            n = operation_long{i}(2); % nΪm�����ĵ�n��
            machineset = operation_machine{m}{n}; % m����n���Ŀ�ѡ������
            timeset = operation_time{m}{n}(:,3) - operation_time{m}{n}(:,1); % ת���������
            temp = zeros(1,num_machine);
            for j=1:size(machineset,1)
                temp(machineset(j)) = timeset(j);
            end
            temp=temp+machine_time;
            a = temp(machineset);
            [time_min,index] = min(a); % �ò�����ѡ����ǵ�Index������
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
            m = operation_long{i}(1); % mΪ������
            jobdata(i)=m;
            if (i>1) && (jobdata(i)~=jobdata(i-1))
                machine_time = zeros(1,num_machine);
            end 
            n = operation_long{i}(2); % nΪm�����ĵ�n��
            machineset = operation_machine{m}{n}; % m����n���Ŀ�ѡ������
            timeset = operation_time{m}{n}(:,3) - operation_time{m}{n}(:,1); % ת���������
            temp = zeros(1,num_machine);
            for j=1:size(machineset,1)
                temp(machineset(j)) = timeset(j);
            end
            temp=temp+machine_time;
            a = temp(machineset);
            [time_min,index] = min(a); % �ò�����ѡ����ǵ�Index������
            machine_time(index) = a(index)+time_min;
            chrom(i) = machineset(index);
        end 
        ms = [ms;chrom];
    end 
    chroms = [os,ms];
end 
