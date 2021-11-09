function [Y_test_true, Y_test_predicted] = SVM_crossval_accuracy_iter(X_all, Y_all, DATA_SPLIT, iter, box_opt, sigma_opt)

    Y_test_true=nan(round((1-DATA_SPLIT)*length(Y_all),0),iter);
    Y_test_predicted=nan(round((1-DATA_SPLIT)*length(Y_all),0),iter);


    for i=1:iter
        rng(i);

        %prepare trainig and testing setsfor chains and non-chains
        loc=find(Y_all==1); % true =chain; false= non-chain
        loc_train=datasample(loc,round(DATA_SPLIT*length(loc),0),1,'Replace',false); % get 80% of chains, and below 80% of non chains for equal distribution
        loc_test=loc(~ismember(loc,loc_train));
        ch_train=X_all(loc_train,:); 
        ch_test=X_all(loc_test,:);
        clear loc*

        loc=find(Y_all==0); 
        loc_train=datasample(loc,round(DATA_SPLIT*length(loc),0),1,'Replace',false); 
        loc_test=loc(~ismember(loc,loc_train));
        nonch_train=X_all(loc_train,:); 
        nonch_test=X_all(loc_test,:);
        clear loc*

        X_train=[ch_train;nonch_train];
        Y_train=[ones(size(ch_train,1),1);zeros(size(nonch_train,1),1)];   
        id=randperm(length(Y_train));
        X_train=X_train(id,:);
        Y_train=Y_train(id);
        clear id ch_train nonch_train

        X_test=[ch_test;nonch_test];
        Y_test=[ones(size(ch_test,1),1);zeros(size(nonch_test,1),1)];   
        id=randperm(length(Y_test));
        Y_test=Y_test(id);
        X_test=X_test(id,:);
        clear id ch_test nonch_test

        % SVM training
        tModel=fitcsvm(X_train,Y_train,'KernelFunction','rbf','Standardize',true,'BoxConstraint',box_opt,...
                'KernelScale',sigma_opt);

        %SVM prediction
        y_predict=predict(tModel,X_test);
        Y_test_true(:,i)=Y_test;
        Y_test_predicted(:,i)=y_predict;


    end

end
