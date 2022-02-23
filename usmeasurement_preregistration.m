function varargout = usmeasurement_preregistration(varargin)
% USMEASUREMENT_PREREGISTRATION MATLAB code for usmeasurement_preregistration.fig
%      USMEASUREMENT_PREREGISTRATION, by itself, creates a new USMEASUREMENT_PREREGISTRATION or raises the existing
%      singleton*.
%
%      H = USMEASUREMENT_PREREGISTRATION returns the handle to a new USMEASUREMENT_PREREGISTRATION or the handle to
%      the existing singleton*.
%
%      USMEASUREMENT_PREREGISTRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USMEASUREMENT_PREREGISTRATION.M with the given input arguments.
%
%      USMEASUREMENT_PREREGISTRATION('Property','Value',...) creates a new USMEASUREMENT_PREREGISTRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before usmeasurement_preregistration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to usmeasurement_preregistration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help usmeasurement_preregistration

% Last Modified by GUIDE v2.5 28-May-2021 16:54:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @usmeasurement_preregistration_OpeningFcn, ...
                   'gui_OutputFcn',  @usmeasurement_preregistration_OutputFcn, ...
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


% --- Executes just before usmeasurement_preregistration is made visible.
function usmeasurement_preregistration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to usmeasurement_preregistration (see VARARGIN)

path_name = strcat(pwd,'/data/temp/temp_mat.mat');
load(path_name);

handles.bone = bone;
bone = handles.bone;

current_selection = 0;

% display the bone after centered
delete(findobj('Tag', 'plot_bone'));
plot3( handles.axes1, ...
       bone(:,1), ...
       bone(:,2), ...
       bone(:,3), ...
       '.', 'Color', [0.7 0.7 0.7], ...
       'Tag', 'plot_bone');
xlabel('X'); ylabel('Y'); zlabel('Z');    
grid(handles.axes1, 'on');
axis(handles.axes1, 'equal');
hold(handles.axes1, 'on');

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));
% set max min value of sphere slider
set(handles.slider_size, 'max', size(3)/10);
set(handles.slider_size, 'min', size(3)/100);
set(handles.slider_size, 'value', size(3)/50);
% set the text to inform the user
set(handles.edit_size, 'string', num2str(size(3)/50));

% store several variables to global
handles.bone = bone;
handles.current_selection = current_selection;
handles.preregistrationArea_number = preregistrationArea_number;

% create empty cell array in global, will be used by done-button
handles.preregistrationSphere = {};
handles.preregistrationArea = {};

% Choose default command line output for usmeasurement_preregistration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes usmeasurement_preregistration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = usmeasurement_preregistration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_size_Callback(hObject, eventdata, handles)
% hObject    handle to slider_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% obtain several variables from global
sphere_centroid = handles.sphere_centroid;
bone = handles.bone;

% obtain sphere radius from slider
sphere_radius = get(handles.slider_size, 'Value');

% set the edit text to inform the user
set(handles.edit_size, 'string', num2str(sphere_radius));

% display sphere for registration area
delete(findobj('Tag', 'plot_sphere'));
display_sphere( handles.axes1, ...
                sphere_centroid, ...
                sphere_radius, ...
                'Tag', "plot_sphere");

% calculate distance for every points and select those inside the sphere
distance = sqrt( sum( bsxfun(@minus, bone, sphere_centroid).^2 , 2 ) );
roi = bone( distance < sphere_radius, : );

% plot the roi for sanity check
delete(findobj('Tag', 'plot_roi'));
plot3( handles.axes1, ...
       roi(:,1), roi(:,2), roi(:,3), ...
       '.r', 'MarkerSize', 0.1, ...
       'Tag', 'plot_roi');

% store several variables to global
handles.roi = roi;


% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in button_point2locate.
function button_point2locate_Callback(hObject, eventdata, handles)
% hObject    handle to button_point2locate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% obtain several variables from global
bone = handles.bone;

% function to allow user click a point in axes.
sphere_centroid = getpts3d(handles.figure1, handles.axes1, 1);
% get the radius size from the slider
sphere_radius   = get(handles.slider_size, 'Value');

% display sphere for registration area
delete(findobj('Tag', 'plot_sphere'));
display_sphere( handles.axes1, ...
                sphere_centroid, ...
                sphere_radius, ...
                'Tag', "plot_sphere");

% calculate distance for every points and select those inside the sphere
distance = sqrt( sum( bsxfun(@minus, bone, sphere_centroid).^2 , 2 ) );
roi = bone( distance < sphere_radius, : );

% plot the roi for sanity check
delete(findobj('Tag', 'plot_roi'));
plot3( handles.axes1, ...
       roi(:,1), roi(:,2), roi(:,3), ...
       '.r', 'MarkerSize', 0.1, ...
       'Tag', 'plot_roi');

% after selecting roi, we enable done-button and disable locate-button
set(handles.button_done, 'Enable', 'on');
   
% store several variable to global
handles.sphere_centroid = sphere_centroid;
handles.roi = roi;

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in button_done.
function button_done_Callback(hObject, eventdata, handles)
% hObject    handle to button_done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% obtain several variables from global
preregistrationArea_number = handles.preregistrationArea_number;
current_selection = handles.current_selection;
sphere_centroid = handles.sphere_centroid;
preregistrationSphere = handles.preregistrationSphere;
preregistrationArea = handles.preregistrationArea;
bone = handles.bone;
roi  = handles.roi;

% obtain radius value from slider
sphere_radius = get(handles.slider_size, 'Value');

% store values for the output of this GUI program
preregistrationSphere{current_selection+1} = [sphere_centroid, sphere_radius];
preregistrationArea{current_selection+1} = roi;

% delete all display...
delete(findobj('Tag', 'plot_sphere'));
delete(findobj('Tag', 'plot_roi'));

% ...and plot new display with new tag
tag = sprintf("plot_preregistration_areasphere%d", current_selection+1);
display_sphere( handles.axes1, ...
                sphere_centroid, ...
                sphere_radius, ...
                'Tag', tag);
plot3( handles.axes1, ...
       roi(:,1), roi(:,2), roi(:,3), ...
       '.r', 'MarkerSize', 0.1, ...
       'Tag', tag);
   
current_selection = current_selection+1;

if (current_selection < preregistrationArea_number)
    
    % change the text so user know what number he is right now
    string = sprintf("%d / 3 Areas Selection", current_selection);
    set(handles.text_selectionNumber, 'String', string);    

    % after selecting roi, we enable done-button and disable locate-button
    set(handles.button_done, 'Enable', 'off');
    set(handles.button_point2locate, 'Enable', 'on');

    % store several variables
    handles.current_selection = current_selection;
    handles.preregistrationSphere = preregistrationSphere;
    handles.preregistrationArea = preregistrationArea;

    % Update handles structure
    guidata(hObject, handles);
    
else
    % change the structure of preregistrationSphere, because i already
    % have the program with this particular structure, so we need to follow
    preregistrationSphere = [ preregistrationSphere{1}; ...
                              preregistrationSphere{2}; ...
                              preregistrationSphere{3} ];                               
    
    % create a temprorary mat file to be read by other gui
    filename = sprintf('amode_areasphere_%s.mat', datestr(now,'mm-dd-yyyy_HH-MM'));
    path_name = strcat(pwd,'/data/pointclouds/', filename);    
    save(path_name, 'preregistrationSphere', 'preregistrationArea');
    
    % give notification for user
    string = sprintf("Selection Complete! Saving...");
    set(handles.text_selectionNumber, 'String', string);
    
    % disable all button
    set(handles.button_done, 'Enable', 'off');
    set(handles.slider_size, 'Enable', 'off');
    set(handles.button_point2locate, 'Enable', 'off');
    
    % wait so everything is not happening to fast and confusing user
    pause(3);
    
    % close figure
    close;
    
end



function edit_size_Callback(hObject, eventdata, handles)
% hObject    handle to edit_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_size as text
%        str2double(get(hObject,'String')) returns contents of edit_size as a double


% --- Executes during object creation, after setting all properties.
function edit_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
