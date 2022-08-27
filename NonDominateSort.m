function [FrontValue,MaxFront] = NonDominateSort(FunctionValue,Operation)
% ���з�֧������
% ����: FunctionValue, ���������Ⱥ(Ŀ��ռ�)����Ŀ�꺯��,pop*dimesion��ģ������
%       Operation,     ��ָ���������һ����,����ǰһ�����,�����������еĸ���, Ĭ��Ϊ�������еĸ���
% ���: FrontValue, ������ÿ���������ڵ�ǰ������, δ����ĸ���ǰ������Ϊinf
%       MaxFront,   ��������ǰ����
    if Operation == 1
        Kind = 2; 
    else
        Kind = 1;  %��
    end
	[N,M] = size(FunctionValue);
    
    MaxFront = 0;
    cz = zeros(1,N);  %%��¼�����Ƿ��ѱ�������
    FrontValue = zeros(1,N)+inf; %ÿ�������ǰ������
    [FunctionValue,Rank] = sortrows(FunctionValue);
    %sortrows����С�������еķ�ʽ�������򣬷����������ͼ�����������(����ض�����)��ԭʼ�����е�����
    
    %��ʼ�����ж�ÿ�������ǰ����,���øĽ���deductive sort��Deb��֧�������㷨
    while (Kind==1 && sum(cz)<N) || (Kind==2 && sum(cz)<N/2) || (Kind==3 && MaxFront<1)
        MaxFront = MaxFront+1;
        d = cz;
        for i = 1 : N
            if ~d(i)
                for j = i+1 : N
                    if ~d(j)
                        k = 1;
                        for m = 2 : M
                            if FunctionValue(i,m) > FunctionValue(j,m)  %�ȽϺ���ֵ���жϸ����֧���ϵ
                                k = 0;
                                break;
                            end
                        end
                        if k == 1
                            d(j) = 1;
                        end
                    end
                end
                FrontValue(Rank(i)) = MaxFront;
                cz(i) = 1;
            end
        end
    end
end