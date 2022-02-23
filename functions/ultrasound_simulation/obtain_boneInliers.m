function [nearest_bone2us,usDuplicated] = obtain_boneInliers(bone, ultrasound, distance)

[indices, dists] = knnsearch( ultrasound, bone );

keepInlier_bone = dists < distance;
inlierIndices_bone = find(keepInlier_bone);
inlierIndices_us = indices(keepInlier_bone);

nearest_bone2us = bone(inlierIndices_bone, :);
usDuplicated = ultrasound(inlierIndices_us, :); 

end

