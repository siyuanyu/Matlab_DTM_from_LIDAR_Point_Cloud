function coords = coords_from_lat_lon(points, ptCloud)
% converts lat/lon data to distance in meters
% lowest xyz points are 0,0,0
% input: xyzPoints, Mx3, lat lon elev
% output:  Mx3, x y z in meters

M = ptCloud.Count;

lat_ref_vect = ptCloud.XLimits(1) * ones(M,2);
lat_ref_vect(:,2) = points(:,2);
x_coords = dist_from_ref_pts(lat_ref_vect, points);

lon_ref_vect = ptCloud.YLimits(1) * ones(M,2);
lon_ref_vect(:,1) = points(:,1);
y_coords = dist_from_ref_pts(lon_ref_vect, points);

coords = ones(M,3);
coords(:,1) = x_coords;
coords(:,2) = y_coords;
coords(:,3) = points(:,3) - ptCloud.ZLimits(1);

end