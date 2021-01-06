function varargout = gui_2way(varargin)
% GUI_2WAY MATLAB code for gui_2way.fig
%      GUI_2WAY, by itself, creates a new GUI_2WAY or raises the existing
%      singleton*.
%
%      H = GUI_2WAY returns the handle to a new GUI_2WAY or the handle to
%      the existing singleton*.
%
%      GUI_2WAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_2WAY.M with the given input arguments.
%
%      GUI_2WAY('Property','Value',...) creates a new GUI_2WAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_2way_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_2way_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_2way

% Last Modified by GUIDE v2.5 06-Jan-2021 13:30:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_2way_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_2way_OutputFcn, ...
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


% --- Executes just before gui_2way is made visible.
function gui_2way_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_2way (see VARARGIN)

% Choose default command line output for gui_2way
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_2way wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_2way_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bt_loadfixed.
function bt_loadfixed_Callback(hObject, eventdata, handles)
% hObject    handle to bt_loadfixed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile('*.png;*.jpg;*.tif','Load fixed image');
fname=fullfile(filepath,filename);
if isequal(fname,0)
   disp('User selected Cancel');
else   
    img_fixed=imread(fname);   % HE data
    figure
    handles.axes1=axes;
    I1=imshow(img_fixed,'parent',handles.axes1);
    handles.slider1.Enable='on';
    handles.img_fixed=img_fixed;
    handles.I1=I1;
    guidata(hObject, handles);
end

% --- Executes on button press in bt_loadmoving.
function bt_loadmoving_Callback(hObject, eventdata, handles)
% hObject    handle to bt_loadmoving (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,filepath]=uigetfile('*.png;*.jpg;*.tif','Load moving image');
fname=fullfile(filepath,filename);
if isequal(fname,0)
   disp('User selected Cancel');
else   
    img_moving=imread(fname);   % moving
    %imshow(img_moving,'parent',handles.axes1);
    R=img_reg_cp(img_moving,handles.img_fixed);     
    I2 = imagesc(handles.axes1,'CData',R.movingR);  
    handles.img_moving=img_moving;
    handles.slider2.Enable='on';
    handles.R=R;
    handles.I2=I2;
    
    guidata(hObject, handles);
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.I1.AlphaData=handles.slider1.Value;

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.I2.AlphaData=handles.slider2.Value;

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in bt_save.
function bt_save_Callback(hObject, eventdata, handles)
% hObject    handle to bt_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
alpha=[0:0.05:1,1:-0.05:0];
[filename,filepath]=uiputfile({'*.gif'},'Save gif');
fname=fullfile(filepath,filename);
for n = 1:length(alpha)
    n
    handles.I2.AlphaData=alpha(n);
      frame = getframe(handles.axes1); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if n ==1
          imwrite(imind,cm,fname,'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,fname,'gif','WriteMode','append','DelayTime',0.05); 
      end 
end
