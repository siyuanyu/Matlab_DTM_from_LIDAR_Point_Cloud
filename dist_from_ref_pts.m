function distance = dist_from_ref_pts(reference, points)
    % inputs: reference, a [lat lon] point. 
    %         points, a [lat lon] array
    % distance: an array of distances, from each point in points to the
    % reference

    R = 6378.137; % Radius of earth in KM
    dLat = points(:,1) * pi / 180 - reference(:,1) * pi / 180;
    dLon = points(:,2) * pi / 180 - reference(:,2) * pi / 180;
    a = sin(dLat/2) .* sin(dLat/2) + cos(reference(:,1) .* pi/ 180) .* cos(points(:,1) .* pi / 180) .* sin(dLon/2) .* sin(dLon/2);
    c = 2 * atan2(sqrt(a), sqrt(1-a));
    d = R * c;
    distance = d * 1000;
    
    
end




