function varargout = usmeasurement_bb(varargin)
% USMEASUREMENT_BB MATLAB code for usmeasurement_bb.fig
%      USMEASUREMENT_BB, by itself, creates a new USMEASUREMENT_BB or raises the existing
%      singleton*.
%
%      H = USMEASUREMENT_BB returns the handle to a new USMEASUREMENT_BB or the handle to
%      the existing singleton*.
%
%      USMEASUREMENT_BB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USMEASUREMENT_BB.M with the given input arguments.
%
%      USMEASUREMENT_BB('Property','Value',...) creates a new USMEASUREMENT_BB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before usmeasurement_bb_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to usmeasurement_bb_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help usmeasurement_bb

% Last Modified by GUIDE v2.5 25-May-2021 16:34:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @usmeasurement_bb_OpeningFcn, ...
                   'gui_OutputFcn',  @usmeasurement_bb_OutputFcn, ...
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


% --- Executes just before usmeasurement_bb is made visible.
function usmeasurement_bb_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to usmeasurement_bb (see VARARGIN)

% include several paths
addpath(genpath(strcat(pwd,'/functions/display_functions/')));
addpath(genpath(strcat(pwd,'/functions/geometry/')));
addpath(genpath(strcat(pwd,'/functions/ultrasound_simulation/')));

% Choose default command line output for usmeasurement_bb
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes usmeasurement_bb wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = usmeasurement_bb_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function data_edit_bone_Callback(hObject, eventdata, handles)
% hObject    handle to data_edit_bone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data_edit_bone as text
%        str2double(get(hObject,'String')) returns contents of data_edit_bone as a double


% --- Executes during object creation, after setting all properties.
function data_edit_bone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_edit_bone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function data_edit_acs_Callback(hObject, eventdata, handles)
% hObject    handle to data_edit_acs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data_edit_acs as text
%        str2double(get(hObject,'String')) returns contents of data_edit_acs as a double


% --- Executes during object creation, after setting all properties.
function data_edit_acs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data_edit_acs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in data_button_browsebone.
function data_button_browsebone_Callback(hObject, eventdata, handles)
% hObject    handle to data_button_browsebone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% open browser dialog
[file,path] = uigetfile('*.stl');

% check whether user click cancel or select
if isequal(file,0)
    disp('User selected Cancel');
else
    disp(['User selected ', fullfile(path,file)]);
    
    % set the string to edit box
    set(handles.data_edit_bone, 'String', fullfile(path,file));
    
    % load STL file   
    boneSTL = stlread(fullfile(path,file));    
    
    % display the bone
    plot3( handles.axes1, ...
           boneSTL.Points(:,1), ...
           boneSTL.Points(:,2), ...
           boneSTL.Points(:,3), ...
           '.', 'Color', [0.7 0.7 0.7], ...
           'MarkerSize', 0.1, ...
           'Tag', 'plot_bone');
    xlabel('X'); ylabel('Y'); zlabel('Z');    
    grid(handles.axes1, 'on');
    axis(handles.axes1, 'equal');
    hold(handles.axes1, 'on');
    
    % save several things to global variable
    handles.boneSTL = boneSTL;
    
    % set acs button to be enable
    set(handles.data_button_browseacs, 'Enable', 'on');
   
end


% Update handles structure
guidata(hObject, handles);


function enable_allComponents(hObject, handles)

enable_distalComponents(hObject, handles);
enable_proximalComponents(hObject, handles);


function enable_proximalComponents(hObject, handles)
% obtain several variable from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get values from popup menu to get relative position
idx = get(handles.bmodeproximal_popupmenu_portion, 'Value');
if idx==1
    upperlower_proximal_bonepointcloud = [0 0.1];
elseif idx==2 
    upperlower_proximal_bonepointcloud = [0.1 0.2];
else
    upperlower_proximal_bonepointcloud = [0.2 0.3];
end

middle_proximal_bonepointcloud = ( upperlower_proximal_bonepointcloud(1) + upperlower_proximal_bonepointcloud(2) ) / 2;

% set max, min, values for sliders and edits
% tz slider and edits
set(handles.bmodeproximal_slider_tz, 'max',   maxmin(1,3)-size(3)*upperlower_proximal_bonepointcloud(1));
set(handles.bmodeproximal_slider_tz, 'min',   maxmin(1,3)-size(3)*upperlower_proximal_bonepointcloud(2));
set(handles.bmodeproximal_slider_tz, 'value', maxmin(1,3)-size(3)*middle_proximal_bonepointcloud);
set(handles.bmodeproximal_edit_tz, 'String', num2str(get(handles.bmodeproximal_slider_tz, 'Value')));
% tside slider and edits
set(handles.bmodeproximal_slider_tside, 'max', maxmin(1,1));
set(handles.bmodeproximal_slider_tside, 'min', maxmin(2,1));
set(handles.bmodeproximal_slider_tside, 'value', maxmin(2,1)+size(1)/2);
set(handles.bmodeproximal_edit_tside, 'String', num2str(get(handles.bmodeproximal_slider_tside, 'Value')));

% turn on all the neccesary components
set(handles.bmodeproximal_slider_tz, 'Enable', 'on');
set(handles.bmodeproximal_slider_rx, 'Enable', 'on');
set(handles.bmodeproximal_slider_ry, 'Enable', 'on');
set(handles.bmodeproximal_slider_tside, 'Enable', 'on');
set(handles.bmodeproximal_slider_rz, 'Enable', 'on');
set(handles.bmodeproximal_popupmenu_portion, 'Enable', 'on');
set(handles.bmodeproximal_button_random, 'Enable', 'on');
set(handles.bmodeproximal_button_reset, 'Enable', 'on');

% -------------------------------------------------------------------------

% obtain default values, will be usefull for reset button
default_bmodeproximal_tz    = get(handles.bmodeproximal_slider_tz, 'value');
default_bmodeproximal_rx    = get(handles.bmodeproximal_slider_rx, 'value');
default_bmodeproximal_ry    = get(handles.bmodeproximal_slider_ry, 'value');
default_bmodeproximal_tside = get(handles.bmodeproximal_slider_tside, 'value');
default_bmodeproximal_rz    = get(handles.bmodeproximal_slider_rz, 'value');

% -------------------------------------------------------------------------

% compute the proximal slices for the first time so it is displayed
[bmodeproximal_pointcloud, bmodeproximal_plane] = obtain_USsimulation(bone, ...
                                                      default_bmodeproximal_tz, ...
                                                      default_bmodeproximal_rx, ...
                                                      default_bmodeproximal_ry, ...
                                                      default_bmodeproximal_tside, ...
                                                      default_bmodeproximal_rz, ...
                                                      0.001);

% display proximal slices and its syntetic US beam
display_planeslice(handles.axes1, bmodeproximal_pointcloud, bmodeproximal_plane, size(1)*0.6, 'Tag', "plot_bmodeproximal_samplepoints");

% display protion of the bone
display_boneportion(handles.axes1, upperlower_proximal_bonepointcloud, bone, 'Tag', "plot_proximalportion");

% store the popupmenu index to 
handles.bmodeproximal_portion = upperlower_proximal_bonepointcloud;

% Update handles structure
guidata(hObject, handles);




function enable_distalComponents(hObject, handles)
% obtain several variable from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get values from popup menu to get relative position
idx = get(handles.bmodedistal_popupmenu_portion, 'Value');
if idx==1
    upperlower_distal_bonepointcloud = [0.7 0.8];
elseif idx==2 
    upperlower_distal_bonepointcloud = [0.8 0.9];
else
    upperlower_distal_bonepointcloud = [0.9 1];
end

middle_distal_bonepointcloud = ( upperlower_distal_bonepointcloud(1) + upperlower_distal_bonepointcloud(2) ) / 2;

% -------------------------------------------------------------------------

% set max, min, values for sliders and edits
% tz slider and edits
set(handles.bmodedistal_slider_tz, 'max',   maxmin(1,3)-size(3)*upperlower_distal_bonepointcloud(1));
set(handles.bmodedistal_slider_tz, 'min',   maxmin(1,3)-size(3)*upperlower_distal_bonepointcloud(2));
set(handles.bmodedistal_slider_tz, 'value', maxmin(1,3)-size(3)*middle_distal_bonepointcloud);
set(handles.bmodedistal_edit_tz, 'String', num2str(get(handles.bmodedistal_slider_tz, 'Value')));
% tside slider and edits
set(handles.bmodedistal_slider_tside, 'max', maxmin(1,1));
set(handles.bmodedistal_slider_tside, 'min', maxmin(2,1));
set(handles.bmodedistal_slider_tside, 'value', maxmin(2,1)+size(1)/2);
set(handles.bmodedistal_edit_tside, 'String', num2str(get(handles.bmodedistal_slider_tside, 'Value')));

% turn on all the neccesary components
set(handles.bmodedistal_slider_tz, 'Enable', 'on');
set(handles.bmodedistal_slider_rx, 'Enable', 'on');
set(handles.bmodedistal_slider_ry, 'Enable', 'on');
set(handles.bmodedistal_slider_tside, 'Enable', 'on');
set(handles.bmodedistal_slider_rz, 'Enable', 'on');
set(handles.bmodedistal_popupmenu_portion, 'Enable', 'on');
set(handles.bmode_button_random, 'Enable', 'on');
set(handles.bmode_button_reset, 'Enable', 'on');

% -------------------------------------------------------------------------

% obtain default values, will be usefull for reset button
default_bmodedistal_tz    = get(handles.bmodedistal_slider_tz, 'value');
default_bmodedistal_rx    = get(handles.bmodedistal_slider_rx, 'value');
default_bmodedistal_ry    = get(handles.bmodedistal_slider_ry, 'value');
default_bmodedistal_tside = get(handles.bmodedistal_slider_tside, 'value');
default_bmodedistal_rz    = get(handles.bmodedistal_slider_rz, 'value');

% -------------------------------------------------------------------------

% compute the proximal slices for the first time so it is displayed
[bmodedistal_pointcloud, bmodedistal_plane] = obtain_USsimulation(bone, ...
                                                      default_bmodedistal_tz, ...
                                                      default_bmodedistal_rx, ...
                                                      default_bmodedistal_ry, ...
                                                      default_bmodedistal_tside, ...
                                                      default_bmodedistal_rz, ...
                                                      0.001);

% display proximal slices and its syntetic US beam
display_planeslice(handles.axes1, bmodedistal_pointcloud, bmodedistal_plane, size(1)*0.6, 'Tag', "plot_bmodedistal_samplepoints");

display_boneportion(handles.axes1, upperlower_distal_bonepointcloud, bone, 'Tag', "plot_distalportion");

% store the popupmenu index to 
handles.bmodedistal_portion = upperlower_distal_bonepointcloud;

% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in data_button_browseacs.
function data_button_browseacs_Callback(hObject, eventdata, handles)
% hObject    handle to data_button_browseacs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% open browser dialog
[file,path] = uigetfile('*.mat');

% check whether user click cancel or select
if isequal(file,0)
    disp('User selected Cancel');
else
    disp(['User selected ', fullfile(path,file)]);
    
    % set the string to edit box and load the mat file
    set(handles.data_edit_acs, 'String', fullfile(path,file));
    load(fullfile(path,file));
    
    % obtain bone model from global variables and center it
    boneSTL = handles.boneSTL;
    bone = bsxfun(@minus, boneSTL.Points, bone_centroid);
        
    % display the bone after centered
    delete(findobj('Tag', 'plot_bone'));
    plot3( handles.axes1, ...
           bone(:,1), ...
           bone(:,2), ...
           bone(:,3), ...
           '.', 'Color', [0.7 0.7 0.7], ...
           'MarkerSize', 0.1, ...
           'Tag', 'plot_bone');
        
    % calculate stl bone size to specify the max-min and steps for all of
    % the sliders to make sure this toolbox as general as possible.
    maxmin = [max(bone,[],1); min(bone,[],1)];
    size = abs(diff(maxmin, 1, 1));
    
    % display acs
    display_axis(handles.axes1, acs_origin, acs_axes, size(3)/10, 'Tag', "plot_acs");
    
    % store several variable to global
    handles.bone = bone;
    
    % Update handles structure
    guidata(hObject, handles);
    
    % enable all elements
    enable_allComponents(hObject, handles);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on selection change in bmodedistal_popupmenu_portion.
function bmodedistal_popupmenu_portion_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_popupmenu_portion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns bmodedistal_popupmenu_portion contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bmodedistal_popupmenu_portion

% obtain several variable from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get values from popup menu to get relative position
idx = get(handles.bmodedistal_popupmenu_portion, 'Value');
if idx==1
    upperlower_distal_bonepointcloud = [0.7 0.8];
elseif idx==2 
    upperlower_distal_bonepointcloud = [0.8 0.9];
else
    upperlower_distal_bonepointcloud = [0.9 1];
end

middle_distal_bonepointcloud = ( upperlower_distal_bonepointcloud(1) + upperlower_distal_bonepointcloud(2) ) / 2;

% -------------------------------------------------------------------------

% set max, min, values for sliders and edits
% tz slider and edits
set(handles.bmodedistal_slider_tz, 'max',   maxmin(1,3)-size(3)*upperlower_distal_bonepointcloud(1));
set(handles.bmodedistal_slider_tz, 'min',   maxmin(1,3)-size(3)*upperlower_distal_bonepointcloud(2));
set(handles.bmodedistal_slider_tz, 'value', maxmin(1,3)-size(3)*middle_distal_bonepointcloud);
set(handles.bmodedistal_edit_tz, 'String', num2str(get(handles.bmodedistal_slider_tz, 'Value')));

% -------------------------------------------------------------------------

% compute the proximal slices for the first time so it is displayed
[bmodedistal_pointcloud, bmodedistal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodedistal_slider_tz, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rx, 'Value'), ...
                                                      get(handles.bmodedistal_slider_ry, 'Value'), ...
                                                      get(handles.bmodedistal_slider_tside, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodedistal_samplepoints'));
display_planeslice(handles.axes1, bmodedistal_pointcloud, bmodedistal_plane, size(1)*0.6, 'Tag', "plot_bmodedistal_samplepoints");

% display bone portion
delete(findobj('Tag', 'plot_distalportion'));
display_boneportion(handles.axes1, upperlower_distal_bonepointcloud, bone, 'Tag', "plot_distalportion");

% store changes to global variable
handles.bmodedistal_pointcloud = bmodedistal_pointcloud;
handles.bmodedistal_plane = bmodedistal_plane;

% store the popupmenu index to 
handles.bmodedistal_portion = upperlower_distal_bonepointcloud;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function bmodedistal_popupmenu_portion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_popupmenu_portion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function bmodedistal_slider_tz_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% obtain several variables from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodedistal_edit_tz,'String', num2str(get(handles.bmodedistal_slider_tz, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodedistal_pointcloud, bmodedistal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodedistal_slider_tz, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rx, 'Value'), ...
                                                      get(handles.bmodedistal_slider_ry, 'Value'), ...
                                                      get(handles.bmodedistal_slider_tside, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodedistal_samplepoints'));
display_planeslice(handles.axes1, bmodedistal_pointcloud, bmodedistal_plane, size(1)*0.6, 'Tag', "plot_bmodedistal_samplepoints");

% store changes to global variable
handles.bmodedistal_pointcloud = bmodedistal_pointcloud;
handles.bmodedistal_plane = bmodedistal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodedistal_slider_tz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function bmodedistal_slider_rx_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% obtain several variables from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodedistal_edit_rx,'String', num2str(get(handles.bmodedistal_slider_rx, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodedistal_pointcloud, bmodedistal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodedistal_slider_tz, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rx, 'Value'), ...
                                                      get(handles.bmodedistal_slider_ry, 'Value'), ...
                                                      get(handles.bmodedistal_slider_tside, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodedistal_samplepoints'));
display_planeslice(handles.axes1, bmodedistal_pointcloud, bmodedistal_plane, size(1)*0.6, 'Tag', "plot_bmodedistal_samplepoints");

% store changes to global variable
handles.bmodedistal_pointcloud = bmodedistal_pointcloud;
handles.bmodedistal_plane = bmodedistal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodedistal_slider_rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmodedistal_slider_ry_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% obtain several variables from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodedistal_edit_ry,'String', num2str(get(handles.bmodedistal_slider_ry, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodedistal_pointcloud, bmodedistal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodedistal_slider_tz, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rx, 'Value'), ...
                                                      get(handles.bmodedistal_slider_ry, 'Value'), ...
                                                      get(handles.bmodedistal_slider_tside, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodedistal_samplepoints'));
display_planeslice(handles.axes1, bmodedistal_pointcloud, bmodedistal_plane, size(1)*0.6, 'Tag', "plot_bmodedistal_samplepoints");

% store changes to global variable
handles.bmodedistal_pointcloud = bmodedistal_pointcloud;
handles.bmodedistal_plane = bmodedistal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodedistal_slider_ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmodedistal_slider_tside_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% obtain several variables from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodedistal_edit_tside,'String', num2str(get(handles.bmodedistal_slider_tside, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodedistal_pointcloud, bmodedistal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodedistal_slider_tz, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rx, 'Value'), ...
                                                      get(handles.bmodedistal_slider_ry, 'Value'), ...
                                                      get(handles.bmodedistal_slider_tside, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodedistal_samplepoints'));
display_planeslice(handles.axes1, bmodedistal_pointcloud, bmodedistal_plane, size(1)*0.6, 'Tag', "plot_bmodedistal_samplepoints");

% store changes to global variable
handles.bmodedistal_pointcloud = bmodedistal_pointcloud;
handles.bmodedistal_plane = bmodedistal_plane;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function bmodedistal_slider_tside_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmodedistal_slider_rz_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% obtain several variables from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodedistal_edit_rz,'String', num2str(get(handles.bmodedistal_slider_rz, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodedistal_pointcloud, bmodedistal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodedistal_slider_tz, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rx, 'Value'), ...
                                                      get(handles.bmodedistal_slider_ry, 'Value'), ...
                                                      get(handles.bmodedistal_slider_tside, 'Value'), ...
                                                      get(handles.bmodedistal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodedistal_samplepoints'));
display_planeslice(handles.axes1, bmodedistal_pointcloud, bmodedistal_plane, size(1)*0.6, 'Tag', "plot_bmodedistal_samplepoints");

% store changes to global variable
handles.bmodedistal_pointcloud = bmodedistal_pointcloud;
handles.bmodedistal_plane = bmodedistal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodedistal_slider_rz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_slider_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% -------------------------------------------------------------------------


function bmodedistal_edit_tz_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodedistal_edit_tz as text
%        str2double(get(hObject,'String')) returns contents of bmodedistal_edit_tz as a double
% obtain several variables from global



% --- Executes during object creation, after setting all properties.
function bmodedistal_edit_tz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bmodedistal_edit_rx_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodedistal_edit_rx as text
%        str2double(get(hObject,'String')) returns contents of bmodedistal_edit_rx as a double


% --- Executes during object creation, after setting all properties.
function bmodedistal_edit_rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bmodedistal_edit_ry_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodedistal_edit_ry as text
%        str2double(get(hObject,'String')) returns contents of bmodedistal_edit_ry as a double


% --- Executes during object creation, after setting all properties.
function bmodedistal_edit_ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function bmodedistal_edit_tside_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodedistal_edit_tside as text
%        str2double(get(hObject,'String')) returns contents of bmodedistal_edit_tside as a double


% --- Executes during object creation, after setting all properties.
function bmodedistal_edit_tside_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bmodedistal_edit_rz_Callback(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodedistal_edit_rz as text
%        str2double(get(hObject,'String')) returns contents of bmodedistal_edit_rz as a double


% --- Executes during object creation, after setting all properties.
function bmodedistal_edit_rz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodedistal_edit_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bmode_button_random.
function bmode_button_random_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_button_random (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bmode_button_reset.
function bmode_button_reset_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_button_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on selection change in bmodeproximal_popupmenu_portion.
function bmodeproximal_popupmenu_portion_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_popupmenu_portion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns bmodeproximal_popupmenu_portion contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bmodeproximal_popupmenu_portion

% obtain several variable from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get values from popup menu to get relative position
idx = get(handles.bmodeproximal_popupmenu_portion, 'Value');
if idx==1
    upperlower_proximal_bonepointcloud = [0 0.1];
elseif idx==2 
    upperlower_proximal_bonepointcloud = [0.1 0.2];
else
    upperlower_proximal_bonepointcloud = [0.2 0.3];
end

middle_proximal_bonepointcloud = ( upperlower_proximal_bonepointcloud(1) + upperlower_proximal_bonepointcloud(2) ) / 2;

% -------------------------------------------------------------------------

% set max, min, values for sliders and edits
% tz slider and edits
set(handles.bmodeproximal_slider_tz, 'max',   maxmin(1,3)-size(3)*upperlower_proximal_bonepointcloud(1));
set(handles.bmodeproximal_slider_tz, 'min',   maxmin(1,3)-size(3)*upperlower_proximal_bonepointcloud(2));
set(handles.bmodeproximal_slider_tz, 'value', maxmin(1,3)-size(3)*middle_proximal_bonepointcloud);
set(handles.bmodeproximal_edit_tz, 'String', num2str(get(handles.bmodeproximal_slider_tz, 'Value')));

% -------------------------------------------------------------------------

% compute the proximal slices for the first time so it is displayed
[bmodeproximal_pointcloud, bmodeproximal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodeproximal_slider_tz, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rx, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_ry, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_tside, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodeproximal_samplepoints'));
display_planeslice(handles.axes1, bmodeproximal_pointcloud, bmodeproximal_plane, size(1)*0.6, 'Tag', "plot_bmodeproximal_samplepoints");

% display bone portion
delete(findobj('Tag', 'plot_proximalportion'));
display_boneportion(handles.axes1, upperlower_proximal_bonepointcloud, bone, 'Tag', "plot_proximalportion");

% store changes to global variable
handles.bmodeproximal_pointcloud = bmodeproximal_pointcloud;
handles.bmodeproximal_plane = bmodeproximal_plane;

% store the popupmenu index to 
handles.bmodeproximal_portion = upperlower_proximal_bonepointcloud;

% Update handles structure
guidata(hObject, handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodeproximal_popupmenu_portion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_popupmenu_portion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% -------------------------------------------------------------------------


% --- Executes on button press in bmodeproximal_button_random.
function bmodeproximal_button_random_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_button_random (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in bmodeproximal_button_reset.
function bmodeproximal_button_reset_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_button_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% -------------------------------------------------------------------------


% --- Executes on slider movement.
function bmodeproximal_slider_tz_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodeproximal_edit_tz,'String', num2str(get(handles.bmodeproximal_slider_tz, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodeproximal_pointcloud, bmodeproximal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodeproximal_slider_tz, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rx, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_ry, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_tside, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodeproximal_samplepoints'));
display_planeslice(handles.axes1, bmodeproximal_pointcloud, bmodeproximal_plane, size(1)*0.6, 'Tag', "plot_bmodeproximal_samplepoints");

% store changes to global variable
handles.bmodeproximal_pointcloud = bmodeproximal_pointcloud;
handles.bmodeproximal_plane = bmodeproximal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodeproximal_slider_tz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmodeproximal_slider_rx_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodeproximal_edit_rx,'String', num2str(get(handles.bmodeproximal_slider_rx, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodeproximal_pointcloud, bmodeproximal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodeproximal_slider_tz, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rx, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_ry, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_tside, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodeproximal_samplepoints'));
display_planeslice(handles.axes1, bmodeproximal_pointcloud, bmodeproximal_plane, size(1)*0.6, 'Tag', "plot_bmodeproximal_samplepoints");

% store changes to global variable
handles.bmodeproximal_pointcloud = bmodeproximal_pointcloud;
handles.bmodeproximal_plane = bmodeproximal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodeproximal_slider_rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmodeproximal_slider_ry_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodeproximal_edit_ry,'String', num2str(get(handles.bmodeproximal_slider_ry, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodeproximal_pointcloud, bmodeproximal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodeproximal_slider_tz, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rx, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_ry, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_tside, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rz, 'Value'), ...
                                                      0.0001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodeproximal_samplepoints'));
display_planeslice(handles.axes1, bmodeproximal_pointcloud, bmodeproximal_plane, size(1)*0.6, 'Tag', "plot_bmodeproximal_samplepoints");

% store changes to global variable
handles.bmodeproximal_pointcloud = bmodeproximal_pointcloud;
handles.bmodeproximal_plane = bmodeproximal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodeproximal_slider_ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmodeproximal_slider_tside_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodeproximal_edit_tside,'String', num2str(get(handles.bmodeproximal_slider_tside, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodeproximal_pointcloud, bmodeproximal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodeproximal_slider_tz, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rx, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_ry, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_tside, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodeproximal_samplepoints'));
display_planeslice(handles.axes1, bmodeproximal_pointcloud, bmodeproximal_plane, size(1)*0.6, 'Tag', "plot_bmodeproximal_samplepoints");

% store changes to global variable
handles.bmodeproximal_pointcloud = bmodeproximal_pointcloud;
handles.bmodeproximal_plane = bmodeproximal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodeproximal_slider_tside_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmodeproximal_slider_rz_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% get the value from proximal_slider 1 and set the display number
set(handles.bmodeproximal_edit_rz,'String', num2str(get(handles.bmodeproximal_slider_rz, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmodeproximal_pointcloud, bmodeproximal_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmodeproximal_slider_tz, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rx, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_ry, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_tside, 'Value'), ...
                                                      get(handles.bmodeproximal_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmodeproximal_samplepoints'));
display_planeslice(handles.axes1, bmodeproximal_pointcloud, bmodeproximal_plane, size(1)*0.6, 'Tag', "plot_bmodeproximal_samplepoints");

% store changes to global variable
handles.bmodeproximal_pointcloud = bmodeproximal_pointcloud;
handles.bmodeproximal_plane = bmodeproximal_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmodeproximal_slider_rz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_slider_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% -------------------------------------------------------------------------


function bmodeproximal_edit_tz_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodeproximal_edit_tz as text
%        str2double(get(hObject,'String')) returns contents of bmodeproximal_edit_tz as a double


% --- Executes during object creation, after setting all properties.
function bmodeproximal_edit_tz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bmodeproximal_edit_rx_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodeproximal_edit_rx as text
%        str2double(get(hObject,'String')) returns contents of bmodeproximal_edit_rx as a double


% --- Executes during object creation, after setting all properties.
function bmodeproximal_edit_rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bmodeproximal_edit_ry_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodeproximal_edit_ry as text
%        str2double(get(hObject,'String')) returns contents of bmodeproximal_edit_ry as a double


% --- Executes during object creation, after setting all properties.
function bmodeproximal_edit_ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bmodeproximal_edit_tside_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodeproximal_edit_tside as text
%        str2double(get(hObject,'String')) returns contents of bmodeproximal_edit_tside as a double


% --- Executes during object creation, after setting all properties.
function bmodeproximal_edit_tside_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bmodeproximal_edit_rz_Callback(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmodeproximal_edit_rz as text
%        str2double(get(hObject,'String')) returns contents of bmodeproximal_edit_rz as a double


% --- Executes during object creation, after setting all properties.
function bmodeproximal_edit_rz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmodeproximal_edit_rz (see GCBO)
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


% --- Executes on button press in main_button_save.
function main_button_save_Callback(hObject, eventdata, handles)
% hObject    handle to main_button_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% obtain variables that we need to perform registration simulation
bmodeproximal_portion     = handles.bmodeproximal_portion;
bmodeproximal_pointcloud  = handles.bmodeproximal_pointcloud.US_simulation;
bmodeproximal_plane       = handles.bmodeproximal_plane.slice;

bmodedistal_portion        = handles.bmodedistal_portion;
bmodedistal_pointcloud     = handles.bmodedistal_pointcloud.US_simulation;
bmodedistal_plane          = handles.bmodedistal_plane.slice;



% save all the variables that we need to conduct registration simulation
filename = sprintf('usdata_bb_%s.mat', datestr(now,'mm-dd-yyyy_HH-MM'));
path_name = strcat(pwd,'/data/pointclouds/', filename);    
save(path_name, 'bmodeproximal_portion', 'bmodeproximal_pointcloud', 'bmodeproximal_plane', 'bmodedistal_portion' ,'bmodedistal_pointcloud', 'bmodedistal_plane');
