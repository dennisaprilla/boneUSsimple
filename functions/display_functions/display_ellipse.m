function display_ellipse(axes_object, ellipse_struct, varargin)

    
    default_tag = "plot";

    p = inputParser;
    addRequired(p, 'axes_object');
    addRequired(p, 'ellipse_struct');
    addParameter(p, 'Tag', default_tag, @isstring);

    parse(p, axes_object, ellipse_struct, varargin{:});
    

    a   = ellipse_struct.a;
    b   = ellipse_struct.b;
    phi = ellipse_struct.phi;
    X0  = ellipse_struct.X0;
    Y0  = ellipse_struct.Y0;
    X0_in = ellipse_struct.X0_in;
    Y0_in = ellipse_struct.Y0_in;
    long_axis = ellipse_struct.long_axis;
    short_axis = ellipse_struct.short_axis;
    status = ellipse_struct.status;

    % rotation matrix to rotate the axes with respect to an angle phi
    R = [ cos(phi) sin(phi); ...
          -sin(phi) cos(phi) ];
    
    % the axes
    ver_line        = [ [X0 X0]; Y0+b*[-1 1] ];
    horz_line       = [ X0+a*[-1 1]; [Y0 Y0] ];
    new_ver_line    = R*ver_line;
    new_horz_line   = R*horz_line;
    
    % the ellipse
    theta_r         = linspace(0,2*pi);
    ellipse_x_r     = X0 + a*cos( theta_r );
    ellipse_y_r     = Y0 + b*sin( theta_r );
    rotated_ellipse = R * [ellipse_x_r;ellipse_y_r];
    
    % draw
    plot( axes_object, new_ver_line(1,:), new_ver_line(2,:), ...
          'r', 'Tag', p.Results.Tag );
    plot( axes_object, new_horz_line(1,:), new_horz_line(2,:), ...
          'r', 'Tag', p.Results.Tag );
    plot( axes_object, rotated_ellipse(1,:), rotated_ellipse(2,:), ...
          'r', 'Tag', p.Results.Tag );
      
      
    vector_xaxis = R * [1; 0];
    vector_yaxis = R * [0; 1];

end

