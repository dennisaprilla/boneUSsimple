function [cartesianPoints] = homogeneous2cartesian(homogeneousPoints)
%HOMOGENEOUS2CARTESIAN Summary of this function goes here
%   Detailed explanation goes here
    dim = size(homogeneousPoints, 1);

    cartesianPoints = homogeneousPoints(1:dim-1,:)';
end

