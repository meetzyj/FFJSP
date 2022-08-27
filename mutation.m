function chroms_new = mutation(chroms,total_op_num,MR,operation_long,operation_time,operation_machine,num_machine,num_job,num_op,opmax,key,time)
    popsize = size(chroms,1);
    chroms_new = chroms;
    for i=1:popsize
        if MR>rand
            chrom = chroms(i,:);
            % ��Ի�����ı��죬��ѡ���ɸ�λ�û�Ϊ��ʱ���ٵĻ���
            r = ceil(total_op_num*0.1); % ������Ҫ��ĸ���
            ind = randperm(total_op_num, r);
            for ii=1:r
                job = operation_long{ind(ii)}(1);
                op = operation_long{ind(ii)}(2);
                m = size(operation_time{job}{op},1); % ÿһ��һ������ģ����,m�����ѡ����������
                t = [operation_time{job}{op}(:,1),operation_time{job}{op}(:,2),operation_time{job}{op}(:,2),operation_time{job}{op}(:,3)];
                temp = sum(t,2);
                [~,index] = min(temp);
                temp = [];
                chroms_new(i,ind(ii)+total_op_num) = operation_machine{job}{op}(index);
            end 
            % ��Թ�����ı���
            % s = randperm(3, 1)+1;  % s�ǽ����ĸ���
            temp2 = rand;
            if temp2<0.3
                s = 2;
            elseif temp2<0.85 && temp2>=0.3
                s = 3;
            else 
                s = 4;
            end 
            index = randperm(total_op_num,s);
            ind = perms(index);  % ȫ���о���ÿһ�д���һ��ȫ����
            chrom_neigh = [];
            Z=[];
            ZZ=zeros(1,length(ind)); % �����һ�ֲ���ֵ
            for k=1:length(ind)
                chrom1 = chrom;
                chrom1(index) = chrom(ind(k,:));
                chrom_neigh = [chrom_neigh;chrom1];
            end 
            [~,Z,~] = fitness2(chrom_neigh,num_machine,num_job,num_op,total_op_num,time,operation_long,opmax,key);
            ZZ = cellfun(@value,Z);
            [~,index1] = min(ZZ);
            chroms_new(i,:) = chrom_neigh(index1,:);
        end 
    end 
end 
