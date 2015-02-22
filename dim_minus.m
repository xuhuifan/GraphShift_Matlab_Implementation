function out_space = dim_minus( orin_space, minus_space )
%dim_minus: get the result space by ori_space\minus_space
%   Detailed explanation goes here
%%
out_space = orin_space;
for i_dim = 1:length(minus_space)
    out_space = out_space(out_space~=minus_space(i_dim));
end

end