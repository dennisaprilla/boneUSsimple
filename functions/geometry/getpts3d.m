function [pts] = getpts3d(figure, axes_object, n)
    %% getpts3d Select points from a 3D scatter plot by clicking on plot
    % x - Vector of X coordinates
    % y - Vector of Y coordinates
    % z - Vector of Z coordinates
    % n - Number of points needed to be selected
    % pts - Returns a n x 3 matrix of selected points

    %scatter3(axes_object, x,y,z);
    pts = [];
    datacursormode on
    dcm_obj = datacursormode(figure);

    for i=1:n
        fprintf('Click on figure for point %d\n',i)
        waitforbuttonpress;
        f = getCursorInfo(dcm_obj);
        pts = [pts; f.Position];
        
        delete(findobj('Tag', 'amode'));
        plot3(axes_object, ...
              pts(:,1), pts(:,2), pts(:,3), ...
              '.r', 'MarkerSize', 7, ...
              'Tag', 'amode');
    end
    dcm_obj.Enable='off';

end