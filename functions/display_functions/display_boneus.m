function display_boneus(axes_object, bone, amode, bmode, varargin)

% default colors
colors = 'xyc';
downsample_display = 30;

% check the varargin
while ~isempty(varargin)
    switch lower(varargin{1})
        case 'prereg'
            preregistrationArea = varargin{2};
        case 'tag'
            tag = varargin{2};
        case 'colors'
            colors = varargin{2};
        case 'downsample'
            downsample_display = varargin{2};
        otherwise
            error(['Unexpected option: ' varargin{1}])
    end
    varargin(1:2) = [];
end

% i want default color of bone to be gray, but in matlab there is no char
% for gray, so i need to be improvised here
if (colors(1)=='x')
    bonecolor = [0.7 0.7 0.7];
else
    bonecolor = colors(1);
end

% display bone
bone_4display = downsample(bone, downsample_display);
plot3( axes_object, ...
       bone_4display(:,1), ...
       bone_4display(:,2), ...
       bone_4display(:,3), ...
       '.', 'Color', bonecolor, ...
       'MarkerSize', 0.1, ...
       'Tag', tag);   
grid(axes_object, 'on'); axis(axes_object, 'equal'); hold(axes_object, 'on');
xlabel('X'); ylabel('Y'); zlabel('Z');

% if user specified preregistration area, display
if exist('preregistrationArea')
    
    preregistrationArea_number = length(preregistrationArea);
    for i=1:preregistrationArea_number
        preregistrationArea_4display = downsample(preregistrationArea{i}, downsample_display);
        plot3( axes_object, ...
               preregistrationArea_4display(:,1), ...
               preregistrationArea_4display(:,2), ...
               preregistrationArea_4display(:,3), ...
               '.r', ...
               'MarkerSize', 0.1, ...
               'Tag', tag);  
    end
    
end

% display amode
plot3( axes_object, ...
       amode(:,1), ...
       amode(:,2), ...
       amode(:,3), ...
       'o', 'Color', colors(2), ...
       'MarkerFaceColor', colors(2), ...
       'Tag', tag);

% display bmode
plot3( axes_object, ...
       bmode(:,1), ...
       bmode(:,2), ...
       bmode(:,3), ...
       'o', 'Color', colors(3), ...
       'MarkerFaceColor', colors(3), ...
       'Tag', tag);

end

