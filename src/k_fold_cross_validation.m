function accuracy= k_fold_cross_validation(data,current_set,k1,I,k2) %Evaluation Function
current_data(:,1)=data(:,1); %copy the first column of the orignial where class labels are to a new dataset
for i=1:size(current_set,2)
    current_data(:,i+1)=data(:,current_set(i)+1); %copy the columns where the current set of features are to consturct the new dataset
end
accuracy=0; %Initialize the accuracy with 0
for j = 1 : k1 %tested classifier k1 times
    test_data(1:I/k1,:)=current_data((j-1)*I/k1+1:j*I/k1,:); %divide the dataset into k1 equal sized sections
    training_data=current_data;
    training_data((j-1)*I/k1+1:j*I/k1,:)=[]; %each time leave out one of the k1 section from building the classifier
    for m=1:I/k1 %m is the number of instainces in one section
        if test_data(m,1)==(k_nearest_neighbor_classifier(test_data(m,:),training_data,I,k1,k2)) % using that section to test the classifier
            accuracy =accuracy +100/I; %Number of correct classifications/Number of instances in our database 
        end
    end
end
end