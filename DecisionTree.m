function [ acc ] = DecisionTree( train_data, train_label, test_data, test_label)

x = [categorical(train_data(:,1)) categorical(train_data(:,2)) categorical(train_data(:,3)) ...
    categorical(train_data(:,4)) categorical(train_data(:,5)) categorical(train_data(:,6)) categorical(train_data(:,7)) categorical(train_data(:,8)) categorical(train_data(:,9))];
x = double(x);

y = [categorical(test_data(:,1)) categorical(test_data(:,2)) categorical(test_data(:,3)) ...
    categorical(test_data(:,4)) categorical(test_data(:,5)) categorical(test_data(:,6)) categorical(test_data(:,7)) categorical(test_data(:,8)) categorical(test_data(:,9))];
y = double(y);

option = 'gdi';
acc=zeros(20,1);
for i = 1:20
    tree = ClassificationTree.fit(x,categorical(train_label),'CategoricalPredictors','all', 'SplitCriterion',option,'Prune','off','MinLeaf', i);
    data_label = predict(tree,y);
    data_label = cellstr(data_label);
    acc(i)=getAccuracy(data_label,test_label);
    if i == 10
        option = 'deviance';
    end
end
end






function accuracy = getAccuracy(resultClass, newLabel)
sum = 0;
for index = 1:length(resultClass)
    if (strcmp(resultClass{index},newLabel{index}))
        sum = sum+1;
    end
end
accuracy = sum/length(resultClass);
end