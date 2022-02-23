function display_planeslice(axes_object, pointcloud, plane, size, varargin)

% i want to make this display function as generic as possible. That 'tag'
% thing is really specialize for GUI display (I specified 'tag' so i could
% delete certain plot when i want to update it). Therefore, i define it as 
% optional argument here. Thus this function can be used outside my GUI program.

default_tag = "plot";

p = inputParser;
addRequired(p, 'axes_object');
addRequired(p, 'pointcloud');
addRequired(p, 'plane');
addRequired(p, 'size');
addParameter(p, 'Tag', default_tag, @isstring);

parse(p, axes_object, pointcloud, plane, size, varargin{:});

% we want to display the plane, first we have to determine the size to make
% sure the display is appropriate, because the bone model could be in
% various size (maybe it is normalized, maybe it is not)
step = size/50;

[x, y] = meshgrid(-size : step : size);
proximal_planeslice_zvalues = -1/plane.slice(3)*(plane.slice(1)*x + plane.slice(2)*y - plane.slice(4));

plot_slicePlane = surf(axes_object, x, y, proximal_planeslice_zvalues);
plot_slicePlane.FaceAlpha = 0.5;
plot_slicePlane.EdgeColor = 'none';
plot_slicePlane.Tag = p.Results.Tag;

plot_intersection   = plot3(axes_object, ...
                            pointcloud.intersection(:,1), ...
                            pointcloud.intersection(:,2), ...
                            pointcloud.intersection(:,3), ...
                            '.r', 'MarkerSize', 7, ...
                            'Tag', p.Results.Tag);
                    
plot_pointProjection = plot3(axes_object, ...
                             pointcloud.pointprojection_inplane(:,1), ...
                             pointcloud.pointprojection_inplane(:,2), ...
                             pointcloud.pointprojection_inplane(:,3), ...
                             '.g', 'MarkerSize', 7, ...
                             'Tag', p.Results.Tag);

plot_usBeam = plot3(axes_object, ...
                    pointcloud.US_simulation(:,1), ...
                    pointcloud.US_simulation(:,2), ...
                    pointcloud.US_simulation(:,3), ...
                    'ob', 'MarkerFaceColor','b', ...
                    'Tag', p.Results.Tag);

% because i don't know how to display vertical plane (the plane that
% controls direction of US measurement), i will only display intersection
% line between plane 1 and plane 2
% https://nl.mathworks.com/matlabcentral/fileexchange/17618-plane-intersection
[point_inline, line_directionvector, check] = plane_intersect(plane.slice(1:3), ...
                                                                [0,0, plane.slice(4)], ...
                                                                plane.beam(1:3), ...
                                                                [plane.beam(4)/plane.beam(1), 0, 0]);


% https://math.stackexchange.com/a/1389928
t = linspace(-size, size, 200);
line_points = point_inline' + line_directionvector * t;

plot_usPlane = plot3( axes_object, ...
                      line_points(1,:)', ...
                      line_points(2,:)', ...
                      line_points(3,:)', ...
                      '-m', 'Tag', p.Results.Tag);

end

