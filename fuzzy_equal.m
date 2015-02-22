function equ_flag = fuzzy_equal( input_vec, err_tor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

equ_flag = 1;

lower = min(input_vec);
upper = max(input_vec);

if (upper - lower ) > err_tor
    equ_flag = 0;
end

% if len_input >1
%     for i_eq = 1:(len_input - 1)
%         if abs(input_vec(i_eq) - input_vec(i_eq + 1)) > err_tor
%             equ_flag = 0;
%             break;
%         end
%     end
% end
    
end

