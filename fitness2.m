function [min_makespan,Z,pvals,machinecode] = fitness2(chroms,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key)
    sizepop = size(chroms,1);
    pvals=cell(1,sizepop);
    Z=cell(1,sizepop); % Z记录的是各个个体的makespan
    for k=1:sizepop
        chrom=chroms(k,:);
        job_op=zeros(1,num_job);    % 记录工件进行到第几步工序
        machine=cell(1,num_machine);   % 记录各机器变化时间
        job=cell(1,num_job);  % 记录各工件变化时间
        for n=1:num_job
            job{n} = [0,0,0];
        end 
        machine_time=cell(1,num_machine);  % 计算各机器的实际加工时间
        for m=1:num_machine
            machine{m} = [0,0,0];
            machine_time{m} = [0,0,0];
        end 
        pval=cell(2,total_op_num);  % 记录各工序开始和结束时间
        machinecode = zeros(1,total_op_num);
        for i=1:total_op_num
            job_op(chrom(i)) = job_op(chrom(i)) + 1;
            m = chrom(key(chrom(i),job_op(chrom(i)))+total_op_num); % m代表选择的机器
            machinecode(i) = m;
            % 机器时间大于工件时间
            if larger(machine{m},job{chrom(i)}) % 分成大于和小于等于两种情况
                pval{1,i}=machine{m};
                machine{m}=machine{m}+time{chrom(i)}{job_op(chrom(i))}{m};
                job{chrom(i)}=machine{m};
                pval{2,i}=machine{m};
            else 
                pval{1,i}=job{chrom(i)};
                job{chrom(i)}=job{chrom(i)}+time{chrom(i)}{job_op(chrom(i))}{m};
                machine{m}=job{chrom(i)};
                pval{2,i}=job{chrom(i)};
            end
            machine_time{m}=machine_time{m}+time{chrom(i)}{job_op(chrom(i))}{m};
        end 
        machine_ = cellfun(@value,machine);
        [~,ind] = max(machine_);
        Z{k} = machine{ind};
        pvals{k}=pval;
    end 
    Z_ = cellfun(@value,Z);
    [~,ind] = min(Z_);
    min_makespan=Z{ind};    
end 