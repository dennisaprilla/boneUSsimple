function display_boneportion(axes_object, upperlower_bound, bone, varargin)

default_tag = "plot";

p = inputParser;
addRequired(p, 'axes_object');
addRequired(p, 'lowerupper_bound');
addRequired(p, 'bone');
addParameter(p, 'Tag', default_tag, @isstring);

parse(p, axes_object, upperlower_bound, bone, varargin{:});

% calculate max min of the bone to obtain coordinates
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

upper_z = maxmin(1,3) - size(3)*upperlower_bound(1);
lower_z = maxmin(1,3) - size(3)*upperlower_bound(2);

bone_portion = bone( (bone(:,3) <= upper_z) & (bone(:,3) >= lower_z), :);

plot3( axes_object, ...
       bone_portion(:,1), ...
       bone_portion(:,2), ...
       bone_portion(:,3), ...
       '.', 'Color', [0.9290 0.6940 0.1250], ...
       'MarkerSize', 0.1, ...
       'Tag', p.Results.Tag);

end

