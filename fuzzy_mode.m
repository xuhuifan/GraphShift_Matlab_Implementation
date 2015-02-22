function flag_mode = fuzzy_mode( input_one, whole_space, sub_space, whole_lambda)

%% check_mode: to check if input_one is the mode in the sub_space of the
%% graph   under the fuzzy framework, especially in error torrent
%                               whole_lambda are necessary ones to
%                               determine

%%
% new_sub = find(input_one>0);
% sup_one = space_one(new_sub);
sup_space = whole_space(input_one > 0);
%step_stage = 0;
%sup_space
%input_one
sup_lambda = whole_lambda(sup_space);
% need one sub_space definition
del_f = 0.0001;                                    %%%%%%%%%%%%%%%% here to define the error
flag_out1 = fuzzy_equal(sup_lambda, del_f);    %%%%%%%%%%%%%%%%%%%%here
%flag_out1

if (~flag_out1)
    flag_mode = 0;
    %   step_stage = 1;
else
    sta_lambda = sup_lambda(1);
    
    %     non_sup_one = space_one(input_one == 0);       % define the non_sup_space: sub_space\sup_space
    non_sup_space = dim_minus(sub_space, sup_space);
    non_sup_len = length(non_sup_space);
    
    if (non_sup_len == 0)
        flag_mode = 1;
        %      step_stage = 2;
    else
        non_sup_lambda = whole_lambda(non_sup_space);
        
        flag_mode = 1;
        %     step_stage = 3;
        
        for i_che = 1:non_sup_len
            if(non_sup_lambda(i_che) > sta_lambda)
                flag_mode = 0;
                %            step_stage = 4;
                break;
            end
            
        end
        
    end
    
end


end