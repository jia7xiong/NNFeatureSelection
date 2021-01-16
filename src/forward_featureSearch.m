function  [best_set_of_features,best_accuracy]=forward_featureSearch(F,data,k1,I,k2,algorithm) %Greedy Forward Selection
current_set_of_features = []; %Initialize current set of features with an empty set
best_accuracy=0; %Initialize the best accuracy among all searched levels with 0
best_set_of_features=[]; %Initialize the best set of features among all searched levels with an empty set
for i = 1 : F %search level-by-level of the search tree
    disp(['On the ',num2str(i),'th level of the search tree'])
    feature_to_add_at_this_level = []; %Initialize  feature to add at each level with an empty set
    best_so_far_accuracy  = 0; %Initialize the best so far accuracy of among all searched features within a level with 0
    for j = 1 : F %search nodes one-by-one within the same level
        if isempty(intersect(current_set_of_features,j)) %Only consider adding a feature, if not already added.
            temp_set=current_set_of_features; 
            temp_set(i)=j; %try to add a feature to current set of features
            if algorithm==1||algorithm==4
                accuracy = k_fold_cross_validation(data,temp_set,k1,I,k2); %calculate accuracy of nearest neighbor algorithms if using current set of features
                disp(['--Considering adding the ', num2str(j),' feature, accuracy is ',num2str(accuracy),'%'])
            else
                [accuracy,prune] = xjq_validation(data,temp_set,k1,I,best_so_far_accuracy,k2); %key point: pass in the best_so_far_accuracy
                if prune
                    disp(['--Considering adding the ', num2str(j),' feature, prune it.'])
                else
                    disp(['--Considering adding the ', num2str(j),' feature, accuracy is ',num2str(accuracy),'%.'])
                end
            end
            if accuracy >= best_so_far_accuracy
                best_so_far_accuracy = accuracy; %update the best so far accuracy of among this level
                feature_to_add_at_this_level = j; %the feature with the highest accuracy of among this level
            end
        end
    end
    current_set_of_features(i) =  feature_to_add_at_this_level; %Add a feature
    if best_so_far_accuracy > best_accuracy
        best_accuracy = best_so_far_accuracy; %update the best accuracy among all searched levels
        best_set_of_features=current_set_of_features; % update the best set of features among all searched levels
    else disp('(Warning, Accuracy has decreased! Continuing search in case of local maxima)')
    end
    disp(['On level ', num2str(i),' I added feature ', num2str(feature_to_add_at_this_level), ' to current set '])
end
end
