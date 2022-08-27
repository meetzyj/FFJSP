function [chroms_u,Z_u,chrom_best] = update(chroms_o,chroms_n,Z_o,Z_n,sizepop)
    ZZ=[Z_o,Z_n];  % 合并后的适应度(模糊数)
    chroms=[chroms_o;chroms_n];  % 合并后的染色体
    len=length(chroms);
    Zvalue = cellfun(@value,ZZ);
    [~,ind] = sort(Zvalue);
    chroms_u=chroms(ind(1:sizepop),:);  % 选出前sizepop个个体(更新种群)
    Z_u=ZZ(ind(1:sizepop));
    chrom_best=chroms_u(1,:);  % 最优染色体
end 
