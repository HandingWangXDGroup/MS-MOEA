function membership = Paretoset(X)
% PARETOSET  To get the Pareto set from a given set of points.�Ӹ�����һ���õ������м���
% synopsis:           membership =paretoset (objectiveMatrix)
% where:
%   objectiveMatrix:Ŀ����� [number of points * number of objectives] array
%   membership:������      [number of points *1] logical vector to indicate if ith
%                    point belongs to the Pareto set (true) or not
%                    (false).���߼�������ʾ�õ��Ƿ�����pareto����
%
% by Yi Cao, Cranfield University, 02 June 2007
% Revised by Yi Cao on 17 October 2007
% Version 3, 21 October 2007, new sorting scheme to improve speed.
% Bugfix, 25 July 2008, devided by zero error is fixed.
%
% Examples: see paretoset_examples
%

m=size(X,1);%��������
Xmin=min(X);%ÿ����Сֵ����Ϊ������
X1=X-Xmin(ones(m,1),:);     %make sure X1>=0;X��ÿ��Ԫ����Xmin��ӦԪ�����
Xmean=mean(X1); %ÿ����ƽ��
%sort X1 so that dominated points can be removed quickly��X1���������Ա���Կ����Ƴ�֧���
[~,checklist]=sort(max(X1./(Xmean(ones(m,1),:)+max(Xmean)),[],2));
Y=X(checklist,:);                  
membership=false(m,1);
while numel(checklist)>1
    k=checklist(1);
    [membership(k),checklist,Y]=paretosub(Y,checklist);
end
membership(checklist)=true;

function [ispareto,nondominated,X]=paretosub(X,checklist)

Z=X-X(ones(size(X,1),1),:);
nondominated=any(Z<0,2);                    %retain nondominated points from the check list                         
ispareto=all(any(Z(nondominated,:)>0,2));   %check if current point belongs to pareto set    
X=X(nondominated,:);
nondominated=checklist(nondominated);
