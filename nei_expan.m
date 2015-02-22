function results_nei = nei_expan(com_one, sim_matrix, lambda_nei)
%% results_nei: 
%% doing the neighborhood expansion
%%   Detailed explanation goes here

v_nei = max((sim_matrix*com_one' - com_one*sim_matrix*com_one'), 0);

s_nei = sum(v_nei);
eta_nei = sum(v_nei.^2);
omega_nei = v_nei' * sim_matrix * v_nei;

b_nei = - (com_one')*s_nei + v_nei;

if lambda_nei*(s_nei^2) + 2*s_nei*eta_nei - omega_nei <= 0
    t_nei = 1/s_nei;
else
    t_nei = min(1/s_nei, eta_nei/(lambda_nei*(s_nei^2) + (2*s_nei*eta_nei) - omega_nei));
end

x_delta = t_nei * b_nei;

results_nei = com_one + x_delta';

end