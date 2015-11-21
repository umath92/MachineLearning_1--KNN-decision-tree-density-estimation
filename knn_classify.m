function [new_accu, train_accu] = knn_classify(train_data, train_label, new_data, new_label, K)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  K: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CSCI 567: Machine Learning, Fall 2015, Homework 1
% ILoo is used for Leave-One-Out

 function [accuracy] = knn(train_data, train_label, new_data, new_label, isLOO)       

        resultClass = zeros(length(new_data),1);
        
        for testRow = 1:length(new_data)
            distanceMatrix = zeros(length(train_data),2);
            testMat = repmat(new_data(testRow,:),length(train_data),1); 
            
            % ------------------------------------------
            % Mode Euclidian Distance
            for distRow = 1:length(testMat)
                if isLOO && distRow==testRow
                      distanceMatrix(distRow,1) = 100000000;
                else
                     distanceMatrix(distRow,1) = norm(testMat(distRow,:) - train_data(distRow,:));
                end  
                distanceMatrix(distRow,2) = train_label(distRow);
            end

            
            distanceMatrix = sortrows(distanceMatrix,1);
            % 2 is no. of class.
            classValues = zeros(1,2); 
            for index = 1:K 
               classValues(distanceMatrix(index,2))=classValues(distanceMatrix(index,2))+1;
            end
            %classValues
            [~,I] = max(classValues);
            resultClass(testRow) = I;
        end
                accuracy = getAccuracy(resultClass,new_label); 
           
 end
        train_accu = knn(train_data,train_label,train_data,train_label,1);
        new_accu = knn(train_data,train_label,new_data,new_label,0);
    
end


function accuracy = getAccuracy(resultClass, newLabel)
accuracy = (sum(resultClass==newLabel)/length(resultClass));
accuracy = accuracy*100;
end


% % Creates Dummy variable and concatenates it to the table
% function table = createDummyConcat(data,s,l)
% for i = s:l
%     data = horzcat(data,num2cell(dummyvar(categorical(data(:,i)))));
% end
% table = data;
% end






