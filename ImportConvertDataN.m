function [new_train_label,new_train_data,new_test_label,new_test_data,new_valid_label,new_valid_data] = ImportConvertDataN()
train_label=importLabelN('hw1nursery_train.data');
test_label=importLabelN('hw1nursery_test.data');
valid_label=importLabelN('hw1nursery_valid.data');
valid_data=importFeaturesN('hw1nursery_valid.data');
test_data=importFeaturesN('hw1nursery_test.data');
train_data=importFeaturesN('hw1nursery_train.data');

new_train_label = double(categorical(train_label));
new_train_data = dummyvar(categorical(train_data(:,1)));
for i = 2:8
    new_train_data = horzcat(new_train_data, dummyvar(categorical(train_data(:,i))));
end

new_test_label = double(categorical(test_label));
new_test_data = dummyvar(categorical(test_data(:,1)));
for i = 2:8
    new_test_data = horzcat(new_test_data, dummyvar(categorical(test_data(:,i))));
end

new_valid_label = double(categorical(valid_label));
new_valid_data = dummyvar(categorical(valid_data(:,1)));
for i = 2:8
    new_valid_data = horzcat(new_valid_data, dummyvar(categorical(valid_data(:,i))));
end

clearvars i;
end