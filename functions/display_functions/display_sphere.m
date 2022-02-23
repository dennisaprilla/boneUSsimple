function display_sphere(axes_object, centroid, radius, varargin)
%DISPLAY_SPHERE Summary of this function goes here
%   Detailed explanation goes here

default_tag = "plot";
default_center = true;

p = inputParser;
addRequired(p, 'axes_object');
addRequired(p, 'radius');
addRequired(p, 'centroid');
addParameter(p, 'Tag', default_tag, @isstring);
addParameter(p, 'Center', default_center, @isboolean);

parse(p, axes_object, radius, centroid, varargin{:});

[X, Y, Z] = sphere;
X = X*radius;
Y = Y*radius;
Z = Z*radius;
plot_sphere = surf(axes_object, ...
                   X+centroid(1), ...
                   Y+centroid(2), ...
                   Z+centroid(3));
               
plot_sphere.FaceAlpha = 0.15;
plot_sphere.EdgeColor = 'none';
plot_sphere.Tag = p.Results.Tag;

if (p.Results.Center)
    plot3(axes_object, centroid(1), centroid(2), centroid(3), ...
          'or', 'MarkerFaceColor', 'r', 'Tag', p.Results.Tag);
end

end

