function euclidean_distance=distance_measurement(instance1,instance2) %%calculate euclidean distance between two instances
euclidean_distance=0;
for i=1:size(instance1,2)-1
    euclidean_distance=(instance1(i+1)-instance2(i+1))^2+euclidean_distance;
end
end