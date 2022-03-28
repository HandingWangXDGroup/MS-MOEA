% An Adaptive Model Switch-based Surrogate-Assisted Evolutionary Algorithm 
% for Noisy Expensive Multi-Objective Optimization
%------------------------------- Reference --------------------------------
% N. Zheng, H. Wang, and B. Yuan, An Adaptive Model Switch-based 
% Surrogate-Assisted Evolutionary Algorithm for Noisy Expensive 
% Multi-Objective Optimization, Complex & Intelligent Systems, accepted, 2022.
%------------------------------- Copyright --------------------------------
% Copyright (c) 2021 HandingWangXD Group. Permission is granted to copy and
% use this code for research, noncommercial purposes, provided this
% copyright notice is retained and the origin of the code is cited. The
% code is provided "as is" and without any warranties, express or implied.

% This code is written by Zhening Liu.
function obj_nets = construct_rbfn(popdec,popobj,size)
    %%
    center_num = ceil(sqrt(size));   
    %%%����RBFNs&center poings
    RName = 'the_gaussian';
    %%
    obj_nets.centers= get_center(popdec,center_num);          %�õ����ĵ�
    obj_nets.sigma  = max(pdist(obj_nets.centers))*2;
    Z = get_Z(popdec, RName, obj_nets);                        %����Ȩ��
    obj_nets.name   = RName;
    obj_nets.weight = inv(Z'*Z)*Z'*popobj;
    
end