clc, clear, close all;
%% Initialization
if~isempty(instrfind)
    fclose(instrfind)
    delete(instrfind)
end
% intialize a global variable
global signal
% obtain signals from Arduino
signal = serial('COM3');
set(signal, 'BaudRate', 9600);
fopen(signal);
% set the monitoring time interval
interval = 7201;
% intiallize the dataset of air temperature, skin temperature, GSR and heart rate
air_temp = [];
skin_temp = [];
heart_rate = [];
GSR = [];
data = [];
t = 0;
i = 0;
%% Plot and Store the data
while (t < interval)
    i = i + 1;
    t = t + 1;
    % convert the signal string to number
    sig = str2num(fgetl(signal));
    
    if mod(i, 4) == 1
        heart_rate = [heart_rate, sig];
        figure(1);
        plot(heart_rate);
        title('Heart Rate');
        xlabel('time interval');
        ylabel('bpm');
        grid;
        drawnow;
    elseif mod(i, 4) == 2
        air_temp = [air_temp, sig];
        figure(2);
        plot(air_temp);       
        title('Air Temperature');
        xlabel('time interval');
        ylabel('Celsuis Degree');
        grid;
        drawnow;
    elseif mod(i, 4) == 3
        skin_temp = [skin_temp, sig];
        figure(3);
        plot(skin_temp);
        title('Skin Temperature');
        xlabel('time interval');
        ylabel('Celsius Degree');
        grid;
        drawnow;
    else
        GSR = [GSR, sig];
        figure(4);
        plot(GSR);
        title('GSR');
        xlabel('time interval');
        grid;
        drawnow;
    end
end
data = [air_temp; skin_temp; heart_rate; GSR];
fclose(signal);