function [min_makespan,Z,pvals,machinecode] = fitness2(chroms,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key)
    sizepop = size(chroms,1);
    pvals=cell(1,sizepop);
    Z=cell(1,sizepop); % Z��¼���Ǹ��������makespan
    for k=1:sizepop
        chrom=chroms(k,:);
        job_op=zeros(1,num_job);    % ��¼�������е��ڼ�������
        machine=cell(1,num_machine);   % ��¼�������仯ʱ��
        job=cell(1,num_job);  % ��¼�������仯ʱ��
        for n=1:num_job
            job{n} = [0,0,0];
        end 
        machine_time=cell(1,num_machine);  % �����������ʵ�ʼӹ�ʱ��
        for m=1:num_machine
            machine{m} = [0,0,0];
            machine_time{m} = [0,0,0];
        end 
        pval=cell(2,total_op_num);  % ��¼������ʼ�ͽ���ʱ��
        machinecode = zeros(1,total_op_num);
        for i=1:total_op_num
            job_op(chrom(i)) = job_op(chrom(i)) + 1;
            m = chrom(key(chrom(i),job_op(chrom(i)))+total_op_num); % m����ѡ��Ļ���
            machinecode(i) = m;
            % ����ʱ����ڹ���ʱ��
            if larger(machine{m},job{chrom(i)}) % �ֳɴ��ں�С�ڵ����������
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