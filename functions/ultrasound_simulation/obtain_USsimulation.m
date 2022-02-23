function [pointcloud, plane] = obtain_USsimulation(bone_pointcloud, plane_translation_z, plane1_rotation_x, plane1_rotation_y, plane2_translation_sideways, plane2_rotation_z, epsilon)
%OBTAINUS_SIMULATION Summary of this function goes here
%   Detailed explanation goes here

% what i want is i can control the rotation (especially x axis) of plane 1,
% previously, i determine unit vector representing plane normal, and rotate
% it with rotation matrix. Unfortunately, it is hard to control the region
% of interest (let's say we want to see bone region at z=150.
% So, i define z to be exact 1, and i control the x
% normal axis to rotate plane. This makes the pivot on the plane is in the
% d component of the coeficient, however i rotate the plane, it is locked
% in that particular point. Then i convert the slope to angle in order to
% make it even more easier to control.

% let's consider the plane only in xz plane, so we could consider z as the
% y axis, so that, angle = atan2(x,y) => x = tan(angle) * y;
x_normal = tan(deg2rad(plane1_rotation_x))*1;

% let's consider the plane only in yz plane, so we could consider y as the
% x axis, and z as y axis
y_normal = tan(deg2rad(plane1_rotation_y))*1;

% define plane1 normal
plane_1_normal = [x_normal y_normal 1]';

% define plane_1 coefficients
plane_1_coefficient = [plane_1_normal; plane_translation_z];

% calculate distance for all points to the plane
distance_pointplane = ((bone_pointcloud * plane_1_normal ) - plane_1_coefficient(4)) / norm(plane_1_normal);
% select those below threshold (considered as intersection)
intersection = bone_pointcloud(abs(distance_pointplane) < epsilon,:);
% project intersection point cloud to the plane (https://stackoverflow.com/a/41897378)
pointprojection_inplane = intersection - (intersection * plane_1_normal - plane_1_coefficient(4)) * plane_1_normal';

% define second plane for selecting the point (replicating how US measurement works)
% for easiness the plane has to be perpendicular with the previous plane
% for initialization, arbritrary perpendicular normal will be defined, then later it can be rotated
plane_2_normal = rotz(plane2_rotation_z) * roty(90) * [0 0 1]';

% define plane_2 coefficients
plane_2_coefficient = [plane_2_normal; plane2_translation_sideways];

% calculate distance for all intersection points in plane 1 to the plane 2
distance_pointplane = ((pointprojection_inplane * plane_2_normal ) - plane_2_coefficient(4)) / norm(plane_2_normal);

% select only positive distance
US_simulation = pointprojection_inplane(distance_pointplane>0,:);

pointcloud.intersection = intersection;
pointcloud.pointprojection_inplane = pointprojection_inplane;
pointcloud.US_simulation = US_simulation;

plane.slice = plane_1_coefficient;
plane.beam = plane_2_coefficient;
end

