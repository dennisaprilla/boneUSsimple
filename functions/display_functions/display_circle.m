function display_circle(axes_object, center, radius, varargin)


default_tag = "plot";

p = inputParser;
addRequired(p, 'axes_object');
addRequired(p, 'center');
addRequired(p, 'radius');
addParameter(p, 'Tag', default_tag, @isstring);

parse(p, axes_object, center, radius, varargin{:});

th = 0:pi/50:2*pi;
xunit = radius * cos(th) + center(1);
yunit = radius * sin(th) + center(2);

plot(axes_object, xunit, yunit, 'Color', 'g', 'Tag', p.Results.Tag);
    
end