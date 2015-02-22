% Test 14_Nov_2014
clear;
clc;
iteTime = 1;
    delta_val = [0.1 0.3 0.5 0.7 0.9];
perf_se = zeros(numel(delta_val), 2, iteTime);
runtimes = zeros(numel(delta_val), iteTime);
itereal_time = zeros(numel(delta_val), iteTime);
itewhole_time = zeros(numel(delta_val), iteTime);
for kk = 1:size(perf_se, 3)
    dataNum = 20;
    var_sca = 0.1;
    centers = [-1, -1;1, -1; -1, 1; 1, 1];
    datas = [];
    for ii = 1:size(centers, 1)
        clu1 = randn(2, dataNum);
        cov1 = [var_sca, 0;0, var_sca];
        datas = [datas; bsxfun(@plus, cov1*clu1, centers(ii, :)')'];
    end
    
    noisies = 4*(rand(2, dataNum)-0.5);
    datas = [datas; noisies'];
    
    true_labels = (size(centers, 1)+1)*ones(1, (size(centers, 1)+1)*dataNum);
    for k = 1:size(centers, 1)
        kindex = sqrt(sum(bsxfun(@minus, datas, centers(k, :)).^2, 2))<0.5;
        true_labels(kindex) = k;
    end
    
%     figure(1);
%     for ii = 1:(size(centers, 1)+1)
%         plot(datas(true_labels==ii, 1), datas(true_labels==ii, 2), '.');
%         hold all;
%     end
%     hold off;
    
    
    a = squareform(pdist(datas)).^2;
    
    for i_delta = 1:numel(delta_val)
        data_file = exp(-a/delta_val(i_delta));
        % % % % %     [v, d] = eig(data_file);
        % % % % %
        % % % % %     b = diag(d);
        % % % % %     b = sort(b, 'descend');
        % % % % %     b(1:10)
        
        dataNum = size(data_file, 1);
        diag_index = (1:dataNum)+(dataNum*(0:(dataNum-1)));
        data_file(diag_index) = 0;
        
        tic;
        [result_test, whole_itera, detail_times] = true_test(data_file);
%         toc;
% save 4_clusters_matlab.mat result_test;
        
        runtimes(i_delta, kk) = toc;
        
        perform_score = perform_cal(result_test, true_labels);
        perf_se(i_delta, :, kk) = perform_score;

    
    % determine the calculation time
    te_row = size(detail_times, 1);
    whole_ti = sum(whole_itera)-te_row;
    real_time = zeros(whole_ti, 1);
    curr_no = 1;
    for i_te = 1:dataNum
        real_time(curr_no:(curr_no + whole_itera(i_te)-2))=detail_times(i_te, 2:whole_itera(i_te));
        curr_no = curr_no + whole_itera(i_te) - 1;
    end
    itereal_time(i_delta, kk) = mean(real_time);
    whole_itera = whole_itera(whole_itera~=0);
    itewhole_time(i_delta, kk) = mean(whole_itera);
    end
end

% 
% save 2_cluster.mat perf_se runtimes itereal_time itewhole_time ;
