% pointcloud.m
% Derek Oung, Ryan Yu, Will Molter, Jacob Bruce
% Geospatial Vision and Visualization Final Project
% Winter Quarter 2017, 3/3/17
% Script uses a path to a point cloud of a car driving on a road to
% determine a DEM of the road surface

clear;

% setting up reader to point cloud fuse file

ryan_path ='C:\Users\siyua\Desktop\final_project_data\final_project_point_cloud.fuse';
jacob_path ='/Users/jdbruce/Downloads/WQ2017/Geospatial/HW3 and Final/Final Project/final_project_data/final_project_point_cloud.fuse';
<<<<<<< HEAD
derek_path = 'C:\Users\derek_000\Documents\Northwestern Work 2\EECS 495 Geospatial Project\final_project_data\final_project_point_cloud.fuse';

path = derek_path;
=======
path = jacob_path;
>>>>>>> origin/master

fileID = fopen(path,'r');
formatSpec = '%f %f %f %f';
sizexyz = [4 Inf];

% get the initial lat lon points by scanning from file

xyzPoints = fscanf(fileID,formatSpec, sizexyz).';
xyzPoints = xyzPoints(:,1:3);
ptCloud = pointCloud(xyzPoints);
pcshow(ptCloud);

% get x,y,z coordinates in meters from 0,0,0

curr_points = coords_from_lat_lon(xyzPoints, ptCloud);
curr_cloud = pointCloud(curr_points);
init_cloud = curr_cloud;
pcshow(curr_cloud);

% loop start conditions

avg_error = Inf;
threshold = .1;
box_size = 2;
up_tol = 1;
down_tol = 1;

while avg_error > threshold

    min_pts = get_minimums(curr_cloud, box_size);
    figure();
    pcshow(pointCloud(min_pts));

    [ fitobject, gof, output ] = fit_surface( min_pts(:,1), min_pts(:,2), min_pts(:,3), 'poly44');
    figure();
    plot(fitobject);

    [curr_points,avg_error] = filter_by_surf(curr_points, fitobject, up_tol, down_tol);
    curr_cloud = pointCloud(curr_points);
    figure();
    pcshow(curr_cloud);  
    
    % resetting for new loop
    up_tol = up_tol / 2;
    down_tol = down_tol / 2;
    box_size = box_size / 2;

end

<<<<<<< HEAD
% Linear Interpolation
[fitresult, gof] = createFit(curr_points(:,1), curr_points(:,2), curr_points(:,3));
[X,Y,raster] = plot_raster(init_cloud, fitresult, 1);
=======


>>>>>>> origin/master
