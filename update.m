function [chroms_u,Z_u,chrom_best] = update(chroms_o,chroms_n,Z_o,Z_n,sizepop)
    ZZ=[Z_o,Z_n];  % �ϲ������Ӧ��(ģ����)
    chroms=[chroms_o;chroms_n];  % �ϲ����Ⱦɫ��
    len=length(chroms);
    Zvalue = cellfun(@value,ZZ);
    [~,ind] = sort(Zvalue);
    chroms_u=chroms(ind(1:sizepop),:);  % ѡ��ǰsizepop������(������Ⱥ)
    Z_u=ZZ(ind(1:sizepop));
    chrom_best=chroms_u(1,:);  % ����Ⱦɫ��
end 
