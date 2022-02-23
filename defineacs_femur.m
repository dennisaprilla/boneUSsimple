function varargout = defineacs_femur(varargin)
% DEFINEACS_FEMUR MATLAB code for defineacs_femur.fig
%      DEFINEACS_FEMUR, by itself, creates a new DEFINEACS_FEMUR or raises the existing
%      singleton*.
%
%      H = DEFINEACS_FEMUR returns the handle to a new DEFINEACS_FEMUR or the handle to
%      the existing singleton*.
%
%      DEFINEACS_FEMUR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFINEACS_FEMUR.M with the given input arguments.
%
%      DEFINEACS_FEMUR('Property','Value',...) creates a new DEFINEACS_FEMUR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before defineacs_femur_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to defineacs_femur_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help defineacs_femur

% Last Modified by GUIDE v2.5 20-Apr-2021 12:12:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @defineacs_femur_OpeningFcn, ...
                   'gui_OutputFcn',  @defineacs_femur_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before defineacs_femur is made visible.
function defineacs_femur_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to defineacs_femur (see VARARGIN)

% include several paths
addpath(genpath(strcat(pwd,'/functions/display_functions/')));
addpath(genpath(strcat(pwd,'/functions/geometry/')));

% Choose default command line output for defineacs_femur
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes defineacs_femur wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = defineacs_femur_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function main_edit_filelocation_Callback(hObject, eventdata, handles)
% hObject    handle to main_edit_filelocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of main_edit_filelocation as text
%        str2double(get(hObject,'String')) returns contents of main_edit_filelocation as a double


% --- Executes during object creation, after setting all properties.
function main_edit_filelocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_edit_filelocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in main_button_browse.
function main_button_browse_Callback(hObject, eventdata, handles)
% hObject    handle to main_button_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% open browser dialog
[file,path] = uigetfile('*.stl');

% check whether user click cancel or select
if isequal(file,0)
   disp('User selected Cancel');
else
   disp(['User selected ', fullfile(path,file)]);
   
   % set the string to main_edit_filelocation
   set(handles.main_edit_filelocation, 'String', fullfile(path,file));
   
   % load STL file   
    femurBone   = stlread(fullfile(path,file));
    
    % center the STL
    femurBone_centroid = mean(femurBone.Points, 1);    
    femurBone = bsxfun(@minus, femurBone.Points, femurBone_centroid);
    
    % display the bone
    plot3( handles.axes1, ...
           femurBone(:,1), ...
           femurBone(:,2), ...
           femurBone(:,3), ...
           '.', 'Color', [0.7 0.7 0.7], ...
           'MarkerSize', 0.1, ...
           'Tag', 'plot_bone');
    xlabel('X'); ylabel('Y'); zlabel('Z');    
    grid(handles.axes1, 'on');
    axis(handles.axes1, 'equal');
    hold(handles.axes1, 'on');
    
    % calculate stl bone size to specify the max-min and steps for all of
    % the sliders to make sure this toolbox as general as possible.
    maxmin = [max(femurBone,[],1); min(femurBone,[],1)];
    size = abs(diff(maxmin, 1, 1));    
    
    % set max min of all the sliders and value of all the edit text
    % femoral head sphere_x sliders
    set(handles.headsphere_slider_x, 'max', maxmin(1,1));
    set(handles.headsphere_slider_x, 'min', maxmin(2,1));
    set(handles.headsphere_slider_x, 'value', maxmin(2,1)+size(1)/2);
    % femoral head sphere_y sliders
    set(handles.headsphere_slider_y, 'max', maxmin(1,2));
    set(handles.headsphere_slider_y, 'min', maxmin(2,2));
    set(handles.headsphere_slider_y, 'value', maxmin(2,2)+size(2)/2);
    % femoral head sphere_z sliders
    set(handles.headsphere_slider_z, 'max', maxmin(1,3));
    set(handles.headsphere_slider_z, 'min', maxmin(2,3));
    set(handles.headsphere_slider_z, 'value', maxmin(2,3)+size(3)/2);
    % femoral head sphere_r sliders
    set(handles.headsphere_slider_r, 'max', size(3)/10);
    set(handles.headsphere_slider_r, 'min', size(3)/20);
    set(handles.headsphere_slider_r, 'value', size(3)/15); 
    % set every edits    
    set(handles.headsphere_edit_x, 'String', num2str(get(handles.headsphere_slider_x, 'Value')));
    set(handles.headsphere_edit_y, 'String', num2str(get(handles.headsphere_slider_y, 'Value')));
    set(handles.headsphere_edit_z, 'String', num2str(get(handles.headsphere_slider_z, 'Value')));
    set(handles.headsphere_edit_r, 'String', num2str(get(handles.headsphere_slider_r, 'Value')));
    
    % display hipsphere
    delete(findobj('Tag', 'plot_sphere'));
    sphere_center = [ get(handles.headsphere_slider_x, 'Value'), ...
                      get(handles.headsphere_slider_y, 'Value'), ...
                      get(handles.headsphere_slider_z, 'Value') ];
	sphere_radius = get(handles.headsphere_slider_r, 'Value');
    display_sphere(handles.axes1, sphere_center, sphere_radius, 'Tag', "plot_sphere");
    
    % compute and shows the principal component of the bone pointcloud
    pca_coeff = pca(femurBone);    
    display_axis(handles.axes1, [0,0,0], pca_coeff, size(3)/10, 'Tag', "plot_axisPCA");
    
    % define coronal plane and obtain points that intersect the plane
    coronalplane_normal = pca_coeff(:,3);
    coronalplane_coefficient = [coronalplane_normal; 0];    
    projection_coronalIntersection = find3dintersection(femurBone, coronalplane_coefficient, 0.0005);
    
    % display points that intersect the coronal plane
    plot3( handles.axes1, ...
           projection_coronalIntersection(:,1), ...
           projection_coronalIntersection(:,2), ...
           projection_coronalIntersection(:,3), ...
           '.b', 'MarkerSize', 7, ...
           'Tag', 'plot_coronalIntersection3d');       

    % obtain only distal part of femur, because to estimate center of
    % epicondyle we only need distal part. remember, we also already translate
    % our bone model around the origin, so negative z is distal part
    femurBone_distal = femurBone(femurBone(:,3)<0, :);
    projection_coronalIntersection = find3dintersection(femurBone_distal, coronalplane_coefficient, 0.00025);
       
    % contruct transformation from point in 3d plane to 2d image
    T_3d2d = [pca_coeff, [0 0 0]'; 0 0 0 1];
    projection_in2d = homogeneous2cartesian( inverseHMat(T_3d2d) * cartesian2homogeneous(projection_coronalIntersection) );
    
    % display 3d points that intersects coronal plane in 2d image
    delete(findobj('Tag', 'plot_coronalIntersection'));
    plot( handles.axes2, ...
          projection_in2d(:,1), ...
          projection_in2d(:,2), ...
          '.b', 'Tag', 'plot_coronalIntersection2d');
    grid(handles.axes2, 'on');
    axis(handles.axes2, 'equal');
    
    % set max min and value for epicondyle slider that max min point to
    % plane distance to coronal plane
    distance_pointplane = distancePoint2Plane(femurBone, coronalplane_coefficient);
    maxmin_distance = [max(distance_pointplane), min(distance_pointplane)];    
    % set the epicondyle sldiers
    set(handles.epicondyle_slider_t, 'max', maxmin_distance(1));
    set(handles.epicondyle_slider_t, 'min', maxmin_distance(2));
    set(handles.epicondyle_slider_t, 'value', maxmin(2) + abs(diff(maxmin_distance))/2 ); 
    set(handles.epicondyle_slider_t, 'SliderStep', (maxmin_distance(1)-maxmin_distance(2)) ./ [200, 20] );
    
    % store several variables globally so it can be used in another function
    handles.femurBone = femurBone;
    handles.femurBone_centroid = femurBone_centroid;
    handles.pca_coeff = pca_coeff;
    handles.projection_in2d = projection_in2d;
    
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on slider movement.
function headsphere_slider_x_Callback(hObject, eventdata, handles)
% hObject    handle to headsphere_slider_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.headsphere_edit_x, 'String', num2str(get(hObject, 'Value')));

% display hipsphere
delete(findobj('Tag', 'plot_sphere'));
sphere_center = [ get(handles.headsphere_slider_x, 'Value'), ...
                  get(handles.headsphere_slider_y, 'Value'), ...
                  get(handles.headsphere_slider_z, 'Value') ];
sphere_radius = get(handles.headsphere_slider_r, 'Value');
display_sphere(handles.axes1, sphere_center, sphere_radius, 'Tag', "plot_sphere");


% --- Executes during object creation, after setting all properties.
function headsphere_slider_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headsphere_slider_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function headsphere_slider_y_Callback(hObject, eventdata, handles)
% hObject    handle to headsphere_slider_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.headsphere_edit_y, 'String', num2str(get(hObject, 'Value')));

% display hipsphere
delete(findobj('Tag', 'plot_sphere'));
sphere_center = [ get(handles.headsphere_slider_x, 'Value'), ...
                  get(handles.headsphere_slider_y, 'Value'), ...
                  get(handles.headsphere_slider_z, 'Value') ];
sphere_radius = get(handles.headsphere_slider_r, 'Value');
display_sphere(handles.axes1, sphere_center, sphere_radius, 'Tag', "plot_sphere");


% --- Executes during object creation, after setting all properties.
function headsphere_slider_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headsphere_slider_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function headsphere_slider_z_Callback(hObject, eventdata, handles)
% hObject    handle to headsphere_slider_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.headsphere_edit_z, 'String', num2str(get(hObject, 'Value')));

% display hipsphere
delete(findobj('Tag', 'plot_sphere'));
sphere_center = [ get(handles.headsphere_slider_x, 'Value'), ...
                  get(handles.headsphere_slider_y, 'Value'), ...
                  get(handles.headsphere_slider_z, 'Value') ];
sphere_radius = get(handles.headsphere_slider_r, 'Value');
display_sphere(handles.axes1, sphere_center, sphere_radius, 'Tag', "plot_sphere");


% --- Executes during object creation, after setting all properties.
function headsphere_slider_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headsphere_slider_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function headsphere_slider_r_Callback(hObject, eventdata, handles)
% hObject    handle to headsphere_slider_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

set(handles.headsphere_edit_r, 'String', num2str(get(hObject, 'Value')));

% display hipsphere
delete(findobj('Tag', 'plot_sphere'));
sphere_center = [ get(handles.headsphere_slider_x, 'Value'), ...
                  get(handles.headsphere_slider_y, 'Value'), ...
                  get(handles.headsphere_slider_z, 'Value') ];
sphere_radius = get(handles.headsphere_slider_r, 'Value');
display_sphere(handles.axes1, sphere_center, sphere_radius, 'Tag', "plot_sphere");


% --- Executes during object creation, after setting all properties.
function headsphere_slider_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headsphere_slider_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function headsphere_edit_x_Callback(hObject, eventdata, handles)
% hObject    handle to headsphere_edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of headsphere_edit_x as text
%        str2double(get(hObject,'String')) returns contents of headsphere_edit_x as a double



% --- Executes during object creation, after setting all properties.
function headsphere_edit_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headsphere_edit_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function headsphere_edit_y_Callback(hObject, eventdata, handles)
% hObject    handle to headsphere_edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of headsphere_edit_y as text
%        str2double(get(hObject,'String')) returns contents of headsphere_edit_y as a double



% --- Executes during object creation, after setting all properties.
function headsphere_edit_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headsphere_edit_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function headsphere_edit_z_Callback(hObject, eventdata, handles)
% hObject    handle to headsphere_edit_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of headsphere_edit_z as text
%        str2double(get(hObject,'String')) returns contents of headsphere_edit_z as a double



% --- Executes during object creation, after setting all properties.
function headsphere_edit_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headsphere_edit_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function headsphere_edit_r_Callback(hObject, eventdata, handles)
% hObject    handle to headsphere_edit_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of headsphere_edit_r as text
%        str2double(get(hObject,'String')) returns contents of headsphere_edit_r as a double



% --- Executes during object creation, after setting all properties.
function headsphere_edit_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to headsphere_edit_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on slider movement.
function epicondyle_slider_t_Callback(hObject, eventdata, handles)
% hObject    handle to epicondyle_slider_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% obtain pca coefficient from global variable
pca_coeff = handles.pca_coeff;
femurBone = handles.femurBone;

% obtain translation value for coronal plane from slider
coronalplane_translation = get(hObject,'Value');

% define coronal plane and obtain points that intersect the plane
coronalplane_normal = pca_coeff(:,3);
coronalplane_coefficient = [coronalplane_normal; coronalplane_translation];
projection_coronalIntersection = find3dintersection(femurBone, coronalplane_coefficient, 0.0005);

% display points that intersect the coronal plane
delete(findobj('Tag', 'plot_coronalIntersection3d'));
plot3( handles.axes1, ...
       projection_coronalIntersection(:,1), ...
       projection_coronalIntersection(:,2), ...
       projection_coronalIntersection(:,3), ...
       '.b', 'MarkerSize', 7, ...
       'Tag', 'plot_coronalIntersection3d');


% obtain only distal part of femur, because to estimate center of
% epicondyle we only need distal part. remember, we also already translate
% our bone model around the origin, so negative z is distal part
femurBone_distal = femurBone(femurBone(:,3)<0, :);
projection_coronalIntersection = find3dintersection(femurBone_distal, coronalplane_coefficient, 0.0005);

% contruct transformation from point in 3d plane to 2d image
T_pca = [pca_coeff, coronalplane_translation*pca_coeff(:,3); 0 0 0 1];
projection_in2d = homogeneous2cartesian( inverseHMat(T_pca) * cartesian2homogeneous(projection_coronalIntersection) );

% display 3d points that intersects coronal plane in 2d image
delete(findobj('Tag', 'plot_coronalIntersection2d'));
plot( handles.axes2, ...
      projection_in2d(:,1), ...
      projection_in2d(:,2), ...
      '.b', 'Tag', 'plot_coronalIntersection2d');
grid(handles.axes2, 'on');
axis(handles.axes2, 'equal');
hold(handles.axes2, 'on');

handles.projection_in2d = projection_in2d;
handles.T_pca = T_pca;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function epicondyle_slider_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epicondyle_slider_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in epicondyle_button_select.
function epicondyle_button_select_Callback(hObject, eventdata, handles)
% hObject    handle to epicondyle_button_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% obtain epicondyle projection point on the coronal plane from global
% variable
projection_in2d = handles.projection_in2d;
% obtain T_pca from global variable so we can return back to 3d coordinate
% and shows the result there
T_pca = handles.T_pca;

% create new figure for better selection (actually, i need to do this
% because the function i used can't work with axes inside our existing GUI
% window, idk why; built in matlab function 'brush' also inconvinient since
% it can't save the seleted points automatically)
figure_select = figure;
figure_select.WindowState  = 'maximized';
axes_select = axes('Parent', figure_select);
plot( axes_select, ...
      projection_in2d(:,1), ...
      projection_in2d(:,2), ...
      '.b', 'Tag', 'plot_coronalIntersection2d');
grid(axes_select, 'on');
axis(axes_select, 'equal');

% provide variable to contain circle parameters. 
circle_parameters = zeros(2, 3);
%we would like to estimate 2 circles (medial and lateral), so we loop this estimation 2 times
for i=1:2
    
    % select points from matlab axes
    [pointslist, xselect, yselect] = selectdata('Axes', axes_select, 'SelectionMode', 'Lasso');
    hold(gca, 'on');
    
    % this is superweird, in the second loop, pointlist become a cell. i
    % suspect it is because i display circle in the same axis. but who tf
    % cares, let's avoid this in the very easy way
    if(iscell(pointslist))
        pointslist = pointslist{2};
    end

    % select the selected points from projection_in2d
    selected_points = projection_in2d(pointslist,:);
    
    % fit a circle from selected points
    circle_parameters(i,:) = circleFit(selected_points(:, 1:2));

    % display the circle center for sanity check
    center = circle_parameters(i, 1:2);
    radius = circle_parameters(i, 3);
    
    % display to current window
    display_circle(axes_select, center, radius, 'Tag', "plot_circle");
    % display to our GUI window
    display_circle(handles.axes2, center, radius, 'Tag', "plot_circle");

end

% display center point to our GUI window, somehow this motherfucking matlab
% prevent me to display center point inside the loop, inside the
% display_circle.
plot( handles.axes2, circle_parameters(:,1), circle_parameters(:,2), ...
      'or', 'MarkerFaceColor', 'r', 'Tag', 'plot_circle');

% prevent the immidiate close, so the user know the result first
pause(1);

% close our figure
close(figure_select);

% add 0 third dimension, so it can be transformed by T_pca
circlecenter_2d = [ circle_parameters(:,1:2), zeros(2, 1) ]; 

% change coordinate system from 2d image to 3d space using pca cooeficient
circlecenter_3d = homogeneous2cartesian( T_pca * cartesian2homogeneous(circlecenter_2d) );

% display the circle center in 3D for sanity check
display_sphere(handles.axes1, circlecenter_3d(1,:), circle_parameters(1,3), 'Tag', "plot_epicondylesphere");
display_sphere(handles.axes1, circlecenter_3d(2,:), circle_parameters(2,3), 'Tag', "plot_epicondylesphere");

% save our two circle parameters to global variable
handles.circle_parameters = circle_parameters;

% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in main_button_obtainsave.
function main_button_obtainsave_Callback(hObject, eventdata, handles)
% hObject    handle to main_button_obtainsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% obtain severaln global variables that is needed to obtain acs
circle_parameters  = handles.circle_parameters;
T_pca              = handles.T_pca;
bone               = handles.femurBone;
bone_centroid      = handles.femurBone_centroid;
femoralhead_sphere = [ get(handles.headsphere_slider_x, 'Value'), ...
                       get(handles.headsphere_slider_y, 'Value'), ...
                       get(handles.headsphere_slider_z, 'Value'), ...
                       get(handles.headsphere_slider_r, 'Value') ];
                   
                   
% add 0 third dimension, so it can be transformed by T_pca
circlecenter_2d = [ circle_parameters(:,1:2), zeros(2, 1) ]; 

% change coordinate system from 2d image to 3d space using pca cooeficient
circlecenter_3d = homogeneous2cartesian( T_pca * cartesian2homogeneous(circlecenter_2d) );
epicondyle_spheres = [circlecenter_3d, circlecenter_2d(:, 3)];

% calculate middle point and for the origin
acs_origin = sum(circlecenter_3d, 1)./2;

% calculate normalized vector pointing laterally
acs_z = ( femoralhead_sphere(1:3) - acs_origin ) / ...
          norm( femoralhead_sphere(1:3) - acs_origin );
condyle_axisvector = ( epicondyle_spheres(2,1:3) - epicondyle_spheres(1,1:3) ) / ...
                        norm( epicondyle_spheres(2,1:3) - epicondyle_spheres(1,1:3) );

% if i directly use condyle axis as acs_x, it is not perpendicular to the
% acs_z, so i need to project acs_x to a 'transverplane' that is
% perpendicular to acs_z (renault et. al);
point = condyle_axisvector;
plane_normal = acs_z';
plane_coefficient = [acs_z, 0]';
pointprojection_inplane = point - (point * plane_normal - plane_coefficient(4)) * plane_normal';
acs_x = pointprojection_inplane ./ norm(pointprojection_inplane);
      
acs_y = - cross(acs_x, acs_z);
acs_axes = [acs_x; acs_y; acs_z]';

% display the acs for sanity check.. dont bother about this maxmin & size
% variables, it is just for axis scaling display..
maxmin = [max(bone,[],1); min(bone,[],1)];
size   = abs(diff(maxmin, 1, 1));   
display_axis(handles.axes1, acs_origin, acs_axes, size(3)/10, 'Tag', "plot_femuracs");

% save all the variables that we need to conduct registration simulation
filename = sprintf('femuracs_%s.mat', datestr(now,'mm-dd-yyyy_HH-MM'));
path_name = strcat(pwd,'/data/bone_acs/', filename);
save(path_name, 'acs_origin', 'acs_axes', 'bone_centroid', 'femoralhead_sphere', 'epicondyle_spheres');
