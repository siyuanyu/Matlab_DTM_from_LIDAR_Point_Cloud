% point cloud playing script

path = '/Users/jdbruce/Downloads/final_project_point_cloud.fuse';

fileID = fopen(path,'r');
formatSpec = '%f %f %f %f';
sizexyz = [4 Inf];

xyzPoints = fscanf(fileID,formatSpec, sizexyz).';
xyzPoints = xyzPoints(:,1:3);

ptCloud = pointCloud(xyzPoints);
xlims = ptCloud.XLimits;
ylims = ptCloud.YLimits;
zlims = ptCloud.ZLimits;

scaledPoints = zeros(ptCloud.Count, 3);

scaledPoints(:,1) = 100.*(xyzPoints(:,1) - xlims(1))./(xlims(2)-xlims(1));
scaledPoints(:,2) = 100.*(xyzPoints(:,2) - ylims(1))./(ylims(2)-ylims(1));
scaledPoints(:,3) = 25.*(xyzPoints(:,3) - zlims(1))./(zlims(2)-zlims(1));

scaledCloud = pointCloud(scaledPoints);

pcshow(scaledCloud);