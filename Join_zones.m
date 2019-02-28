function zone = Join_zones(zone,zones)
    for i=1:length(zones)
        for j=1:length(zones(i).points)
            try
                if max(zone(:,1))<zones(i).points(j,1) || min(zone(:,2))>zones(i).points(j,2)
                    zone=[zone; zones(i).points(j,:)];
                end
            catch
                if isempty(zone)
                    zone=[zone; zones(i).points];
                end
            end
        end
    end
end