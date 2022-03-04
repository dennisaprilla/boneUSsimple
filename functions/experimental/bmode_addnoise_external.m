function [bmode_afternoise, dof_noise] = bmode_addnoise_external(bmode_pointcloud, R_noise, t_noise)

% 1) change origin to the centroid of the bmode
bmode_centroid = mean(bmode_pointcloud, 1);
bmode_translated = bsxfun(@minus, bmode_pointcloud, bmode_centroid);

% 2a) create random rotation
random_degrees = -R_noise + rand(1,3) .* ( 2*R_noise );
random_radians = deg2rad( random_degrees );
random_rotm  = eul2rotm(random_radians, 'ZYX');

% 2b) create random translation
random_trans = -t_noise + rand(1,3) .* ( 2*t_noise );

% 2c) construct the transformation
dof_noise = [random_degrees, random_trans];
T_noise = [random_rotm, random_trans'; 0 0 0 1];

% 3) transform the bmode pointcloud with noise transformation
bmode_translated_afternoise = homogeneous2cartesian( T_noise * cartesian2homogeneous(bmode_translated) );

% 4) returned it to original origin
bmode_afternoise = bsxfun(@plus, bmode_translated_afternoise, bmode_centroid);

end

