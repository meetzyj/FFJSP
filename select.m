% 三元锦标赛选择
function chroms_new = select(chroms,Z,SR,total_op_num)
    chromsSize = size(chroms,1);
    poolsize = round(chromsSize*SR); % 交叉池的大小
    chroms_new = zeros(poolsize,total_op_num*2);
    for i=1:poolsize
        index = randperm(chromsSize, 3); % 1*3
        [FrontValue,~] = NonDominateSort(Z);
        q=[FrontValue(index(1)),FrontValue(index(2)),FrontValue(index(3))];
        [~,ind] = min(q);
        chroms_new(i,:) = chroms(index(ind),:);
        Z(index(ind),:) = [];
        chroms(index(ind),:) = [];
        chromsSize = chromsSize - 1;
    end 
end 
