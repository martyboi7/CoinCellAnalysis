function real_Capacity = skipZeroCapacityCycles(capacity)
    % getmedischarge and getmecharge will fill the discharge_capacity and
    % charge_capacity variables with zeros if we do not use all the cycles.
    % In that case, this function removes the zeros, so a significant plot
    % can be made. 
    
    % get rid of zero values - which are because we skipped entries
    index_zero_capacity = find(capacity(:,2));
    real_Capacity = capacity(index_zero_capacity,:);    
end