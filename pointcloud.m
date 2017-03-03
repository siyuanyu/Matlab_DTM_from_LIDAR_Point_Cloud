% point cloud playing script

clear;

jacob_path ='/Users/jdbruce/Downloads/WQ2017/Geospatial/HW3 and Final/Final Project/final_project_data/final_project_point_cloud.fuse';

path = jacob_path;

fileID = fopen(path,'r');
formatSpec = '%f %f %f %f';
sizexyz = [4 Inf];

xyzPoints = fscanf(fileID,formatSpec, sizexyz).';
xyzPoints = xyzPoints(:,1:3);

ptCloud = pointCloud(xyzPoints);
xlims = ptCloud.XLimits;
ylims = ptCloud.YLimits;
zlims = ptCloud.ZLimits;

curr_points = coords_from_lat_lon(xyzPoints, ptCloud);
curr_cloud = pointCloud(scaledPoints);

pcshow(curr_cloud);

avg_err = Inf;
threshold = .25;
box_size = 2;
up_tol = 1;
down_tol = 1;

while avg_err > threshold

    min_pts = get_minimums(curr_cloud, box_size);
    figure();
    pcshow(pointCloud(min_pts));

    [ fitobject, gof, output ] = fit_surface( min_pts(:,1), min_pts(:,2), min_pts(:,3), 'poly44');
    figure();
    plot(fitobject);

    [curr_points,avg_error] = filter_by_surf(curr_points, fitobject, 1, 1);
    curr_cloud = pointCloud(curr_points);
    figure();
    pcshow(curr_cloud);  
    
    % resetting for new loop
    up_tol = up_tol / 2;
    down_tol = down_tol / 2;
    

end





