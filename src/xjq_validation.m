function [accuracy,prune]= xjq_validation(data,current_set,k1,I,best_so_far_accuracy,k2) %almost the same as the k fold cross validation but just prune a node if we know it is bad without calculating how bad it is
current_data(:,1)=data(:,1);
for i=1:size(current_set,2)
    current_data(:,i+1)=data(:,current_set(i)+1);
end
error=0; %Initialize the error rate with 0
for j = 1 : k1
    prune=0; %indicate whether a node should be pruned
    test_data(1:I/k1,:)=current_data((j-1)*I/k1+1:j*I/k1,:);
    training_data=current_data;
    training_data((j-1)*I/k1+1:j*I/k1,:)=[];
    for m=1:I/k1
        if test_data(m,1)~=(k_nearest_neighbor_classifier(test_data(m,:),training_data,I,k1,k2))
            error =error +100/I; %Keep track of how many mistakes I have made so far
        end
        if error>(100-best_so_far_accuracy) %If I have made too many mistakes thus definitely worse than the best so far, break out of loops, and report accuracy to be 0.
            prune=1;
            break;
        end
    end
    if prune
        accuracy=0;
        break;
    end
end
if ~prune
    accuracy=100-error;
end
end