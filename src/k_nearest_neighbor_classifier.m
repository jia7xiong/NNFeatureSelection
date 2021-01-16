function nn_label=k_nearest_neighbor_classifier(instance,training_data,I,k1,k2) %train a nearest neighbor classifier and classify a instance
for m=1:I-I/k1
    euclidean_distance(m)=distance_measurement(instance,training_data(m,:)); %calculate the distance between the unseen instance and its neighbor
end
ed=euclidean_distance;
vote=0;
label=2;
for i=1:k2 %find the nearest k2 neighbors of the unseen instance, and let them vote
    if training_data(euclidean_distance==min(ed),1)==1
        vote=vote+1;
        if vote>k2/2 
            label=1;
            break
        end
    end
    ed(ed==min(ed))=[];
end
nn_label=label;
end