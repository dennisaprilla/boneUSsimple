function varargout = defineacs_tibia(varargin)
% DEFINEACS_TIBIA MATLAB code for defineacs_tibia.fig
%      DEFINEACS_TIBIA, by itself, creates a new DEFINEACS_TIBIA or raises the existing
%      singleton*.
%
%      H = DEFINEACS_TIBIA returns the handle to a new DEFINEACS_TIBIA or the handle to
%      the existing singleton*.
%
%      DEFINEACS_TIBIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFINEACS_TIBIA.M with the given input arguments.
%
%      DEFINEACS_TIBIA('Property','Value',...) creates a new DEFINEACS_TIBIA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before defineacs_tibia_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to defineacs_tibia_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help defineacs_tibia

% Last Modified by GUIDE v2.5 20-Apr-2021 14:12:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @defineacs_tibia_OpeningFcn, ...
                   'gui_OutputFcn',  @defineacs_tibia_OutputFcn, ...
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


% --- Executes just before defineacs_tibia is made visible.
function defineacs_tibia_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to defineacs_tibia (see VARARGIN)

% include several paths
addpath(genpath(strcat(pwd,'/functions/display_functions/')));
addpath(genpath(strcat(pwd,'/functions/geometry/')));

% Choose default command line output for defineacs_tibia
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes defineacs_tibia wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = defineacs_tibia_OutputFcn(hObject, eventdata, handles) 
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
    tibiaBone   = stlread(fullfile(path,file));
    
    % center the STL
    tibiaBone_centroid = mean(tibiaBone.Points, 1);    
    tibiaBone = bsxfun(@minus, tibiaBone.Points, tibiaBone_centroid);
    
    % display the bone
    plot3( handles.axes1, ...
           tibiaBone(:,1), ...
           tibiaBone(:,2), ...
           tibiaBone(:,3), ...
           '.', 'Color', [0.7 0.7 0.7], ...
           'MarkerSize', 0.1, ...
           'Tag', 'plot_bone');
    xlabel('X'); ylabel('Y'); zlabel('Z');    
    grid(handles.axes1, 'on');
    axis(handles.axes1, 'equal');
    hold(handles.axes1, 'on');
    
    % calculate stl bone size to specify the max-min and steps for all of
    % the sliders to make sure this toolbox as general as possible.
    maxmin = [max(tibiaBone,[],1); min(tibiaBone,[],1)];
    size = abs(diff(maxmin, 1, 1));    
    
    % compute and shows the principal component of the bone pointcloud
    pca_coeff = pca(tibiaBone);    
    display_axis(handles.axes1, [0,0,0], pca_coeff, size(3)/10, 'Tag', "plot_axisPCA");
    
    % define coronal plane and obtain points that intersect the plane
    transversalplane_normal = pca_coeff(:,1);
    transversalplane_coefficient = [transversalplane_normal; 0];    
    projection_transversalIntersection = find3dintersection(tibiaBone, transversalplane_coefficient, 0.0005);
    
    % display points that intersect the coronal plane
    plot3( handles.axes1, ...
           projection_transversalIntersection(:,1), ...
           projection_transversalIntersection(:,2), ...
           projection_transversalIntersection(:,3), ...
           '.b', 'MarkerSize', 7, ...
           'Tag', 'plot_transversalIntersection3d');       
       
    % contruct transformation from point in 3d plane to 2d image
    T_pca = [pca_coeff, [0 0 0]'; 0 0 0 1];
    projection_in2d = homogeneous2cartesian( inverseHMat(T_pca) * cartesian2homogeneous(projection_transversalIntersection) );
    
    % display 3d points that intersects coronal plane in 2d image
    delete(findobj('Tag', 'plot_transversalIntersection'));
    plot( handles.axes2, ...
          projection_in2d(:,2), ...
          projection_in2d(:,3), ...
          '.b', 'Tag', 'plot_transversalIntersection2d');
    grid(handles.axes2, 'on');
    axis(handles.axes2, 'equal');
    hold(handles.axes2, 'on');
    
    % set max min and value for epicondyle slider that max min point to
    % plane distance to coronal plane
    distance_pointplane = distancePoint2Plane(tibiaBone, transversalplane_coefficient);
    maxmin_distance = [max(distance_pointplane), min(distance_pointplane)];  
    
    % set the epicondyle sldiers
    set(handles.condyle_slider_t, 'max', maxmin(1,3));
    set(handles.condyle_slider_t, 'min', maxmin(2,3));
    set(handles.condyle_slider_t, 'value', maxmin(2,3) + size(3)/2 ); 
    set(handles.condyle_slider_t, 'SliderStep', (maxmin(1,3)-maxmin(2,3))./ [200, 20] );
    
    % fit an ellipse to the point cloud
    ellipse_struct = ellipseFit( projection_in2d(:,2), projection_in2d(:,3));
    
    % display the estimated ellipse
    display_ellipse(handles.axes2, ellipse_struct, 'Tag', "plot_ellipse")
    
    % store several variables globally so it can be used in another function
    handles.tibiaBone = tibiaBone;
    handles.tibiaBone_centroid = tibiaBone_centroid;
    handles.pca_coeff = pca_coeff;
    handles.T_pca = T_pca;
    handles.projection_in2d = projection_in2d;
    
end

% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on slider movement.
function condyle_slider_t_Callback(hObject, eventdata, handles)
% hObject    handle to condyle_slider_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% obtain pca coefficient from global variable
pca_coeff = handles.pca_coeff;
tibiaBone = handles.tibiaBone;
T_pca = handles.T_pca;

% obtain translation value for coronal plane from slider
transversalplane_translation = get(hObject,'Value');

% define coronal plane and obtain points that intersect the plane
transversalplane_normal = pca_coeff(:,1);
transversalplane_coefficient = [transversalplane_normal; transversalplane_translation];
projection_transversalIntersection = find3dintersection(tibiaBone, transversalplane_coefficient, 0.0005);

% display points that intersect the coronal plane
delete(findobj('Tag', 'plot_transversalIntersection3d'));
plot3( handles.axes1, ...
       projection_transversalIntersection(:,1), ...
       projection_transversalIntersection(:,2), ...
       projection_transversalIntersection(:,3), ...
       '.b', 'MarkerSize', 7, ...
       'Tag', 'plot_transversalIntersection3d');

projection_in2d = homogeneous2cartesian( inverseHMat(T_pca) * cartesian2homogeneous(projection_transversalIntersection) );

% display 3d points that intersects coronal plane in 2d image
delete(findobj('Tag', 'plot_transversalIntersection2d'));
plot( handles.axes2, ...
      projection_in2d(:,2), ...
      projection_in2d(:,3), ...
      '.b', 'Tag', 'plot_transversalIntersection2d');
grid(handles.axes2, 'on');
axis(handles.axes2, 'equal');
hold(handles.axes2, 'on');
    
% fit an ellipse to the point cloud
ellipse_struct = ellipseFit( projection_in2d(:,2), projection_in2d(:,3));

% display the estimated ellipse
delete(findobj('Tag', 'plot_ellipse'));
display_ellipse(handles.axes2, ellipse_struct, 'Tag', "plot_ellipse");

handles.projection_in2d  = projection_in2d;
handles.ellipse_struct   = ellipse_struct;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function condyle_slider_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to condyle_slider_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in main_button_obtainsave.
function main_button_obtainsave_Callback(hObject, eventdata, handles)
% hObject    handle to main_button_obtainsave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% obtain severaln global variables that is needed to obtain acs
ellipse_struct = handles.ellipse_struct;
pca_coeff      = handles.pca_coeff;
T_pca          = handles.T_pca;
bone           = handles.tibiaBone;
bone_centroid  = handles.tibiaBone_centroid;

% obtain ellipse origin
ellipse_origin = [ ellipse_struct.X0; ellipse_struct.Y0];
% obtian ellipse rotation, each column of this R can be considered as
% principal axis.
ellipse_rotation = [ cos(ellipse_struct.phi) sin(ellipse_struct.phi); ...
                     -sin(ellipse_struct.phi) cos(ellipse_struct.phi) ];

% add 0 to first dimension, so it become 3d and could be transformed using
% T_pca ( as we previously transform from 3d to 2d and only consider second 
% and third dimension)
ellipse_origin = [ 0, ellipse_origin'];
ellipse_rotation = [ zeros(2, 1), ellipse_rotation'];

% there is no translation in T_pca, if we returned from 2d image to 3D, we
% don't have any information about translation.. so we construct that
transversalplane_translation = get(handles.condyle_slider_t,'Value');
T_translate = [ eye(3),  transversalplane_translation * pca_coeff(:,1); 0 0 0 1];

% return back from 2d to 3d, but with translation information
acs_origin = homogeneous2cartesian( T_translate * T_pca * cartesian2homogeneous(ellipse_origin) );

% for axis, we don't need translation, we just need to know the direction
axisXY_3d = homogeneous2cartesian( T_pca * cartesian2homogeneous(ellipse_rotation) );

% obtain acs
acs_x = axisXY_3d(1,:);
acs_y = axisXY_3d(2,:);
acs_z = cross(acs_x, acs_y);
acs_axes = [acs_x; acs_y; acs_z]';


% display the acs for sanity check.. dont bother about this maxmin & size
% variables, it is just for axis scaling display..
maxmin = [max(bone,[],1); min(bone,[],1)];
size   = abs(diff(maxmin, 1, 1));   
display_axis(handles.axes1, acs_origin, acs_axes, size(3)/10, 'Tag', "plot_tibiaacs");

% save all the variables that we need to conduct registration simulation
filename = sprintf('tibiaacs_%s.mat', datestr(now,'mm-dd-yyyy_HH-MM'));
path_name = strcat(pwd,'/data/bone_acs/', filename);
save(path_name, 'acs_origin', 'acs_axes', 'bone_centroid', 'ellipse_struct');
