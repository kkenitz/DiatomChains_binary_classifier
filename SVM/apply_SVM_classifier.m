function SVM_output=apply_SVM_classifier(ScoreSVMModel,target_data)

    X_target=cell2mat(target_data(:,2:end));
    ID_target=target_data(:,1);
    [ypredict, probs]=predict(ScoreSVMModel,X_target);

    SVM_output=[ID_target,ypredict,num2cell(probs)];
end