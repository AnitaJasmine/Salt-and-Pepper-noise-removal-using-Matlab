function varargout = gui(varargin)
% GUI M-file for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 30-Mar-2009 10:11:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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


% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
image_file = get(handles.popupmenu1,'String');

image_number = get(handles.popupmenu1,'Value');

im_original=imread(char(image_file(image_number)));
%display(im_original);
set(handles.axes1,'HandleVisibility','ON');
set(handles.axes2,'HandleVisibility','OFF');
set(handles.axes3,'HandleVisibility','OFF');
im_original=imresize(im_original,0.2);
imagesc(im_original)
axis equal;
axis tight;
set(handles.axes1,'XTickLabel',' ','YTickLabel',' ')
colormap(gray)

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in noisebutton.
function noisebutton_Callback(hObject, eventdata, handles)
% hObject    handle to noisebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% find the value from the slider
value=get(handles.slider1,'value');
 
%Place the value in text_pb
str=sprintf('%.2f',value);
set(handles.text1,'String',str);
image_file = get(handles.popupmenu1,'String');

image_number = get(handles.popupmenu1,'Value');

im_original=imread(char(image_file(image_number)));

value=get(handles.slider1,'value');
im_original=imresize(im_original,0.2);
im_noise=imnoise(im_original,'salt & pepper',value);

%display(im_original);
set(handles.axes1,'HandleVisibility','OFF');
set(handles.axes2,'HandleVisibility','ON');
set(handles.axes3,'HandleVisibility','OFF');


imagesc(im_noise);
%imshow(im_noise);
axis equal;
axis tight;
set(handles.axes2,'XTickLabel',' ','YTickLabel',' ')
colormap(gray)


% --- Executes on button press in filterbutton.
function filterbutton_Callback(hObject, eventdata, handles)
% hObject    handle to filterbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

image_file = get(handles.popupmenu1,'String');

image_number = get(handles.popupmenu1,'Value');

im_original=imread(char(image_file(image_number)));

value=get(handles.slider1,'value');
im_filt=roadtech(im_original,value);
%im_noise=imnoise(im_original,'salt & pepper',value);
%im_filt=medfilt2(im_noise);
%display(im_original);
set(handles.axes1,'HandleVisibility','OFF');
set(handles.axes2,'HandleVisibility','OFF');
set(handles.axes3,'HandleVisibility','ON');


imagesc(im_filt);
%imshow(im_noise);
axis equal;
axis tight;
set(handles.axes2,'XTickLabel',' ','YTickLabel',' ')
colormap(gray)


% --- Executes on button press in closebutton.
function closebutton_Callback(hObject, eventdata, handles)
% hObject    handle to closebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all;
