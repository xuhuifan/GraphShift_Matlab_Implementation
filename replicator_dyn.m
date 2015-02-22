function [results_re, res_lambda, detail_times] = replicator_dyn( initial_one, sim_matrix, row_re)
%% replicator_dyn: initial_one, sim_matrix, row_re
%   Detailed explanation goes here

% newer_one = initial_one;
% final_one = zeros(1, length(newer_one));
%
% while(sum(newer_one - final_one)>0)
%     final_one = newer_one;
%     newer_one = newer_one.*(sim_matrix*(newer_one')/(newer_one*sim_matrix*(newer_one')));
% end

%% revised one

subgraph_space = find(initial_one > 0 );

newer_one = initial_one;
%final_one = zeros(1, length(newer_one));

lambda_rep = newer_one * sim_matrix;
%sub_lambda = lambda_rep(initial_one > 0);

whole_space = 1:1:row_re;
% here to check if it is the mode

%flag_rep = check_equ(sub_lambda);

flag_mode= fuzzy_mode(newer_one, whole_space, subgraph_space, lambda_rep);
%
% for i_rep = 1:length(subgraph_one)              %%problme
%     if (sub_lambda(i_rep)~=sub_lambda(i_rep - 1))
%         flag_rep = 1;
%         break;
%     end
% end
%
%%
%step1
%flag_mode
detail_times = 1;
while(~flag_mode)     %%% this while needs to be changed

    %    for j_dy = 1:1000
    %    final_one = newer_one;
    newer_one(newer_one < 0.0001) = 0;
    
    newer_one = newer_one.*(sim_matrix*(newer_one')/(newer_one*sim_matrix*(newer_one')))';
    
    % j_dy
    % newer_one
    
    % al_re = find(newer_one < 0.001);
    %   al_re
    
    %   newer_one
    
    
    lambda_rep = newer_one * sim_matrix;
    %    sub_lambda = lambda_rep(subgraph_space);
    %  lambda_rep
    
    subgraph_space = find(newer_one > 0);
    flag_mode = fuzzy_mode(newer_one, whole_space, subgraph_space, lambda_rep);
    
    %     flag_mode
    %step_s
    
    %     for i_rep = 1:length(subgraph_one)     %%problme
    %         if (sub_lambda(i_rep)~=sub_lambda(i_rep - 1))
    %             flag_rep = 1;
    %             break;
    %         end
    %     end
    %
    detail_times = detail_times + 1;
end
% end here

%%

results_re = newer_one;
%res_lambda = sub_lambda(1);
w_lam = results_re * sim_matrix;
w_lambda = w_lam(results_re > 0);
res_lambda = w_lambda(1);

clear subgraph_space lambda_rep whole_space flag_mode w_lam;
end

