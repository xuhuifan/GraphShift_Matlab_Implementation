function perform_score = perform_cal(result_test, true_labels)

% calculate the performance score of the partition models, including
% precision and NMI
% created by 15-Nov-2014

% result_test: the partition result, i-th row represent the converged mode
% of i-th vertice

vNum = size(result_test, 1);
labels = zeros(1, vNum);
cores = zeros(size(result_test));
cores(1, :) = result_test(1, :);
coreNum = 1;
labels(1) = 1;

for ii = 2:vNum
    newCore_flag = 1;
    for jj = 1:coreNum
        if sum(abs(result_test(ii, :)-cores(jj, :))) < 0.05
            newCore_flag = 0;
            labels(ii) = jj;
        end
    end
    
    if (newCore_flag == 1)
        coreNum = coreNum + 1;
        cores(coreNum, :) = result_test(ii, :);
        labels(ii) = coreNum;
    end
end

% figure(2);
% for ii = 1:numel(unique(labels))
%     ii_data = datas(labels==ii, :);
%     plot(ii_data(:, 1), ii_data(:, 2), '.');
%     hold all;
% end
% hold off;


% calculate accuracy first
nums = 0;
for ii = 1:((vNum)-1)
    for jj = (ii+1):(vNum)
        if ((true_labels(ii)==true_labels(jj))&&(labels(ii) == labels(jj)))||(true_labels(ii)~=true_labels(jj))&&(labels(ii)~= labels(jj))
            nums = nums + 1;
        end
    end
end
perform_score = zeros(1, 2);
perform_score(1) = nums/(vNum*(vNum-1)/2);

% calculate the NMI score
perform_score(2) = nmi(true_labels, labels);

end

