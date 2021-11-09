function fig=generate_fig_SVM_params(error, box_vector, sigma_vector, box_opt, sigma_opt)
    y.fn=12;
    y.fontname='Times New Roman';
    set(0,'defaultaxesfontname',y.fontname);
    set(0,'defaulttextinterpreter','latex')

    fig=figure('units','centimeters'); set(gcf,'pos',[10, 5, 14, 12]); hold on; box on; set(gca,'fontsize',y.fn)
    pcolor(box_vector,sigma_vector,error.*100)
    set(gca,'xscale','log','yscale','log')
    xlabel('Box constraint','fontsize',y.fn)
    ylabel('Kernel parameter','fontsize',y.fn)
    colormap(brewermap([],'*Reds'))
    c=colorbar; ylabel(c,'Misclassification error (%)','fontsize',y.fn)
    hold on
    scatter(box_opt, sigma_opt,50,'marker','o','markerfacecolor','k','markeredgecolor','k')
end