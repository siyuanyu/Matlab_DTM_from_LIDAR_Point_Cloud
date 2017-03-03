function [ fitobject, gof, output ] = fit_surface( x, y, z, char )
% Fits a surface given z values of points in x, y

fo = fitoptions('Method', 'LinearLeastSquares', ...
    'Robust', 'on');
ft = (char);
[fitobject, gof, output] = fit([x, y], z, ft, fo);

end