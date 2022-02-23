function varargout = usmeasurement_ab(varargin)
% USMEASUREMENT_AB MATLAB code for usmeasurement_ab.fig
%      USMEASUREMENT_AB, by itself, creates a new USMEASUREMENT_AB or raises the existing
%      singleton*.
%
%      H = USMEASUREMENT_AB returns the handle to a new USMEASUREMENT_AB or the handle to
%      the existing singleton*.
%
%      USMEASUREMENT_AB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in USMEASUREMENT_AB.M with the given input arguments.
%
%      USMEASUREMENT_AB('Property','Value',...) creates a new USMEASUREMENT_AB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before usmeasurement_ab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to usmeasurement_ab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help usmeasurement_ab

% Last Modified by GUIDE v2.5 22-Apr-2021 12:37:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @usmeasurement_ab_OpeningFcn, ...
                   'gui_OutputFcn',  @usmeasurement_ab_OutputFcn, ...
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


% --- Executes just before usmeasurement_ab is made visible.
function usmeasurement_ab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to usmeasurement_ab (see VARARGIN)

% include several paths
addpath(genpath(strcat(pwd,'/functions/display_functions/')));
addpath(genpath(strcat(pwd,'/functions/geometry/')));
addpath(genpath(strcat(pwd,'/functions/ultrasound_simulation/')));

% Choose default command line output for usmeasurement_ab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes usmeasurement_ab wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = usmeasurement_ab_OutputFcn(hObject, eventdata, handles) 
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

function enable_allComponents(handles)
% obtain several variable from global
bone = handles.bone;

% calculate stl bone size to specify the max-min and steps for all of
% the sliders to make sure this toolbox as general as possible.
maxmin = [max(bone,[],1); min(bone,[],1)];
size = abs(diff(maxmin, 1, 1));

% -------------------------------------------------------------------------

% set max, min, values for sliders and edits
% tz slider and edits
set(handles.bmode_slider_tz, 'max', maxmin(1,3));
set(handles.bmode_slider_tz, 'min', maxmin(2,3));
set(handles.bmode_slider_tz, 'value', maxmin(2,3)+size(3)/2);
set(handles.bmode_edit_tz, 'String', num2str(get(handles.bmode_slider_tz, 'Value')));
% tside slider and edits
set(handles.bmode_slider_tside, 'max', maxmin(1,1));
set(handles.bmode_slider_tside, 'min', maxmin(2,1));
set(handles.bmode_slider_tside, 'value', maxmin(2,1)+size(1)/2);
set(handles.bmode_edit_tside, 'String', num2str(get(handles.bmode_slider_tside, 'Value')));

% turn on all the neccesary components
set(handles.amode_popupmenu_number, 'Enable', 'on');
set(handles.amode_button_create, 'Enable', 'on');
set(handles.amode_button_browseArea, 'Enable', 'on');
set(handles.bmode_slider_tz, 'Enable', 'on');
set(handles.bmode_slider_rx, 'Enable', 'on');
set(handles.bmode_slider_ry, 'Enable', 'on');
set(handles.bmode_slider_tside, 'Enable', 'on');
set(handles.bmode_slider_rz, 'Enable', 'on');
set(handles.bmode_button_random, 'Enable', 'on');
set(handles.bmode_button_reset, 'Enable', 'on');

% -------------------------------------------------------------------------

% obtain default values, will be usefull for reset button
default_bmode_tz    = get(handles.bmode_slider_tz, 'value');
default_bmode_rx    = get(handles.bmode_slider_rx, 'value');
default_bmode_ry    = get(handles.bmode_slider_ry, 'value');
default_bmode_tside = get(handles.bmode_slider_tside, 'value');
default_bmode_rz    = get(handles.bmode_slider_rz, 'value');

% -------------------------------------------------------------------------

% compute the proximal slices for the first time so it is displayed
[bmode_pointcloud, bmode_plane] = obtain_USsimulation(bone, ...
                                                      default_bmode_tz, ...
                                                      default_bmode_rx, ...
                                                      default_bmode_ry, ...
                                                      default_bmode_tside, ...
                                                      default_bmode_rz, ...
                                                      0.001);

% display proximal slices and its syntetic US beam
display_planeslice(handles.axes1, bmode_pointcloud, bmode_plane, size(1)*0.6, 'Tag', "plot_bmode_samplepoints");



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
    enable_allComponents(handles);
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function amode_edit_area_Callback(hObject, eventdata, handles)
% hObject    handle to amode_edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of amode_edit_area as text
%        str2double(get(hObject,'String')) returns contents of amode_edit_area as a double


% --- Executes during object creation, after setting all properties.
function amode_edit_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amode_edit_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in amode_button_browseArea.
function amode_button_browseArea_Callback(hObject, eventdata, handles)
% hObject    handle to amode_button_browseArea (see GCBO)
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
    set(handles.amode_edit_area, 'String', fullfile(path,file));
    load(fullfile(path,file));
    
    % obtain size of the preregistration Area that is loaded
    preregistrationArea_number = size(preregistrationArea, 2);
    
    % display the preregistration areas for sanity check
    for i=1:preregistrationArea_number
        string = sprintf("plot_preregistrationarea%d", i);
        plot3( handles.axes1, ...
               preregistrationArea{i}(:,1), ...
               preregistrationArea{i}(:,2), ...
               preregistrationArea{i}(:,3), ...
               '.r', ...
               'MarkerSize', 0.1, ...
               'Tag', string);
    end
    
    % disable all component related to "create new area"
    set(handles.amode_popupmenu_number, 'Value', preregistrationArea_number);
    set(handles.amode_popupmenu_number, 'Enable', 'off');
    set(handles.amode_button_create, 'Enable', 'off');
    
    % enable all component related to amode sampling
    set(handles.amode_button_randomselect, 'Enable', 'on');
    set(handles.amode_popup_samplingnumber, 'Enable', 'on');
    set(handles.amode_listbox_area, 'Enable', 'on');
    
    % set the list box, it will be used if user want to specify where the
    % amode measurement is
    strings = "All Points";
    for i=1:preregistrationArea_number
        strings = [strings, sprintf("Area %d", i)];
    end
    set(handles.amode_listbox_area, 'String', strings);
    
    % obtain area variable from .mat file and store it in global variable 
    handles.preregistrationArea = preregistrationArea;
    handles.preregistrationSphere = preregistrationSphere;
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in amode_popupmenu_number.
function amode_popupmenu_number_Callback(hObject, eventdata, handles)
% hObject    handle to amode_popupmenu_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns amode_popupmenu_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from amode_popupmenu_number


% --- Executes during object creation, after setting all properties.
function amode_popupmenu_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amode_popupmenu_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in amode_button_create.
function amode_button_create_Callback(hObject, eventdata, handles)
% hObject    handle to amode_button_create (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% obtain several variable from global
bone = handles.bone;

% obtain how many registration area that we want to have
preregistrationArea_number = get(handles.amode_popupmenu_number, 'Value');

% create a temprorary mat file to be read by other gui
path_name = strcat(pwd,'/data/temp/temp_mat.mat');
save(path_name, 'bone', 'preregistrationArea_number');
    
usmeasurement_preregistration;


% --- Executes on selection change in amode_listbox_area.
function amode_listbox_area_Callback(hObject, eventdata, handles)
% hObject    handle to amode_listbox_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns amode_listbox_area contents as cell array
%        contents{get(hObject,'Value')} returns selected item from amode_listbox_area

% obtain several variable from global
preregistrationArea_number = length(handles.preregistrationArea);

% get necessary property values from listbox
listBoxStrings = get(handles.amode_listbox_area,'String');
listBoxValue = get(handles.amode_listbox_area,'Value');

% if user selected first index, it is must be "all point"
if(listBoxValue==1)
    
    % turn on bone plot
    plot_bone = findobj('Tag', 'plot_bone');
    plot_bone.Visible = 'on';    
    
    % turn on acs plot (there are three plot for each quiver3)
    plot_acs = findobj('Tag', 'plot_acs');
    for i=1:length(plot_acs)
        plot_acs(i).Visible = 'on';
    end
    
    % turn on every elements for bmode simulation illustration (there are
    % three a lot of them, like plane, intersectio, beam, etc.)
    plot_bmode = findobj('Tag', 'plot_bmode_samplepoints');
    for i=1:length(plot_bmode)
        plot_bmode(i).Visible = 'on';
    end
        
    % turn on every amode measurement in different preregistration areas.
    % since there are different tag for different preregistration areas, we
    % need to make a loop
    for i=1:preregistrationArea_number
        string = sprintf("plot_amode_samplepoints%d", i);
        plot_amode = findobj('Tag', string);
        if (~isempty(plot_amode)>0)
            plot_amode.Visible = 'on';
        end
    end
    
    % turn on every registration areas plot
    for i=2:length(listBoxStrings)
        string1 = sprintf("plot_preregistrationarea%d", i-1);
        plot_preregistrationArea = findobj('Tag', string1);
        plot_preregistrationArea.Visible = 'on';
    end
    
% if not, it must be registration areas
else
    
    % turn off bone plot
    plot_bone = findobj('Tag', 'plot_bone');
    plot_bone.Visible = 'off';
    
    % turn off acs plot (there are three plot for each quiver3)
    plot_acs = findobj('Tag', 'plot_acs');
    for i=1:length(plot_acs)
        plot_acs(i).Visible = 'off';
    end
    
    % turn off every elements for bmode simulation illustration (there are
    % three a lot of them, like plane, intersectio, beam, etc.)
    plot_bmode = findobj('Tag', 'plot_bmode_samplepoints');
    for i=1:length(plot_bmode)
        plot_bmode(i).Visible = 'off';
    end
    
    % turn off every amode measurement in different preregistration areas.
    % since there are different tag for different preregistration areas, we
    % need to make a loop
    for i=1:preregistrationArea_number
        string = sprintf("plot_amode_samplepoints%d", i);
        plot_amode = findobj('Tag', string);
        if (~isempty(plot_amode))
            plot_amode.Visible = 'off';
        end
    end
    
    % loop for all rest of the strings in list box
    for i=2:length(listBoxStrings)
        
        % define the name that will be found by findobj
        % this one is for preregistration area
        string1 = sprintf("plot_preregistrationarea%d", i-1);
        plot_preregistrationArea = findobj('Tag', string1);
        % this one is for amode sample points
        string2 = sprintf("plot_amode_samplepoints%d", i-1);
        plot_amode = findobj('Tag', string2);
        
        % if current loop is the same as user selected, turn on the
        % visibility, otherwise turn off
        if(i==listBoxValue)
            plot_preregistrationArea.Visible = 'on';
            if (~isempty(plot_amode)>0)
                plot_amode.Visible='on';
            end
        else
            plot_preregistrationArea.Visible = 'off';
            if (~isempty(plot_amode)>0)
                plot_amode.Visible='off';
            end
        end
    end
end


% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function amode_listbox_area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amode_listbox_area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in amode_popup_samplingnumber.
function amode_popup_samplingnumber_Callback(hObject, eventdata, handles)
% hObject    handle to amode_popup_samplingnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns amode_popup_samplingnumber contents as cell array
%        contents{get(hObject,'Value')} returns selected item from amode_popup_samplingnumber


% --- Executes during object creation, after setting all properties.
function amode_popup_samplingnumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to amode_popup_samplingnumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in amode_button_randomselect.
function amode_button_randomselect_Callback(hObject, eventdata, handles)
% hObject    handle to amode_button_randomselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% obtain several global variable
preregistrationArea = handles.preregistrationArea;
preregistrationArea_number = length(preregistrationArea);

% obtain value from gui
preregistrationArea_samplingNumber = get(handles.amode_popup_samplingnumber, 'Value');

% % sampling point from preregistration area
% preregistrationArea_samplingNumber = get(handles.amode_popup_samplingnumber, 'Value');
% preregistrationArea_samplePoints = [];
% for i=1:preregistrationArea_number
%     point_number = size(preregistrationArea{i}, 1);
%     
%     preregistrationArea_randomIndex = randi( [1, point_number], 1, preregistrationArea_samplingNumber );
%     preregistrationArea_samplePoints = [ preregistrationArea_samplePoints ; ...
%                                          preregistrationArea{i}(preregistrationArea_randomIndex, :) ];
% end
% 
% % renaming variable
% amode_samplePoints = preregistrationArea_samplePoints;

% sampling point from preregistration area, this while iteration is
% making sure the selected sample points in each preregistration area
% is not too near to each other
accepted_condition = false;
while(~accepted_condition)
    preregistrationArea_samplePoints = {};
    for i=1:preregistrationArea_number
        point_number = size(preregistrationArea{i}, 1);

        preregistrationArea_randomIndex = randi( [1, point_number], 1, preregistrationArea_samplingNumber );
        preregistrationArea_samplePoints{i} = preregistrationArea{i}(preregistrationArea_randomIndex, :);

        samplePoints_index = 1:preregistrationArea_samplingNumber;
        combination_index = nchoosek(samplePoints_index,2);

        for j=1:length(combination_index)
            points_toCheck = [ preregistrationArea_samplePoints{i}(combination_index(j,1), :); ...
                               preregistrationArea_samplePoints{i}(combination_index(j,2), :) ];

            if ( pdist( points_toCheck, 'euclidean') < 0.020 )
                accepted_condition = false;
                break;
            else
                accepted_condition = true;
            end

        end

        if (accepted_condition == false)
            break;
        end
    end
end

% gather all the amode sample points to single array
amode_samplePoints = [];
for i=1:preregistrationArea_number
    amode_samplePoints = [ amode_samplePoints; preregistrationArea_samplePoints{i} ];
end



% display the sample points for sanity check ( i make a loop just because i
% want to have different tag for different sample point in the different
% preregistration areas)
startindex = 1;
endindex = preregistrationArea_samplingNumber;
for i=1:preregistrationArea_number
    string = sprintf("plot_amode_samplepoints%d", i);
        
    delete(findobj('Tag', string));
    plot3( handles.axes1, ...
           amode_samplePoints(startindex:endindex,1), ...
           amode_samplePoints(startindex:endindex,2), ...
           amode_samplePoints(startindex:endindex,3), ...
           'og', ...
           'MarkerFaceColor', 'g', ...
           'Tag', string);
       
    startindex = endindex+1;
    endindex = endindex+preregistrationArea_samplingNumber;
end
   
% store several variable to global
handles.amode_samplePoints = amode_samplePoints;

% Update handles structure
guidata(hObject, handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on slider movement.
function bmode_slider_tz_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_slider_tz (see GCBO)
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
set(handles.bmode_edit_tz,'String', num2str(get(handles.bmode_slider_tz, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmode_pointcloud, bmode_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmode_slider_tz, 'Value'), ...
                                                      get(handles.bmode_slider_rx, 'Value'), ...
                                                      get(handles.bmode_slider_ry, 'Value'), ...
                                                      get(handles.bmode_slider_tside, 'Value'), ...
                                                      get(handles.bmode_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmode_samplepoints'));
display_planeslice(handles.axes1, bmode_pointcloud, bmode_plane, size(1)*0.6, 'Tag', "plot_bmode_samplepoints");

% store changes to global variable
handles.bmode_pointcloud = bmode_pointcloud;
handles.bmode_plane = bmode_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmode_slider_tz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_slider_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function bmode_slider_rx_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_slider_rx (see GCBO)
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
set(handles.bmode_edit_rx,'String', num2str(get(handles.bmode_slider_rx, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmode_pointcloud, bmode_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmode_slider_tz, 'Value'), ...
                                                      get(handles.bmode_slider_rx, 'Value'), ...
                                                      get(handles.bmode_slider_ry, 'Value'), ...
                                                      get(handles.bmode_slider_tside, 'Value'), ...
                                                      get(handles.bmode_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmode_samplepoints'));
display_planeslice(handles.axes1, bmode_pointcloud, bmode_plane, size(1)*0.6, 'Tag', "plot_bmode_samplepoints");

% store changes to global variable
handles.bmode_pointcloud = bmode_pointcloud;
handles.bmode_plane = bmode_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmode_slider_rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_slider_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmode_slider_ry_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_slider_ry (see GCBO)
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
set(handles.bmode_edit_ry,'String', num2str(get(handles.bmode_slider_ry, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmode_pointcloud, bmode_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmode_slider_tz, 'Value'), ...
                                                      get(handles.bmode_slider_rx, 'Value'), ...
                                                      get(handles.bmode_slider_ry, 'Value'), ...
                                                      get(handles.bmode_slider_tside, 'Value'), ...
                                                      get(handles.bmode_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmode_samplepoints'));
display_planeslice(handles.axes1, bmode_pointcloud, bmode_plane, size(1)*0.6, 'Tag', "plot_bmode_samplepoints");

% store changes to global variable
handles.bmode_pointcloud = bmode_pointcloud;
handles.bmode_plane = bmode_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmode_slider_ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_slider_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmode_slider_tside_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_slider_tside (see GCBO)
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
set(handles.bmode_edit_tside,'String', num2str(get(handles.bmode_slider_tside, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmode_pointcloud, bmode_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmode_slider_tz, 'Value'), ...
                                                      get(handles.bmode_slider_rx, 'Value'), ...
                                                      get(handles.bmode_slider_ry, 'Value'), ...
                                                      get(handles.bmode_slider_tside, 'Value'), ...
                                                      get(handles.bmode_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmode_samplepoints'));
display_planeslice(handles.axes1, bmode_pointcloud, bmode_plane, size(1)*0.6, 'Tag', "plot_bmode_samplepoints");

% store changes to global variable
handles.bmode_pointcloud = bmode_pointcloud;
handles.bmode_plane = bmode_plane;

% Update handles structure
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function bmode_slider_tside_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_slider_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function bmode_slider_rz_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_slider_rz (see GCBO)
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
set(handles.bmode_edit_rz,'String', num2str(get(handles.bmode_slider_rz, 'Value')));

% compute the proximal slices for the first time so it is displayed
[bmode_pointcloud, bmode_plane] = obtain_USsimulation(bone, ...
                                                      get(handles.bmode_slider_tz, 'Value'), ...
                                                      get(handles.bmode_slider_rx, 'Value'), ...
                                                      get(handles.bmode_slider_ry, 'Value'), ...
                                                      get(handles.bmode_slider_tside, 'Value'), ...
                                                      get(handles.bmode_slider_rz, 'Value'), ...
                                                      0.001);

% display proximal slices and its syntetic US beam
delete(findobj('Tag', 'plot_bmode_samplepoints'));
display_planeslice(handles.axes1, bmode_pointcloud, bmode_plane, size(1)*0.6, 'Tag', "plot_bmode_samplepoints");

% store changes to global variable
handles.bmode_pointcloud = bmode_pointcloud;
handles.bmode_plane = bmode_plane;

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function bmode_slider_rz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_slider_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




function bmode_edit_tz_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_edit_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmode_edit_tz as text
%        str2double(get(hObject,'String')) returns contents of bmode_edit_tz as a double


% --- Executes during object creation, after setting all properties.
function bmode_edit_tz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_edit_tz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bmode_edit_rx_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_edit_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmode_edit_rx as text
%        str2double(get(hObject,'String')) returns contents of bmode_edit_rx as a double


% --- Executes during object creation, after setting all properties.
function bmode_edit_rx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_edit_rx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bmode_edit_ry_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_edit_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmode_edit_ry as text
%        str2double(get(hObject,'String')) returns contents of bmode_edit_ry as a double


% --- Executes during object creation, after setting all properties.
function bmode_edit_ry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_edit_ry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function bmode_edit_tside_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_edit_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmode_edit_tside as text
%        str2double(get(hObject,'String')) returns contents of bmode_edit_tside as a double


% --- Executes during object creation, after setting all properties.
function bmode_edit_tside_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_edit_tside (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function bmode_edit_rz_Callback(hObject, eventdata, handles)
% hObject    handle to bmode_edit_rz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bmode_edit_rz as text
%        str2double(get(hObject,'String')) returns contents of bmode_edit_rz as a double


% --- Executes during object creation, after setting all properties.
function bmode_edit_rz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bmode_edit_rz (see GCBO)
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


% --- Executes on button press in main_button_save.
function main_button_save_Callback(hObject, eventdata, handles)
% hObject    handle to main_button_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% obtain variables that we need to perform registration simulation
amode_samplePoints   = handles.amode_samplePoints;
amode_samplingNumber = get(handles.amode_popup_samplingnumber, 'Value');

bmode_pointcloud     = handles.bmode_pointcloud.US_simulation;
bmode_plane          = handles.bmode_plane.slice;

% save all the variables that we need to conduct registration simulation
filename = sprintf('usdata_ab_%s.mat', datestr(now,'mm-dd-yyyy_HH-MM'));
path_name = strcat(pwd,'/data/pointclouds/', filename);    
save(path_name, 'amode_samplePoints', 'amode_samplingNumber', 'bmode_pointcloud', 'bmode_plane');
