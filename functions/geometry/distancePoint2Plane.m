function distance_pointplane = distancePoint2Plane(pointcloud,plane_coefficient)
%DISTANCEPOINT2PLANE Summary of this function goes here
%   Detailed explanation goes here

plane_normal = plane_coefficient(1:3);
distance_pointplane = ((pointcloud * plane_normal ) - plane_coefficient(4)) / norm(plane_normal);

end

