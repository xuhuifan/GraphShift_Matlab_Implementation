function [results, iteration_times, detail_times] = true_test(sim_mat)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


row_re = size(sim_mat, 1);


%sim_mat_1 = Con_dist_mat(breast_1, row_re, col_re);

initial_start = diag(ones(1, row_re));
% itera_times = 100;
% results = zeros(itera_times, row_re);
iteration_times = zeros(row_re, 1);
detail_times = zeros(row_re, row_re);
results = zeros(size(sim_mat));
for i_tot = 1:row_re                                        %%%%%%%%%% here changes
    %  i_tot = 1;                                                           %%%%%%%%%% here changes
       new_one = initial_start(i_tot,:);
     %%%%%%%%%%new_one = rand(1, row_re);
     %%%%%%%%%%new_one = new_one/sum(new_one);
    whole_space = 1:1:row_re;
    whole_lambda = new_one * sim_mat;
    %    sub_space = i_tot;
    flag_mode = fuzzy_mode(new_one, whole_space, whole_space, whole_lambda);    %%% here defines whole_space
    
    ite_times = 0;
    while(~flag_mode)                      %% if possible, use check_mode function     %% check if new_one is the mode of graph G
        %%%%%%%% here
        %%%%%%%% chang
        %%%%%%%% es
%         fprintf('here\n');
        %     results = new_one;
        %       row_re
        ite_times = ite_times + 1;
        [new_one, lambda_gr, de_times] = replicator_dyn(new_one, sim_mat, row_re);
        detail_times(i_tot, ite_times) = de_times;
%         fprintf('here again\n');
        
        %     new_one
        
        whole_lambda = new_one * sim_mat;
        %        sub_space = find(new_one>0);
        flag_mode = fuzzy_mode(new_one, whole_space, whole_space, whole_lambda);   %%% here defines whole_space
        
        if (~flag_mode)                      %% if  possible,  use check_mode function    %% check if repli_one is the mode of graph G
          %  lams = (new_one*sim_mat*new_one');
            %        lams
            %       lambda_gr
            new_one = nei_expan(new_one, sim_mat, lambda_gr);
            
            whole_lambda = new_one * sim_mat;
            %            su_space_i = fine(new_one>0);
            flag_mode = fuzzy_mode(new_one, whole_space, whole_space, whole_lambda);     %%%here defines whole_space
            
        end
        
        %        results = new_one;
        
        %  flag_mode
        
        % ite_times
      %  ite_times = ite_times + 1;
    end
    results(i_tot,:) = new_one;
    
    if mod(i_tot, 100) == 0
        fprintf('Iteration has procedded to %d -th time\n', i_tot);
    end
    %new_one
    
    iteration_times(i_tot) = ite_times;
    %    i_tot
end


end