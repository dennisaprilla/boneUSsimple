function display_plane(axes_object, plane_coeff, size, varargin)

    default_tag = "plot";

    p = inputParser;
    addRequired(p, 'axes_object');
    addRequired(p, 'plane_coeff');
    addRequired(p, 'size');
    addParameter(p, 'Tag', default_tag, @isstring);

    parse(p, axes_object, plane_coeff, size, varargin{:});

    step = size/10;

    [x, y] = meshgrid(-size : step : size);
    zvalues = -1/plane_coeff(3)*(plane_coeff(1)*x + plane_coeff(2)*y - plane_coeff(4));

    plot_plane = surf(axes_object, x, y, zvalues);
    plot_plane.FaceAlpha = 0.5;
    plot_plane.EdgeColor = 'none';
    plot_plane.Tag = p.Results.Tag;

end

