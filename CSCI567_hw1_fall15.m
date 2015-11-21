function [] = CSCI567_hw1_fall15()
Q51();
Q52NB();
Q52KNN();
Q52DB();
Q52e();
end

function [] = Q51()
Density();
end

function [] = Q52NB()

fprintf(sprintf( '\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%Naive Bayes%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n' ));
%Imoprt and run data for TicTacToe%%%%%%%%%%%%%%%%%%%%%%%%
clear y Fs
[new_train_label,new_train_data,new_test_label,new_test_data,new_valid_label,new_valid_data]=ImportConvertDataT();
[new_acc,train_acc]=naive_bayes(new_train_data,new_train_label,new_valid_data,new_valid_label);

%TicTacToe
disp(sprintf( 'Validation Acc for TicTacToe = %.3f\n', new_acc ));
disp(sprintf( 'Training Acc for TicTacToe = %.3f\n', train_acc ));


[new_acc,~]=naive_bayes(new_train_data,new_train_label,new_test_data,new_test_label);

%TicTacToe
disp(sprintf( 'Tesing Acc for TicTacToe = %.3f\n', new_acc ));

%Import and run data for Nursery dataset%%%%%%%%%%%%%%%%%%%%%%

clear y Fs
[new_train_label,new_train_data,new_test_label,new_test_data,new_valid_label,new_valid_data]=ImportConvertDataN();
[new_acc,train_acc]=naive_bayes(new_train_data,new_train_label,new_valid_data,new_valid_label);


disp(sprintf( 'Validation Acc for Nursery = %.3f\n', new_acc ));
disp(sprintf( 'Training Acc for Nursery = %.3f\n', train_acc ));


[new_acc,~]=naive_bayes(new_train_data,new_train_label,new_test_data,new_test_label);


disp(sprintf( 'Tesing Acc for Nursery = %.3f\n', new_acc ));




end

function [] = Q52KNN()

%Imoprt and run data for TicTacToe%%%%%%%%%%%%%%%%%%%%%%%%
clear y Fs
[new_train_label,new_train_data,new_test_label,new_test_data,new_valid_label,new_valid_data]=ImportConvertDataT();

fprintf(sprintf( '\n%%%%%%%%%%%%%%%%%%%%%%%%%%%% KNN %%%%%%%%%%%%%%%%%%%%%%%%%%%%\n' ));
fprintf(sprintf( 'Displaying training, validation and set accuracy for K = 1,3,5...15\n' ));
i=1;
while(i<=15)
    [v_accu, train_accu] = knn_classify(zscore(new_train_data), new_train_label, zscore(new_valid_data), new_valid_label, i);
    [tr_accu, ~] = knn_classify(zscore(new_train_data), new_train_label, zscore(new_test_data), new_test_label, i);
    
    fprintf(sprintf( 'Training Acc K = %d, -> %.3f\n', i , train_accu ));
    fprintf(sprintf( 'Validation Acc K = %d, -> %.3f\n', i , v_accu ));
    fprintf(sprintf( 'Testing Acc K = %d, -> %.3f\n\n', i , tr_accu ));
    i=i+2;
end


end

function [] = Q52DB()
disp(sprintf( '\n%%%%%%%%%%%%%%%%%%%%%%%%%%%% Decision Tree %%%%%%%%%%%%%%%%%%%%%%%%%%%%' ));
clear y Fs
train_label=importLabelT('hw1ttt_train.data');
test_label=importLabelT('hw1ttt_test.data');
valid_label=importLabelT('hw1ttt_valid.data');
valid_data=importFeaturesT('hw1ttt_valid.data');
test_data=importFeaturesT('hw1ttt_test.data');
train_data=importFeaturesT('hw1ttt_train.data');

[Training_Accuray] = DecisionTree( train_data, train_label, train_data, train_label)
[Testing_Accuray ] = DecisionTree( train_data, train_label, test_data, test_label)
[Validation_Accuray ] = DecisionTree( train_data, train_label, valid_data, valid_label)
end

function [] = Q52e()
clear y Fs
load('hw1boundary.mat')
figure
knn_boundry( features, labels, 1, 1 )
title( char( sprintf( 'k= %.3f', 1 ) ) );
knn_boundry( features, labels, 2, 5 )
title( char( sprintf( 'k= %.3f', 5 ) ) );
knn_boundry( features, labels, 3, 15 )
title( char( sprintf( 'k= %.3f', 15 ) ) );
knn_boundry( features, labels, 4, 25 )
title( char( sprintf( 'k= %.3f', 25 ) ) );
end