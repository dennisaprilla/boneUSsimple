function bmode_pointcloud_afternoise = bmode_addnoise(bmode_plane, bmode_pointcloud, noise)

% to mimic b-mode noise, it is suppose to be on the plane. we already knew
% the normal axis of the plane, we should find the other two axes. These
% two axes must be orthogonal to normal axis and orthogonal to each other.

% 1) take normal vector of b-mode simulation plane
bmode_planenormal_vector = bmode_plane(1:3) ./ norm(bmode_plane(1:3));

% 2) find axis that lies on plane. fortunately, we knew many points on
% plane (the b-mode point cloud simulation). if we subtract two of them, we
% will find a vector that lies on plane.
bmode_planeaxis1_vector = ( bmode_pointcloud(1,:) - bmode_pointcloud(2,:) ) ./ ...
                            norm( bmode_pointcloud(1,:) - bmode_pointcloud(2,:) );

% 3) perform cross product between two axes above, to obtain the third axis
bmode_planeaxis2_vector = cross(bmode_planenormal_vector, bmode_planeaxis1_vector);

bmode_noise_axis1 = normrnd( 0, ...
                             noise, ...
                             [ size(bmode_pointcloud, 1), 1] ) * bmode_planeaxis1_vector;
bmode_noise_axis2 = normrnd( 0, ...
                             noise, ...
                             [ size(bmode_pointcloud, 1), 1] ) * bmode_planeaxis2_vector;

bmode_pointcloud_afternoise = bmode_pointcloud + ...
                              ( bmode_noise_axis1 + bmode_noise_axis2);

end

