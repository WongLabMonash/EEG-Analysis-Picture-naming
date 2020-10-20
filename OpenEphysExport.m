%% read raw data
clear
close all 
clc

for i = 1:64
    names{1,i} = ['100_CH', num2str(i),'.continuous'];
end

for i=1:length (names)
    [data, ~, ~] = load_open_ephys_data(names{i});
    EEGdata.data(i,:) = data';
end

% load photodiode
[data, ~, ~] = load_open_ephys_data('100_ADC1.continuous');
EEGdata.photoDiodeChannel = data;

% load voice channel
[data, timestamps, info] = load_open_ephys_data('100_ADC6.continuous');

EEGdata.info = info;
Fs = EEGdata.info.header.sampleRate;
[a,b] = butter(4,10/(Fs/2),'high');
data = filtfilt(a,b,data);
EEGdata.voiceChannel = data;

EEGdata.timestamps = timestamps-timestamps(1);
names=cellfun(@(x) x(5:end-11),names,'un',0);
EEGdata.names = names;

%

photoTrig=EEGdata.photoDiodeChannel ;
[a,b] = butter(4,10/(Fs/2),'low');
photoTrig = filtfilt(a,b,photoTrig);
photoTrig(end-Fs : end) = [];
subplot(2,1,1);plot(photoTrig)

tmp = double(photoTrig<(mean(photoTrig)-2*std(photoTrig)));
hold on;plot(ones(1,numel(photoTrig))*mean(photoTrig)-2*std(photoTrig));

if tmp(1)~= 0
    tmp(1:Fs)=0;
end
j=0;
event = [];
for i=1:length(tmp)
    if tmp (i) == 1 && tmp (i-1)==0
        j=j+1;
        event(j)=i;
    end
end

event1 = event(1:2:end);
event2 = event(2:2:end);
EEGdata.event1 = event1;
EEGdata.event2 = event2;

disp (['   the length of event is: ',sprintf('%d', length(event)),' trials'])
disp (['   the length of event1 is: ',sprintf('%d', length(event1)),' trials'])
disp (['   the length of event2 is: ',sprintf('%d', length(event2)),' trials'])


audioTrig = EEGdata.voiceChannel;
[a,b] = butter(4,2/(Fs/2),'high');
audioTrig = filtfilt(a,b,audioTrig);
subplot(2,1,2); plot(audioTrig)

RW = 3; % audio response window in second

j=0;jj=0;
event3 = [];noResp=[];
for i=1:length(event2)
    tmp = audioTrig (event2(i):(event2(i)+RW*Fs)-1);
    resp = find (tmp<(mean(tmp)-3*std(tmp))|tmp>(mean(tmp)+3*std(tmp)));
    if isempty(resp)
        jj =jj+1;
        noResp(jj)= i;
    else
        j=j+1;
        event3(j)=event2(i)+ resp(1); % audio response
    end
end

EEGdata.event3 = event3;
%%

path = '\\ad.monash.edu\home\User029\mker0004\Documents\EEGdataBackup_26_06_2020\data\2020-06-09_13-52-50-Mohsen\raw_data\';
save([path 'EEGdata_08'],'EEGdata') 
