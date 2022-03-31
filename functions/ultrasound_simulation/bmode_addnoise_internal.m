function [bmode_3d_afternoise, random_noise] = bmode_addnoise_internal(bmode_plane, bmode_pointcloud, t_noise, s_noise)

% to mimic b-mode noise, it is suppose to be on the plane. we already knew
% the normal axis of the plane, we should find the other two axes. These
% two axes must be orthogonal to normal axis and orthogonal to each other.

% 1) take normal vector of b-mode simulation plane
bmode_planenormal_vector = bmode_plane.slice(1:3) ./ norm(bmode_plane.slice(1:3));

% 2) find axis that lies on plane. we can use the bmode_plane.beam normal
% vector, since it is perpendicular to the bmode_plane.slice normal vector
bmode_planeaxis1_vector = bmode_plane.beam(1:3) ./ norm(bmode_plane.beam(1:3));

% 3) perform cross product between two axes above, to obtain the third axis
bmode_planeaxis2_vector = cross(bmode_planenormal_vector, bmode_planeaxis1_vector);

% 4) construct transformation and project the b-mode to 2d plane
bmode_origin = mean(bmode_pointcloud, 1);
base_axes = [bmode_planeaxis1_vector, bmode_planeaxis2_vector, bmode_planenormal_vector];
T_2d3d = [base_axes, bmode_origin'; 0 0 0 1];
bmode_2d = homogeneous2cartesian( inverseHMat(T_2d3d) * cartesian2homogeneous(bmode_pointcloud) );

% 5a) before performing 2d transformation, we change the origin
bmode_2d_origin = mean(bmode_2d, 1);
bmode_2d_meantranslated = bsxfun(@minus, bmode_2d, bmode_2d_origin);

% 5b) create parameter for 2d transformation for noise
random_trans   = -t_noise + rand(1,2) .* ( 2*t_noise );
% random_trans   = [t_noise(1) t_noise(2)];
random_scale   = -s_noise + rand(1,2) .* ( 2*s_noise );
random_smatrix = [1+random_scale(1) 0; 0 1+random_scale(2)];

% 5c) construct transformation
random_noise = [ random_trans, random_scale ];
random_T = [random_smatrix, random_trans'; 0 0 1];

% 5d) apply transformation
bmode_2d_meantranslated_afternoise = homogeneous2cartesian( random_T * cartesian2homogeneous(bmode_2d_meantranslated(:,1:2)) );

% 5e) return back to the original origin
bmode_2d_meantranslated_afternoise = [ bmode_2d_meantranslated_afternoise, bmode_2d_meantranslated(:, 3) ];
bmode_2d_afternoise = bsxfun(@plus, bmode_2d_meantranslated_afternoise, bmode_2d_origin);

%{
figure(1);
plot(bmode_2d(:,1), bmode_2d(:, 2), '.r');
grid on; axis equal; hold on;
plot(bmode_2d_afternoise(:,1), bmode_2d_afternoise(:, 2), '.g');
legend('Original B-mode', '2D Transformed B-mode');
%}

% 6) return back to 3d world
bmode_3d_afternoise = homogeneous2cartesian( T_2d3d * cartesian2homogeneous(bmode_2d_afternoise) );

end

