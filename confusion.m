function output = confusion(expected_array,predicted_array)

% Inputs
% expected_array: n x 8 array containing "ground truth" labels for each
% behavior, labeled by a human
% predicted array: n x 8 array predicted by DEG (via the "export prediction
% to CSV" button in the GUI

% Outputs
% 1) A graph showing the confusion matrices for each of the 8 behaviors
% 2) The F1 score for each of the 8 behaviors.

% Preallocate arrays
tp_all = ones(1,size(expected_array,2));
tn_all = ones(1,size(expected_array,2));
fp_all = ones(1,size(expected_array,2));
fn_all = ones(1,size(expected_array,2));
f1_all = ones(1,size(expected_array,2));

% Loop
for i = 1:size(expected_array,2)
    expected = expected_array(:,i);
    predicted = predicted_array(:,i);

    idx = (expected()==1); % Looks for the locations in the expected array that equal 1
    p = length( expected(idx)); % Number of positives in expected array
    n = length( expected(~idx)) ; % Number of negatives in expected array
    % N = p+n;
    tp = sum( expected(idx)== predicted(idx)); % True positives
    tn = sum( expected(~idx)== predicted(~idx)); % True negatives
    fp = n-tn; % False positives
    fn = p-tp; % False negatives
    f1=((2*tp)/(2*tp + fp + fn))*100; % F1 score

    tp_all(i) = tp; % Put all true positives into array...
    tn_all(i) = tn; % Put all true negatives into array...
    fp_all(i) = fp; % Put all false positives into array...
    fn_all(i) = fn; % Put all false negatives into array...
    f1_all(i) = f1; % Put all F1 scores into array...

end

% Create confusion matrix plot

figure;

for i = 1:size(expected_array,2)
    
    tp = tp_all(i);
    tn = tn_all(i);
    fp = fp_all(i);
    fn = fn_all(i);
     
    subplot(1,size(expected_array,2),i)

    heatmap({'Positive','Negative'},{'Positive','Negative'},[(tp/(tp+fn)) (fn/(tp+fn)); (fp/(fp+tn)) (tn/(fp+tn))],'ColorbarVisible','off','ColorLimits',[0 1]);

end

set(gcf,'Units','inches','Position',[1 1 22 2],'Color','w');

% Output F1 scores

output = f1_all;