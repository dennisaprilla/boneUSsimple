function boneportion_pointcloud = get_boneportion(upperlower_bound, bone)
%GET_BONEPORTION Summary of this function goes here
%   Detailed explanation goes here
% calculate max min of the bone to obtain coordinates
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

upper_z = maxmin(1,3) - size(3)*upperlower_bound(1);
lower_z = maxmin(1,3) - size(3)*upperlower_bound(2);

boneportion_pointcloud = bone( (bone(:,3) <= upper_z) & (bone(:,3) >= lower_z), :);

% testing
boneportion_pointcloud = boneportion_pointcloud( (boneportion_pointcloud(:,2) <= -0.005), :);

end

