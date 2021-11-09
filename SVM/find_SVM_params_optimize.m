function [box_opt, sigma_opt]=find_SVM_params_optimize(X_train,Y_train)

    tModel=fitcsvm(X_train,Y_train,'KernelFunction','rbf','Standardize',true,'OptimizeHyperparameters','auto',...
         'HyperparameterOptimizationOptions',struct('AcquisitionFunctionName',...
         'expected-improvement-plus'));
    box_opt=table2array(tModel.HyperparameterOptimizationResults.XAtMinEstimatedObjective(:,'BoxConstraint'));
    sigma_opt=table2array(tModel.HyperparameterOptimizationResults.XAtMinEstimatedObjective(:,'KernelScale'));

end