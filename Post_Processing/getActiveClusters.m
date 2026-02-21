function activeClusters=getActiveClusters(recordOfClusters,activationVector   )



activeClusters=[];
for i=1:length(activationVector)

    if activationVector(i)
   activeClusters=[activeClusters recordOfClusters{i}];
    end
    
    
end



end