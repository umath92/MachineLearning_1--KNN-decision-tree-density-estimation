function [] =Density()
h=[.002,.025,.066,.1,.2]
partA(h);
partB(h);
end

function [] = partB(h)
clear y Fs
load('hw1progde.mat','x_te')
[len,b]=size(x_te);

for i= 1:19
    data(1:500,i)=x_te(500*(i-1)+1:500*i);
end

[lenh,q]=size(h);
sum=zeros(lenh,1);
k=int8(1);
for hval = h
    mean=zeros(50,1);
    for i=1:19
        [fVector,x] = doSum(hval,data(:,i),1,50);
        fVec(:,i)=fVector;
        mean=mean+fVector;
    end
    mean=mean.*(1/19);
    sum(int8(k))=integralB(fVec,mean);
    k=k+1;
end
figure
% Plotting for other.
subplot(2,2,1);
plot(h,sum)
title('Gaussian Variance');

sum=zeros(lenh,1);
k=int8(1);
for hval = h
    mean=zeros(50,1);
    for i=1:19
        [fVector,x] = doSum(hval,data(:,i),0,50);
        fVec(:,i)=fVector;
        mean=mean+fVector;
    end
    mean=mean.*(1/19);
    sum(int8(k))=integralB(fVec,mean);
    k=k+1;
end
% Plotting for Gaussian.
subplot(2,2,2);
plot(h,sum)
title( 'Epanechnikov Variance');

% Plot for Histogram
sum=zeros(lenh,1);
kk=int8(1);
for hval = h
    mean=zeros(50,1);
    for o = 1:19
        [counts,~] = hist(data(:,o),1/hval);
        counts=counts.*1/500;
        %[qwe,ewq]=size(counts)
        for k = 1:50
            top=ceil(k/(50*hval));
            if top>(1/hval)
                top=floor(k/(50*hval));
            end
            fVec(k,o)=counts(top)*(1/(50*hval));
            mean(k)=mean(k)+counts(top)*(1/(50*hval));
        end
    end
    mean=mean.*(1/19);
    sum(int8(kk))=integralB(fVec,mean);
    kk=kk+1;
end
subplot(2,2,3);
plot(h,sum)
title( 'Histogram Variance');

end
function [sum] = integralB(data,mean)
    sum=0;
    for row = 1:50
        for i = 1:19
            sum=sum+power((data(row,i)- mean(row)),2);
        end
    end
    sum=sum*(1/19)*(1/50);
end

function [] = partA(h)

% Histograms
clear y Fs
load('hw1progde.mat','x_tr')
[len,b]=size(x_tr);
figure

for i = 1:5
    subplot(2,3,i);
    hist(x_tr,1/h(i))
    title( char( sprintf( 'Histogram h= %.3f', h(i) ) ) );
end

% Gaussian Kernal
densityestimation(h');

end

function [] = densityestimation(h)
clear y Fs
load('hw1progde.mat','x_tr')

% 1 for gaussian kernal.
%format shortG
figure
for i = 1:5
    subplot(2,3,i);
    [fVector,x] = doSum(h(i),x_tr,0,100);
    plot(x,fVector)
    title( char( sprintf( 'Epan Kernal h= %.3f', h(i) ) ) );
    
end


figure
for i = 1:5
    subplot(2,3,i);
    [fVector,x] = doSum(h(i),x_tr,1,100);
    plot(x,fVector)
    title( char( sprintf( 'Gaussin Kernal h= %.3f', h(i) ) ) );
end

end

function [val]= returnK(x,p,h)
val=((1/sqrt(2*pi))*exp(-(power((x-p)/h,2))/2));
end

function [val]=returnEp(x,p,h)
u=(x-p)/h;
if abs(u)<=1
    val=(3/4)*(1-(power((x-p)/h,2)));
else
    val=0;
end

end

function [fVector,y] = doSum(h,x_tr,call,split)
y = linspace(0,1,split);
y=y';
fVector = linspace(0,1,split);
fVector=fVector';
[len,b]=size(x_tr);
i=1;
for x=y'
    sum=0;
    for ele = x_tr'
        if call==1
            val = (1/h)*returnK(x,ele,h);
        else
            val = (1/h)*returnEp(x,ele,h);
        end
        
        sum=sum+val;
    end
    fVector(i)=(1/len)*sum;
    i=i+1;
end

end

