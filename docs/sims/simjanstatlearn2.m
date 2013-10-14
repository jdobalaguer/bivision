
clear all;
close all;
alphamat=[0.1 0.5 0.9];  % alpha = 0: learn from mean. alpha = 1: learn from items

trials=10000; % n trials
nitems=3;  % number of cues
f1=figure;
f2=figure;
fspace=0:0.01:1;
fspace2=-5:0.1:5;
lr=0.1;  % alpha for simualted subjects
slope=0.5;  % set to 1 for linear; 0.5 for sigmoidal

% generalised linking function for features and decisions. of course, could
% be linear...but this is more general
f = @(p,x) p(1) + (-p(1)*2) ./ (1 + exp(-(x-0)/p(2))); % probability functions

paramz=[-0.5 -1 -0.25 -0.75; [-1 1 1 -1]*slope];  % some parameters defining the prob. functions  
mparamz=[-0.75,0.5]; % and the prob. function for the mean

%for a=1:length(alphamat);
    
X=randn(trials,nitems);
mX=mean(X,2);


for a=1:length(alphamat);

% k item predictions
for k=1:size(X,2); % loop over items
    Vi(:,k)=f([paramz(1,k) paramz(2,k)], X(:,k));
end

% mean item prediction
Vi=mean(Vi,2);
Vi=scaler(Vi);

% prediction of the average
Vm=f([mparamz(1),mparamz(2)],mX);
Vm=scaler(Vm);

y=Vm.*alphamat(a) + Vi.*(1-alphamat(a));

r=rand(trials,1);
G=r<y;
Gx=logic2sign(G);

% plot stimulus dependence on the mean
R(1,:)=psychofunction(G,Vm,0.1:0.1:0.9);

% plot stimulus dependence on the items
R(2,:)=psychofunction(G,Vi,0.1:0.1:0.9);

figure(f1);
subplot(1,3,a);
plot(R');
ylim([0 1]);


% mean learner
%figure;
W=randn(1,length(fspace),1).*0.001;
for t=1:trials
   
   % activation
   %x=normpdf(fspace2,mean(X(t,:),2),0.1);
   x=normpdf(fspace2,mean(X(t,:),2),0.1);
   m_A(t)=x*W';
   
   % learning
   dW=Gx(t).*x;
   W=W+(dW*lr);
   
end

m_choice=m_A>0;
m_cor=m_choice==(y'>0.5);

% simulate item learner
W=randn(1,length(fspace),1).*0.001;
for t=1:trials
   
   % activation
   x=zeros(1,length(fspace2));
   for i=1:size(X,2)
   x=x+normpdf(fspace2,X(t,i),0.1);
   end
   i_A(t)=x*W';
   
   % learning
   dW=Gx(t).*x;
   W=W+(dW*lr);
  
end

i_choice=i_A>0;
i_cor=i_choice==(y'>0.5);

% glm recovers betas associated with input (with some noise)
B(:,1)=glmfit(X,i_choice);
B(:,2)=glmfit(X,m_choice);

figure(f2);
subplot(1,3,a);
bar(B(2:end,:))

end








