# Digital Terrain Modeling

## Jacob Bruce, Derek Oung, Will Molter, and Ryan Yu

### EECS 395/495: Geospatial Vision and Mapping, Northwestern University, Winter 2017

### Professor Xin Chen

This project gets a digital terrain model (DTM) from a LiDAR point cloud.

To use, run the `pointcloud` function.  It takes the path to the point cloud data (as a .fuse file)
and a boolean "display", which specifies whether to plot intermediate steps in the algorithm.

`plot_raster` : Takes in a raster and a point cloud and plots a surface from the raster, and the
surface on top of the point cloud.

`get_minimums` : Takes a point cloud and returns a new cloud with only the local minimum elevation
points within a certain box size.

`fit_surface` : Uses MATLAB's `fit` function to get a surface approximation from a point cloud.

`filter_by_surf` : Takes a surface and a point cloud and returns a new point cloud with points
too far from the surface removed.

`dist_from_ref_pts` : Gets the distance in meters from one reference point to an array of other points,
both specified in latitude and longitude.

`createFit` : Auto-generated function by MATLAB for getting the surface fit.

`coords_from_lat_lon` : Takes a latitude/longitude point cloud and returns a set of corresponding 3D
points in meters.