%高斯束腰计算程序，完整版
function varargout = beam(varargin)
% BEAM MATLAB code for beam.fig
%      BEAM, by itself, creates a new BEAM or raises the existing
%      singleton*.
%
%      H = BEAM returns the handle to a new BEAM or the handle to
%      the existing singleton*.
%
%      BEAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM.M with the given input arguments.
%
%      BEAM('Property','Value',...) creates a new BEAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam

% Last Modified by GUIDE v2.5 31-Jul-2016 14:57:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_OutputFcn, ...
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


% --- Executes just before beam is made visible.
function beam_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam (see VARARGIN)

% Choose default command line output for beam
handles.output = hObject;
initialization(handles)     %初始化

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%初始化
function initialization(handles)
%初始化程序
global f1 f2 f3 f4 p1 p2 p3 p4 lambda w0 lstart lend l2 flagsurf flaglog;
lambda=8.8*10^-7;
f1=0.1;
f2=0.2;
f3=0.3;
f4=0.5;
p1=0.2;
p2=0.5;
p3=0;
p4=0;
w0=100;
set(handles.slider1,'Value',p1);
set(handles.slider2,'Value',p2);
set(handles.slider3,'Value',p3);
set(handles.slider4,'Value',p4);
set(handles.editp1,'String',p1);
set(handles.editp2,'String',p2);
set(handles.editp3,'String',p3);
set(handles.editp4,'String',p4);
set(handles.edit1,'String',num2str(f1));
set(handles.edit2,'String',num2str(f2));
set(handles.edit3,'String',num2str(f3));
set(handles.edit5,'String',num2str(f4));
set(handles.edit4,'String',num2str(lambda*10^9));
set(handles.edit6,'String',num2str(w0));

lstart=0;       %作图起点
lend=2;         %作图终点
l2=1;           %透镜范围
set(handles.edit12,'String',lstart);
set(handles.edit7,'String',lend);
set(handles.edit8,'String',l2);

flagsurf=0;
flaglog=0;
set(handles.checkbox1,'Value',0);
set(handles.checkbox2,'Value',0);

runsy(handles);

% --- Outputs from this function are returned to the command line.
function varargout = beam_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global p1;
p1=get(hObject,'Value');
set(handles.editp1,'String',p1);
runsy(handles);


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
global p2;
p2=get(hObject,'Value');
set(handles.editp2,'String',p2);
runsy(handles);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global p3;
p3=get(hObject,'Value');
set(handles.editp3,'String',p3);
runsy(handles);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%         returns contents of edit1 as a double
global f1;
f1=str2double(get(hObject,'String'));
runsy(handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
global f2;
f2=str2double(get(hObject,'String'));
runsy(handles);


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global f3;
f3=str2double(get(hObject,'String'));
runsy(handles);


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%调用运算束腰函数并画图
function runsy(handles)
global p1 p2 p3 p4 f1 f2 f3 f4 lambda w0 lstart lend flagsurf flaglog;
lens=[p1,f1;p2,f2;p3,f3;p4,f4];
[waist,lens]=sy(lens,w0,lambda);
set(handles.uitable1,'Data',waist);

%作图
x=linspace(lstart,lend,500);
y=x;
for j=1:length(x)
    if size(lens,1)==0
        y(j)=waist{3,2}*sqrt(1+(lambda*x(j)/pi/(waist{3,2}/10^6)^2)^2);
    elseif x(j)<lens(1,1)
        y(j)=waist{3,2}*sqrt(1+(lambda*x(j)/pi/(waist{3,2}/10^6)^2)^2);
    elseif size(lens,1)>=2 && x(j)<lens(2,1)
        xx=x(j)-waist{2,3};
        y(j)=waist{3,3}*sqrt(1+(lambda*xx/pi/(waist{3,3}/10^6)^2)^2);
    elseif size(lens,1)>=3 && x(j)<lens(3,1)
        xx=x(j)-waist{2,4};
        y(j)=waist{3,4}*sqrt(1+(lambda*xx/pi/(waist{3,4}/10^6)^2)^2);
    elseif size(lens,1)>=4 && x(j)<lens(4,1)
        xx=x(j)-waist{2,5};
        y(j)=waist{3,5}*sqrt(1+(lambda*xx/pi/(waist{3,5}/10^6)^2)^2);
    else
        xx=x(j)-waist{2,size(lens,1)+2};
        y(j)=waist{3,size(lens,1)+2}*sqrt(1+(lambda*xx/pi/(waist{3,size(lens,1)+2}/10^6)^2)^2);
    end
end

hold off
plot(x,y,'r',x,-y,'r')
xlabel('空间位置 / m');
ylabel('束腰半径 / um');
hold on
if flagsurf         %画强度图
    yy=linspace(-1.5*max(y)/10^6,1.5*max(y)/10^6,300);
    [X,Y]=meshgrid(x,yy);
    [W,~]=meshgrid(y/10^6,yy);
    Z=1./W.*exp(-Y.^2./W.^2);
    if flaglog      %对数坐标
        Z=log(Z+1);
    end
    surf(X,Y*10^6,Z);
    % shading interp;
    shading flat;
    set(handles.checkbox2,'Visible','on')
else
    stem(lens(:,1)',max(y)*(lens(:,1)'>0),'b');
    stem(lens(:,1)',-max(y)*(lens(:,1)'>0),'b');
    set(handles.checkbox2,'Visible','off')
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double
global lambda
lambda=10^-9*str2double(get(hObject,'String'));
runsy(handles);


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global p4;
p4=get(hObject,'Value');
set(handles.editp4,'String',get(hObject,'Value'));
runsy(handles);


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double
global f4;
f4=str2double(get(hObject,'String'));
runsy(handles);


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
global w0;
w0=str2double(get(hObject,'String'));
runsy(handles);


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
global lend lstart;
lend=str2double(get(hObject,'String'));
if lend<lstart         %如果起点大于终点，则彼此调换
    t=lstart;
    lstart=lend;
    lend=t;
    set(handles.edit12,'String',lstart);
    set(handles.edit7,'String',lend);
end
runsy(handles);


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
global l2;
l2=str2double(get(hObject,'String'));

if get(handles.slider1,'Value')>l2
    set(handles.slider1,'value',l2);    %确保当前值不大于设定值
    set(handles.editp1,'string',l2);
end
if get(handles.slider2,'Value')>l2
    set(handles.slider2,'value',l2);
    set(handles.editp2,'string',num2str(l2));
end
if get(handles.slider3,'Value')>l2
    set(handles.slider3,'value',l2);
    set(handles.editp3,'string',num2str(l2));
end
if get(handles.slider4,'Value')>l2
    set(handles.slider4,'value',l2);
    set(handles.editp4,'string',num2str(l2));
end

set(handles.slider1,'Max',l2);
set(handles.slider2,'Max',l2);
set(handles.slider3,'Max',l2);
set(handles.slider4,'Max',l2);


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
global flagsurf;
flagsurf=get(hObject,'Value');
runsy(handles);



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double
global lstart lend;
lstart=str2double(get(hObject,'String'));
if lend<lstart         %如果起点大于终点，则彼此调换
    t=lstart;
    lstart=lend;
    lend=t;
    set(handles.edit12,'String',lstart);
    set(handles.edit7,'String',lend);
end
runsy(handles);


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%运算束腰函数
function [waist,lens]=sy(varargin)
%计算束腰位置和束腰半径，可作图
%输入参数：lens，w0, lambda, plotflag。分别是透镜矩阵、起始束腰，波长，画图标志
%可以输入0-4个参数，如果不输入参数，则画图

w0=30;  %起始束腰半径，单位微米
lambda=880*10^-9;  %波长
lens=[0.2 0.20;...   透镜参数，每行代表一个透镜；第一列代表透镜的位置，第二列代表透镜焦距，单位米
    0.37 0.75;...     若某一行中有0，则此行不参与运算
    0.41 0.2];          %各行的顺序无关
plotflag=0;

%根据输入参数数目，对参数赋值
if nargin==0
    plotflag=1;
elseif nargin==1
    lens=varargin{1};
elseif nargin==2
    lens=varargin{1};
    w0=varargin{2};
elseif nargin==3
    lens=varargin{1};
    w0=varargin{2};
    lambda=varargin{3};
elseif nargin==4
    lens=varargin{1};
    w0=varargin{2};
    lambda=varargin{3};
    plotflag=varargin{4};
end

%标准单位制
w0=w0/1000000;

%删去透镜矩阵中多余行,并排序
lens=sortrows(lens);
kk=0;
for k=1:size(lens,1)
    if lens(k,1)==0
        kk=k;
    end
end
lens=lens(kk+1:size(lens,1),:);

l=0;
d=0;
w=w0;
waist={3,size(lens,1)+1};
waist{1,1}='束腰序号';
waist{2,1}='束腰位置/m';
waist{3,1}='束腰半径/um';
waist{1,2}=0;
waist{2,2}=0;
waist{3,2}=w0*10^6;
for k=1:size(lens,1)
    d1=lens(k,1)-l-d;   %前一透镜产生的束腰到此透镜的距离
    F=lens(k,2);
    d2=F+(d1-F)*F^2/((d1-F)^2+(pi*w^2/lambda)^2);    %此透镜到它产生的束腰的距离
    w2=sqrt(F^2*w^2/((F-d1)^2+(pi*w^2/lambda)^2));    %束腰半径
    waist{1,k+2}=k;
    waist{2,k+2}=lens(k,1)+d2;  %束腰的绝对位置
    waist{3,k+2}=w2*10^6;    %单位微米
    
    l=lens(k,1);
    d=d2;
    w=w2;
end


if plotflag
    
    %作图
    x=0:0.01:2;
    y=x;
    for j=1:length(x)
        if size(lens,1)==0
            y(j)=waist{3,2}*sqrt(1+(lambda*x(j)/pi/(waist{3,2}/10^6)^2)^2);
        elseif x(j)<lens(1,1)
            y(j)=waist{3,2}*sqrt(1+(lambda*x(j)/pi/(waist{3,2}/10^6)^2)^2);
        elseif size(lens,1)>=2 && x(j)<lens(2,1)
            xx=x(j)-waist{2,3};
            y(j)=waist{3,3}*sqrt(1+(lambda*xx/pi/(waist{3,3}/10^6)^2)^2);
        elseif size(lens,1)>=3 && x(j)<lens(3,1)
            xx=x(j)-waist{2,4};
            y(j)=waist{3,4}*sqrt(1+(lambda*xx/pi/(waist{3,4}/10^6)^2)^2);
        else
            xx=x(j)-waist{2,size(lens,1)+2};
            y(j)=waist{3,size(lens,1)+2}*sqrt(1+(lambda*xx/pi/(waist{3,size(lens,1)+2}/10^6)^2)^2);
        end
    end
    
    %disp(waist)
    plot(x,y,x,-y)
    hold on
    stem(lens(:,1)',max(y)*(lens(:,1)'>0),'b');
    stem(lens(:,1)',-max(y)*(lens(:,1)'>0),'b');
end


% --------------------------------------------------------------------
function Untitled_program_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_program (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_help_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hf=sprintf('移动滑块调整透镜位置，焦距为负表示凹透镜。\n\n透镜位置为零则认为没有此透镜。\n\n表格中不同序号的束腰，为光路中不同的透镜产生的束腰。');
msgbox(hf,'help');

% --------------------------------------------------------------------
function Untitled_initialize_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_initialize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
initialization(handles)

% --------------------------------------------------------------------
function Untitled_quit_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global flaglog
flaglog=get(hObject,'Value');
runsy(handles);



function editp1_Callback(hObject, eventdata, handles)
% hObject    handle to editp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editp1 as text
%        str2double(get(hObject,'String')) returns contents of editp1 as a double
global p1 l2;
p1=str2double(get(hObject,'String'));
if p1>l2
    set(handles.edit8,'String',ceil(p1));
    edit8_Callback(hObject, eventdata, handles);
    set(handles.edit7,'String',ceil(p1));
    edit7_Callback(hObject, eventdata, handles);
end
set(handles.slider1,'value',p1);
runsy(handles);


% --- Executes during object creation, after setting all properties.
function editp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editp2_Callback(hObject, eventdata, handles)
% hObject    handle to editp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editp2 as text
%        str2double(get(hObject,'String')) returns contents of editp2 as a double
global p2 l2;
p2=str2double(get(hObject,'String'));
if p2>l2
    set(handles.edit8,'String',ceil(p2));
    edit8_Callback(hObject, eventdata, handles);
    set(handles.edit7,'String',ceil(p2));
    edit7_Callback(hObject, eventdata, handles);
end
set(handles.slider2,'value',p2);
runsy(handles);


% --- Executes during object creation, after setting all properties.
function editp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editp3_Callback(hObject, eventdata, handles)
% hObject    handle to editp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editp3 as text
%        str2double(get(hObject,'String')) returns contents of editp3 as a double
global p3 l2;
p3=str2double(get(hObject,'String'));
if p3>l2
    set(handles.edit8,'String',ceil(p3));
    edit8_Callback(hObject, eventdata, handles);
    set(handles.edit7,'String',ceil(p3));
    edit7_Callback(hObject, eventdata, handles);
end
set(handles.slider3,'value',p3);
runsy(handles);


% --- Executes during object creation, after setting all properties.
function editp3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editp3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editp4_Callback(hObject, eventdata, handles)
% hObject    handle to editp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editp4 as text
%        str2double(get(hObject,'String')) returns contents of editp4 as a double
global p4 l2;
p4=str2double(get(hObject,'String'));
if p4>l2
    set(handles.edit8,'String',ceil(p4));
    edit8_Callback(hObject, eventdata, handles);
    set(handles.edit7,'String',ceil(p4));
    edit7_Callback(hObject, eventdata, handles);
end
set(handles.slider4,'value',p4);
runsy(handles);


% --- Executes during object creation, after setting all properties.
function editp4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editp4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
