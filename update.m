function [chroms_u,Z_u] = update(chroms_o,chroms_n,Z_o,Z_n,sizepop)
    ZZ=[Z_o;Z_n];  % 合并后的适应度
    chroms=[chroms_o;chroms_n];  % 合并后的染色体
    [FrontValue,~] = NonDominateSort(ZZ);
    index = find(FrontValue==1);
    rank = 1;
    chroms_u = [];
    Z_u = [];
    while true
        chroms_u = [chroms_u;chroms(index,:)];
        Z_u = [Z_u;ZZ(index,:)];
        rank = rank + 1;
        index = find(FrontValue==rank);
        if size(chroms_u,1)+size(index,2)>=sizepop
            break
        end 
    end 
    if size(chroms_u,1)~=sizepop
        index = find(FrontValue==rank);
        chromo = chroms(index,:);
        Z1 = ZZ(index,:);
        CrowdDis = CrowdingDistance(Z1);
        [~,ind] = sort(CrowdDis,'descend');
        % temp = size(chroms_u,1);
        for j=1:sizepop-size(chroms_u,1)
            chroms_u = [chroms_u;chromo(ind(j),:)];
            Z_u = [Z_u;Z1(ind(j),:)];
        end 
    end 
end 
