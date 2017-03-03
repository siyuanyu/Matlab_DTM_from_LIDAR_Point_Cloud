% Linear Interpolation
[fitresult, gof] = createFit(curr_points(:,1), curr_points(:,2), curr_points(:,3));

[raster] = plot_raster(init_cloud, fitresult, 1);