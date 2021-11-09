function ScoreSVMModel=train_SVM_classifier(X_train, Y_train, box_constraint,kernel_scale)

    tModel=fitcsvm(X_train,Y_train,'KernelFunction','rbf','Standardize',true,'BoxConstraint',box_constraint,...
            'KernelScale',kernel_scale);
    ScoreSVMModel = fitSVMPosterior(tModel,X_train,Y_train);

end

