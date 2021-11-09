function error=find_SVM_params_loop(X_train,Y_train, box_vector, sigma_vector)
    error=nan(length(box_vector),length(sigma_vector));

    for i=1:length(box)
        for j=1:length(sigma)
            disp([i,j]);
            tModel=fitcsvm(X_train,Y_train,'KernelFunction','rbf','Standardize',true,'BoxConstraint',box_vector(i),...
            'KernelScale',sigma_vector(j));
            ScoreSVMModel = fitPosterior(tModel);
            CVSVMModel = crossval(ScoreSVMModel);
            error(i,j)=kfoldLoss(CVSVMModel);
        end
    end
end
