function [raster] = plot_raster( init_cloud, fitresult, resolution )
% Linear Interpolation
% Inputs ptCloud struct

x = init_cloud.XLimits(1):resolution:init_cloud.XLimits(2);
y = init_cloud.YLimits(1):resolution:init_cloud.YLimits(2);

[X,Y] = meshgrid(x,y);
Z = zeros(size(X));

kk = 0;
for ii = 1:size(X,1)
    for jj = 1:size(X,2)
        kk = kk+1;
        raster(kk,:) = [X(ii,jj),Y(ii,jj),fitresult([ii,jj])];
        Z(ii,jj) = fitresult([X(ii,jj),Y(ii,jj)]);
    end
end

figure('Name','Final Raster with Point Cloud','NumberTitle','off')
pcshow(init_cloud)
hold on
surf(X,Y,Z)
axis equal

hold off;
figure('Name','Final Raster','NumberTitle','off')
surf(X,Y,Z)
axis equal

raster(isnan(raster(:,3)),:) = [];

end

