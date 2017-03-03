function [new_points] = filter_by_surf(old_points,surface,tol_positive,tol_negative)

for ii = 1:size(old_points,1)

    x = old_points(ii,1);
    y = old_points(ii,2);
    
    z_cutoff_max = surface([x,y])+tol_positive;
    z_cutoff_min = surface([x,y])-tol_negative;
    
    if (old_points(ii,3) < z_cutoff_min) || (old_points(ii,3) > z_cutoff_max)
        old_points(ii,:) = NaN;
    end

end

old_points(isnan(old_points(:,3)),:) = [];
new_points = old_points;
