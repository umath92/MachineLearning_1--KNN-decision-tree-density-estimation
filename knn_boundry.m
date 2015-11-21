function [  ] = knn_boundry( features, labels, iter, k )

mat = rand(10000,2);
class = ones(1,10000);
labels( labels==-1 )=2; 
[class] = knn_classify_draw(zscore(features), labels, zscore(mat), class, k);

class = class';

subplot(2,2,iter)
gscatter(mat(:,1),mat(:,2),class,'yr','x*');
end

