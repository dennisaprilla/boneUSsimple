function point_projection = find3dintersection(pointcloud, plane_coefficient, threshold)
%FINDPLANEINTERSECTION Summary of this function goes here
%   Detailed explanation goes here

% obtain plane normal
plane_normal = plane_coefficient(1:3);

% calculate distance for all points to the plane
distance_pointplane = distancePoint2Plane(pointcloud, plane_coefficient);
% select those below threshold (considered as intersection)
intersection = pointcloud( abs(distance_pointplane) < threshold, : );
% project intersection point cloud to the plane (https://stackoverflow.com/a/41897378)
point_projection = intersection - (intersection * plane_normal - plane_coefficient(4)) * plane_normal';

end

