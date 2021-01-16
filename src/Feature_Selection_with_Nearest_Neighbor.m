clear
close all

disp('Welcome to Jiaqi Xiong''s Feature Selection Algorithm.')

txt = input('Type in the name of the file to test: ','s');
% txt='LARGEtestdata__12.txt';
try
    data=load(txt); %read dataset into my program
catch
    error('Invalid input, please check and restart.');
end

% strong_feature=[1+46];
% data(:,[8 2])=[]; %strong_feature(s) you want to delete temporarily to find the weak feature

disp('Type the index of the algorithm you want to run:')
disp('1)	Forward Selection')
disp('2)	Backward Elimination ')
disp('3)	Jiaqi¡''s Faster Algorithm.')
disp('4)	Jiaqi¡''s Better Algorithm.')
algorithm = input('5)	Jiaqi¡''s Special Algorithm.\n');

if algorithm~=1&&algorithm~=2&&algorithm~=3&&algorithm~=4&&algorithm~=5
    error('Invalid input, please check and restart. (Index from 1 to 5)');
end

I=size(data,1); %the number of instances in the dataset
F=size(data,2)-1;%%the number of features in the dataset
disp(['This dataset has ',num2str(F),' features (not including the class attribute), with ',num2str(I),' instances.'])

if algorithm~=4
    k1 = input('Type integer k1, the number of equal sized sections into which you want to divide the dataset for k fold cross validation:');
    if mod(I,k1)~=0||k1<=0||k1~=round(k1)
        error(['Invalid input, please check and restart. (k1 should be a positive integer and make sure ',num2str(I),' is divisible by k1)']);
    end
else
    k1=I;
end

k2 = input('Type odd k2, the number of neigbors who should vote for the class of unseen instance: ');
if mod(k2,2)==0||k2<0||k2~=round(k2)
    error('Invalid input, please check and restart. (k2 should be a positive odd integer)');
end

accuracy=k_fold_cross_validation(data,1:F,k1,I,k2); %accuracy when using nearest neighbor with all features
disp(['Running',num2str(k2) ,'nearest neighbor with all ',num2str(F),' features, using ',num2str(k1),' fold cross validation, I get an accuracy of ',num2str(accuracy),'%'])

if algorithm==1
    tic; %record the initial time
    disp('Beginning Forward search.')
    [best_set_of_features,best_accuracy]=forward_featureSearch(F,data,k1,I,k2,algorithm);
    disp(['Finished Forward search!! The best feature subset is { ',num2str(best_set_of_features),' } which has an accuracy of ',num2str(best_accuracy),'%'])
    disp(['running time = ',num2str(toc)]);

elseif algorithm==2
    disp('Beginning Backward search.')
    backward_featureSearch(F,data,k1,I,k2,accuracy);

else
    if algorithm==3
        tic;
        disp('Beginning Jiaqi¡''s Faster search for the original data')
        [best_set_of_features,best_accuracy]=forward_featureSearch(F,data,k1,I,k2,algorithm); 
        disp(['Finished Jiaqi¡''s Faster search!! The best feature subset is { ',num2str(best_set_of_features),' } which has an accuracy of ',num2str(best_accuracy),'%'])
        disp(['running time = ',num2str(toc)]);
    end
    
    if algorithm~=3
        v = input('Type the number of versions you want to make: ');
        if v~=round(v)||v<=0
            error('Invalid input, please check and restart. (The number of versions should be a positive integer)');
        end
        delete_rate = input('Type the rate of instances you want to delete to make a new version: ');
        if delete_rate>=1||I*delete_rate~=round(I*delete_rate)||delete_rate<=0
            error(['Invalid input, please check and restart. (rate from 0 to 1 excluded, and rate * ',num2str(I),' should be an integer)']);
        end
        best_set_of_features=cell(v+1,1);
        
        if algorithm==4
            disp('Beginning Jiaqi¡''s Better search for the original data')
            [best_set_of_features{v+1},best_accuracy(v+1)]=forward_featureSearch(F,data,k1,I,k2,algorithm); %Jiaqi¡'s Faster Search with originial dataset
        end
        for i=1:v %make three different versions of the dataset to eliminate spurious features as well as find weak features 
            delete_instances = randperm(I,delete_rate*I); %randomly select 10 instances which will be deleted
            version=data; %make a copy of the dataset
            version(delete_instances,:)=[]; %in each copy randomly delete those 10 instances
            if algorithm==4
                disp(['Beginning Jiaqi¡''s Better search for copy ',num2str(i)])
                [best_set_of_features{i},best_accuracy(i)]=forward_featureSearch(F,version,size(version,1),size(version,1),k2,algorithm); %Jiaqi¡'s Better Search with the dataset after resampling
            else
                disp(['Beginning Jiaqi¡''s Special search for copy ',num2str(i)])
                [best_set_of_features{i},best_accuracy(i)]=forward_featureSearch(F,version,size(version,1),size(version,1),k2,algorithm); %Jiaqi¡'s Special Search with the dataset after resampling
            end
        end
        
        if algorithm==5
            disp('Beginning Jiaqi¡''s Special search for the original data')
            [best_set_of_features{v+1},best_accuracy(v+1)]=forward_featureSearch(F,data,k1,I,k2,algorithm);
            disp(['Finished Jiaqi¡''s Special search!! The best feature subset is { ',num2str(best_set_of_features{v+1}),' } which has an accuracy of ',num2str(best_accuracy(v+1)),'%'])
        else
            disp(['Finished Jiaqi¡''s Better search!! The best feature subset is { ',num2str(best_set_of_features{v+1}),' } which has an accuracy of ',num2str(best_accuracy(v+1)),'%'])
        end
        for i=1:v
            if algorithm==5
                disp(['Finished Jiaqi¡''s Special search for version ',num2str(i),'!! The best feature subset is { ',num2str(best_set_of_features{i}),' } which has an accuracy of ',num2str(best_accuracy(i)),'%'])
            else
                disp(['Finished Jiaqi¡''s Better search for version ',num2str(i),'!! The best feature subset is { ',num2str(best_set_of_features{i}),' } which has an accuracy of ',num2str(best_accuracy(i)),'%'])
            end
        end
    end
end

%  c=data(:,1);
%  sz = 25;
%  scatter(data(:,feature1),data(:,feature),sz,c,'filled','LineWidth',1.5) %plot two features
