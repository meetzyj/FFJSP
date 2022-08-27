% ��Ԫ������ѡ��
function chroms_new = select(chroms,Z,SR,total_op_num)
    chromsSize = size(chroms,1);
    Z1 = cellfun(@value,Z);
    poolsize = round(chromsSize*SR); % ����صĴ�С
    chroms_new = zeros(poolsize,total_op_num*2);
    for i=1:poolsize
        index = randperm(chromsSize, 3); % 1*3
        q=[Z1(index(1)),Z1(index(2)),Z1(index(3))];
        [~,ind] = min(q);
        chroms_new(i,:) = chroms(index(ind),:);
        Z1(index(ind)) = [];
        Z(index(ind)) = [];
        chroms(index(ind),:) = [];
        chromsSize = chromsSize - 1;
    end 
end 
