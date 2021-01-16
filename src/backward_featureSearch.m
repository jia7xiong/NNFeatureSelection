function backward_featureSearch(F,data,k1,I,k2,best_accuracy) %Greedy Backward Elimination
current_set_of_features = 1:F; %Initialize current set of features with all features
best_set_of_features=current_set_of_features;
for i = 1 : F-1
    disp(['On the ',num2str(F-i),' level of the search tree'])
    feature_to_remove_at_this_level = []; %%Initialize  feature to remove at each level with an empty set
    best_so_far_accuracy  = 0;
    for j = 1 : F
        if ~isempty(intersect(current_set_of_features,j)) %Only consider removing, if not already removed.
            temp_set=current_set_of_features;
            location=temp_set==j; %find the index of the feature I try to remove
            temp_set(location)=[]; %try to remove that feature
            accuracy = k_fold_cross_validation(data,temp_set,k1,I,k2);
            disp(['--Considering removing the ', num2str(j),' feature, accuracy is ',num2str(accuracy),'%'])
            if accuracy >= best_so_far_accuracy
                best_so_far_accuracy = accuracy;
                feature_to_remove_at_this_level = j;
            end
        end
    end
    location=current_set_of_features==feature_to_remove_at_this_level; %find index of the feature with the highest accuracy
    current_set_of_features(location)=[]; %remove that feature
    if best_so_far_accuracy >= best_accuracy
        best_accuracy = best_so_far_accuracy;
        best_set_of_features=current_set_of_features;
    else
        disp('(Warning, Accuracy has decreased! Continuing search in case of local maxima)')
    end
    disp(['On level ', num2str(F-i),' I removed feature ', num2str(feature_to_remove_at_this_level), ' from current set '])
end
disp(['Finished Backward search!! The best feature subset is { ',num2str(best_set_of_features),' } which has an accuracy of ',num2str(best_accuracy),'%'])
end
