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

scaledPoints = coords_from_lat_lon(xyzPoints, ptCloud);
% scaledPoints = zeros(ptCloud.Count, 3);
% 
% scaledPoints(:,1) = 100.*(xyzPoints(:,1) - xlims(1))./(xlims(2)-xlims(1));
% scaledPoints(:,2) = 100.*(xyzPoints(:,2) - ylims(1))./(ylims(2)-ylims(1));
% scaledPoints(:,3) = 25.*(xyzPoints(:,3) - zlims(1))./(zlims(2)-zlims(1));
% 
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

    [new_points,avg_error] = filter_by_surf(scaledPoints, fitobject, 1, 1);
    figure();
    pcshow(pointCloud(new_points));
    
    % resetting for new loop
    up_tol = up_tol / 2;
    down_tol = down_tol / 2;

end





