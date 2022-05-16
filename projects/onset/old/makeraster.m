function makeraster

for ipatient = 1

    figure;hold;
    i=0;
    timespike = [];
    icluster = size(SpikeTrials{ipatient}{ipart}.CriseStart.time,2);
    isical = zeros(icluster, size(timespike,2)-1);

    %subplot(3,1,1)
    for icluster=1:size(SpikeTrials{ipatient}{ipart}.CriseStart.time,2)
        i=i+1;
        timespike=[SpikeTrials{ipatient}{ipart}.CriseStart.time{icluster} ;SpikeTrials{ipatient}{ipart}.CriseStart.time{icluster}];
        barDummy=ones(size(timespike));
        barsize=barDummy.*[i+1 ;i+2];
        plot(timespike,barsize,'k');
        
        
%         for n = 1:size(timespike,2)-1;
%             isical(icluster, n)=timespike(1, n+1)-timespike(1, n);
%         end
%         isiinv = 1./isical;
%         isiclus = isiinv(icluster, :);
%         plot(isiclus)
%         i=i+1;
    
    end %icluster
    


    xlim([-40 20])
    ylim([0 10])
    xline(0,'LineStyle','--','Color','r','LineWidth',2)

end 

