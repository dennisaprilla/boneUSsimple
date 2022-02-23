function varargout = main_menu(varargin)
% MAIN_MENU MATLAB code for main_menu.fig
%      MAIN_MENU, by itself, creates a new MAIN_MENU or raises the existing
%      singleton*.
%
%      H = MAIN_MENU returns the handle to a new MAIN_MENU or the handle to
%      the existing singleton*.
%
%      MAIN_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_MENU.M with the given input arguments.
%
%      MAIN_MENU('Property','Value',...) creates a new MAIN_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_menu

% Last Modified by GUIDE v2.5 21-Apr-2021 09:46:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_menu_OpeningFcn, ...
                   'gui_OutputFcn',  @main_menu_OutputFcn, ...
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


% --- Executes just before main_menu is made visible.
function main_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_menu (see VARARGIN)

% Choose default command line output for main_menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in acs_button_defineACS.
function acs_button_defineACS_Callback(hObject, eventdata, handles)
% hObject    handle to acs_button_defineACS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

allItems      = get(handles.acs_popupmenu_bone,'string');
selectedIndex = get(handles.acs_popupmenu_bone, 'Value');
selectedItem  = allItems{selectedIndex};

if (strcmp(selectedItem, 'Femur'))
    defineacs_femur;
end

if (strcmp(selectedItem, 'Tibia'))
    defineacs_tibia;
end


% --- Executes on button press in us_button_usSimulaton.
function us_button_usSimulaton_Callback(hObject, eventdata, handles)
% hObject    handle to us_button_usSimulaton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


selectedIndex = get(handles.us_popupmenu_usConfig, 'Value');

if (selectedIndex==1)
    % something
elseif (selectedIndex==2)
    usmeasurement_ab;
elseif (selectedIndex==3)
    usmeasurement_bb;
end


% --- Executes on button press in us_button_registrationSimulation.
function us_button_registrationSimulation_Callback(hObject, eventdata, handles)
% hObject    handle to us_button_registrationSimulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in us_popupmenu_usConfig.
function us_popupmenu_usConfig_Callback(hObject, eventdata, handles)
% hObject    handle to us_popupmenu_usConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns us_popupmenu_usConfig contents as cell array
%        contents{get(hObject,'Value')} returns selected item from us_popupmenu_usConfig


% --- Executes during object creation, after setting all properties.
function us_popupmenu_usConfig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to us_popupmenu_usConfig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in acs_popupmenu_bone.
function acs_popupmenu_bone_Callback(hObject, eventdata, handles)
% hObject    handle to acs_popupmenu_bone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns acs_popupmenu_bone contents as cell array
%        contents{get(hObject,'Value')} returns selected item from acs_popupmenu_bone


% --- Executes during object creation, after setting all properties.
function acs_popupmenu_bone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acs_popupmenu_bone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
