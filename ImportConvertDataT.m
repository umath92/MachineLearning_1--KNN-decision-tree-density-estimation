function [new_train_label,new_train_data,new_test_label,new_test_data,new_valid_label,new_valid_data] = ImportConvertDataT()

train_label=importLabelT('hw1ttt_train.data');
test_label=importLabelT('hw1ttt_test.data');
valid_label=importLabelT('hw1ttt_valid.data');
valid_data=importFeaturesT('hw1ttt_valid.data');
test_data=importFeaturesT('hw1ttt_test.data');
train_data=importFeaturesT('hw1ttt_train.data');

new_train_label = double(categorical(train_label));
new_train_data = dummyvar(categorical(train_data(:,1)));
for i = 2:9
    new_train_data = horzcat(new_train_data, dummyvar(categorical(train_data(:,i))));
end

new_test_label = double(categorical(test_label));
new_test_data = dummyvar(categorical(test_data(:,1)));
for i = 2:9
    new_test_data = horzcat(new_test_data, dummyvar(categorical(test_data(:,i))));
end

new_valid_label = double(categorical(valid_label));
new_valid_data = dummyvar(categorical(valid_data(:,1)));
for i = 2:9
    new_valid_data = horzcat(new_valid_data, dummyvar(categorical(valid_data(:,i))));
end

clearvars i;
end