function [ fitobject, gof, output ] = fit_surface( x, y, z, char )
% Fits a surface
% Inputs
% char (fit type, ex: 'poly33' for polynomial of order 3 for x and y)
% x x location
% y y location
% z z location

fo = fitoptions('Method', 'LinearLeastSquares', ...
    'Robust', 'on');
ft = (char);
[fitobject, gof, output] = fit([x, y], z, ft, fo);

end