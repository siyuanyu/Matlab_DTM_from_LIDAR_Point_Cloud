function raster = pointcloud(path, display)
% wrapper function, creates DTM raster from path to pointcloud data
% input: a path to the .fuse pointcloud file
% a boolean indicating whether or not to display the output
% output: gridded raster data

% open the file

fileID = fopen(path,'r');
formatSpec = '%f %f %f %f';
sizexyz = [4 Inf];

% get the initial lat lon points by scanning from file

xyzPoints = fscanf(fileID,formatSpec, sizexyz).';
xyzPoints = xyzPoints(:,1:3);
ptCloud = pointCloud(xyzPoints);
if display
    pcshow(ptCloud);
end

% get x,y,z coordinates in meters from 0,0,0

curr_points = coords_from_lat_lon(xyzPoints, ptCloud);
curr_cloud = pointCloud(curr_points);
init_cloud = curr_cloud;
if display
    figure();
    pcshow(curr_cloud);
end

% loop start conditions

avg_error = Inf;
threshold = .1;
box_size = 2;
up_tol = 1;
down_tol = 1;

% loop through method, until error is better than threshold
% see slides for methodology description

while avg_error > threshold

    % calculate gridded minimums 
    min_pts = get_minimums(curr_cloud, box_size);
    if display
        figure();
        pcshow(pointCloud(min_pts));
    end

    % fit surface to gridded minimums
    [ fitobject, gof, output ] = fit_surface( min_pts(:,1), min_pts(:,2), min_pts(:,3), 'poly44');
    if display
        figure();
        plot(fitobject);
    end
    
    % filter by surface
    [curr_points,avg_error] = filter_by_surf(curr_points, fitobject, up_tol, down_tol);
    curr_cloud = pointCloud(curr_points);
    if display
        figure();
        pcshow(curr_cloud);  
    end
    
    % resetting for new loop
    up_tol = up_tol / 2;
    down_tol = down_tol / 2;
    box_size = box_size / 2;

end

% Linear Interpolation
[fitresult, gof] = createFit(curr_points(:,1), curr_points(:,2), curr_points(:,3));
[raster] = plot_raster(init_cloud, fitresult, 1);

end

