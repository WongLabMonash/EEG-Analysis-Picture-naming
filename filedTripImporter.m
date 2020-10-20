%ft_defaults
%%ft_defaults
%suject name : Mohsen, 5 bilingual runns, 4 monolingual runs:
% Bi1, Bi2, English1,English2, farsi1, farsi2, Bi3-stopped, Bi4, Bi5
% reference electrode: left ear lobe
% Time between text and image(D1) = 1s;
% language cue = 0.1s; 
% image presenation duration = 0.15s;
%timeBetweenTrials = 1;
%% Paths for EEG and PTB3 results

clear
addpath('G:\My Drive\EEG_Psychophysics\projects\codes_for_EEG')
path1 = 'G:\My Drive\Matlab\PictureNamingTask\Iranian\results\';
path2 = '\\ad.monash.edu\home\User029\mker0004\Documents\EEGdataBackup_26_06_2020\data\2020-06-09_13-52-50-Mohsen\raw_data\';
load('labels.mat')
run('G:\My Drive\Matlab\fieldtrip-master\ft_defaults.m')

%% dataset1: bilingual block

% load trial order
load([path1 'mose01bi.mat']);
trialOrder(trialOrder==0)=2;

%load the EEG data
load([path2 'EEGdata_01.mat'])

data_raw = [];
data_raw.label = labels;
data_raw.fsample = EEGdata.info.header.sampleRate;   
data_raw.trial {1,1} = EEGdata.data;
Fs = EEGdata.info.header.sampleRate;
event = EEGdata.event1- 0.5*Fs; % event1 is the que onset, taking all trials 0.5sec back to cover baseline 
data_raw.sampleinfo(:,1) = event;
data_raw.sampleinfo(:,2) = data_raw.sampleinfo(:,1)+ (3*Fs)-1;
data_raw.sampleinfo(:,3) = 10; %10ms photodiode jitter
data_raw.sampleinfo(:,4) = trialOrder;
data_raw.time {1,1} = EEGdata.timestamps;

cfg = [];
cfg.trl = data_raw.sampleinfo;
data1 = ft_redefinetrial(cfg, data_raw);

%% dataset2: bilingul block

% load trial order
load([path1 'mose02bi.mat']);
trialOrder(trialOrder==0)=2;

%load the EEG data
load([path2 'EEGdata_02.mat'])

data_raw = [];
data_raw.label = labels;
data_raw.fsample = EEGdata.info.header.sampleRate;   
data_raw.trial {1,1} = EEGdata.data;
Fs = EEGdata.info.header.sampleRate;
event = EEGdata.event1- 0.5*Fs;
data_raw.sampleinfo(:,1) = event;
data_raw.sampleinfo(:,2) = data_raw.sampleinfo(:,1)+ (3*Fs)-1;
data_raw.sampleinfo(:,3) = 10; %10ms photodiode jitter
data_raw.sampleinfo(:,4) = trialOrder;
data_raw.time {1,1} = EEGdata.timestamps;

cfg = [];
cfg.trl = data_raw.sampleinfo;
data2 = ft_redefinetrial(cfg, data_raw);

%% dataset3: English block

% load trial order
load([path1 'mose_eng1.mat']);
trialOrder(trialOrder==0)=2;

%load the EEG data
load([path2 'EEGdata_03.mat'])

data_raw = [];
data_raw.label = labels;
data_raw.fsample = EEGdata.info.header.sampleRate;   
data_raw.trial {1,1} = EEGdata.data;
Fs = EEGdata.info.header.sampleRate;
event = EEGdata.event1- 0.5*Fs;
data_raw.sampleinfo(:,1) = event;
data_raw.sampleinfo(:,2) = data_raw.sampleinfo(:,1)+ (3*Fs)-1;
data_raw.sampleinfo(:,3) = 10; %10ms photodiode jitter
data_raw.sampleinfo(:,4) = trialOrder;
data_raw.time {1,1} = EEGdata.timestamps;

cfg = [];
cfg.trl = data_raw.sampleinfo;
data3 = ft_redefinetrial(cfg, data_raw);


%% dataset 4: English block

% load trial order
load([path1 'mose_eng2.mat']);
trialOrder(trialOrder==0)=2;

%load the EEG data
load([path2 'EEGdata_04.mat'])

data_raw = [];
data_raw.label = labels;
data_raw.fsample = EEGdata.info.header.sampleRate;   
data_raw.trial {1,1} = EEGdata.data;
Fs = EEGdata.info.header.sampleRate;
event = EEGdata.event1- 0.5*Fs;
data_raw.sampleinfo(:,1) = event;
data_raw.sampleinfo(:,2) = data_raw.sampleinfo(:,1)+ (3*Fs)-1;
data_raw.sampleinfo(:,3) = 10; %10ms photodiode jitter
data_raw.sampleinfo(:,4) = trialOrder;
data_raw.time {1,1} = EEGdata.timestamps;

cfg = [];
cfg.trl = data_raw.sampleinfo;
data4 = ft_redefinetrial(cfg, data_raw);

%% dataset 5 Farsi1 block

% load trial order
load([path1 'mose_far2.mat']); % far1 didnt recorded
trialOrder(trialOrder==0)=2;

%load the EEG data
load([path2 'EEGdata_05.mat'])

data_raw = [];
data_raw.label = labels;
data_raw.fsample = EEGdata.info.header.sampleRate;   
data_raw.trial {1,1} = EEGdata.data;
Fs = EEGdata.info.header.sampleRate;
event = EEGdata.event1- 0.5*Fs;
data_raw.sampleinfo(:,1) = event;
data_raw.sampleinfo(:,2) = data_raw.sampleinfo(:,1)+ (3*Fs)-1;
data_raw.sampleinfo(:,3) = 10; %10ms photodiode jitter
data_raw.sampleinfo(:,4) = trialOrder;
data_raw.time {1,1} = EEGdata.timestamps;

cfg = [];
cfg.trl = data_raw.sampleinfo;
data5 = ft_redefinetrial(cfg, data_raw);

%% dataset 6 Farsi2 Block

% load trial order
load([path1 'mose_far2.mat']);
trialOrder(trialOrder==0)=2;

%load the EEG data
load([path2 'EEGdata_06.mat'])

data_raw = [];
data_raw.label = labels;
data_raw.fsample = EEGdata.info.header.sampleRate;   
data_raw.trial {1,1} = EEGdata.data;
Fs = EEGdata.info.header.sampleRate;
event = EEGdata.event1- 0.5*Fs;
data_raw.sampleinfo(:,1) = event;
data_raw.sampleinfo(:,2) = data_raw.sampleinfo(:,1)+ (3*Fs)-1;
data_raw.sampleinfo(:,3) = 10; %10ms photodiode jitter
data_raw.sampleinfo(:,4) = trialOrder;
data_raw.time {1,1} = EEGdata.timestamps;

cfg = [];
cfg.trl = data_raw.sampleinfo;
data6 = ft_redefinetrial(cfg, data_raw);

%% dataset 7 Bilangual Block

% not recorded, stopped after 2 trials

%% dataset 8 Bilangual Block

% load trial order
load([path1 'mose04bi.mat']);
trialOrder(trialOrder==0)=2;

%load the EEG data
load([path2 'EEGdata_07.mat'])

data_raw = [];
data_raw.label = labels;
data_raw.fsample = EEGdata.info.header.sampleRate;   
data_raw.trial {1,1} = EEGdata.data;
Fs = EEGdata.info.header.sampleRate;
event = EEGdata.event1- 0.5*Fs;
data_raw.sampleinfo(:,1) = event;
data_raw.sampleinfo(:,2) = data_raw.sampleinfo(:,1)+ (3*Fs)-1;
data_raw.sampleinfo(:,3) = 10; %10ms photodiode jitter
data_raw.sampleinfo(:,4) = trialOrder;
data_raw.time {1,1} = EEGdata.timestamps;

cfg = [];
cfg.trl = data_raw.sampleinfo;
data8 = ft_redefinetrial(cfg, data_raw);

%% dataset 9 Bilangual Block

% load trial order
load([path1 'mose05bi.mat']);
trialOrder(trialOrder==0)=2;

%load the EEG data
load([path2 'EEGdata_08.mat'])

data_raw = [];
data_raw.label = labels;
data_raw.fsample = EEGdata.info.header.sampleRate;   
data_raw.trial {1,1} = EEGdata.data;
Fs = EEGdata.info.header.sampleRate;
event = EEGdata.event1- 0.5*Fs;
data_raw.sampleinfo(:,1) = event;
data_raw.sampleinfo(:,2) = data_raw.sampleinfo(:,1)+ (3*Fs)-1;
data_raw.sampleinfo(:,3) = 10; %10ms photodiode jitter
data_raw.sampleinfo(:,4) = trialOrder;
data_raw.time {1,1} = EEGdata.timestamps;

cfg = [];
cfg.trl = data_raw.sampleinfo;
data9 = ft_redefinetrial(cfg, data_raw);

%% Merge trials together

cfg = [];
cfg.keepsampleinfo='no';

data_monoling =  ft_appenddata(cfg, data3, data4, data5, data6);
save data_monoling data_monoling

cfg = [];
data_biling =  ft_appenddata(cfg, data1, data2,data8,data9);
save data_biling data_biling

% save allDataInFieldTripFormat
dataRaw.data1 = data1; dataRaw.data2 = data2;dataRaw.data3 = data3;
dataRaw.data4 = data4;dataRaw.data5 = data5;dataRaw.data6 = data6;
dataRaw.data7 = data9;dataRaw.data8 = data8;
save dataRaw dataRaw

%% Filtering options
cfg = [];
cfg.hpfilter       = 'yes';
cfg.hpfreq         = 2;
cfg.lpfilter       = 'yes';
cfg.lpfreq         = 30;
data_monolingF            = ft_preprocessing(cfg,data_monoling);
data_bilingF            = ft_preprocessing(cfg,data_biling);

%% %% ICA
% bilingual
load('labels.mat')
cfg = [];
cfg.channel = setdiff(labels,{'HEOR','HEOL'});
EEGonly_bi  = ft_selectdata(cfg, data_bilingF);
 

cfg = [];
cfg.resamplefs = 200;
cfg.detrend    = 'no';
dataICA_bi = ft_resampledata(cfg, EEGonly_bi);

% perform the independent component analysis (i.e., decompose the data)
cfg        = [];
cfg.method = 'runica'; % this is the default and uses the implementation from EEGLAB
comp_bi = ft_componentanalysis(cfg, dataICA_bi);

% plot the components for visual inspection
figure
cfg = [];
cfg.component = 1:20;       % specify the component(s) that should be plotted
cfg.layout    = 'quickcap64.mat'; % specify the layout file that should be used for plotting
cfg.comment   = 'no';
ft_topoplotIC(cfg, comp_bi)
cfg.viewmode = 'component';
ft_databrowser(cfg, comp_bi)

%% remove the bad components and backproject the data
cfg = [];
cfg.component = 1; % to be removed component(s)
data_after_ICA_bi = ft_rejectcomponent(cfg, comp_bi, dataICA_bi);

cfg = [];  % use only default options
cfg.viewmode = 'vertical';
ft_databrowser(cfg, data_after_ICA_bi);

save ICA_results_bi comp_bi
save data_after_ICA_bi data_after_ICA_bi

%% %%%%%% monoling ICA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('monoling ICA')
cfg = [];
cfg.channel = setdiff(labels,{'HEOR','HEOL'});
EEGonly_mono  = ft_selectdata(cfg, data_monolingF);

cfg = [];
cfg.resamplefs = 200;
cfg.detrend    = 'no';
dataICA_mono = ft_resampledata(cfg, EEGonly_mono);

% perform the independent component analysis (i.e., decompose the data)
cfg        = [];
cfg.method = 'runica'; % this is the default and uses the implementation from EEGLAB
comp_mono = ft_componentanalysis(cfg, dataICA_mono);

% plot the components for visual inspection
figure
cfg = [];
cfg.component = 1:20;       % specify the component(s) that should be plotted
cfg.layout    = 'quickcap64.mat'; % specify the layout file that should be used for plotting
cfg.comment   = 'no';
ft_topoplotIC(cfg, comp_mono)
cfg.viewmode = 'component';
ft_databrowser(cfg, comp_mono)

%% remove bad components and backproject the data
cfg = [];
cfg.component = 1; % to be removed component(s)
data_after_ICA_mono = ft_rejectcomponent(cfg, comp_mono, dataICA_mono);

cfg = [];  % use only default options
cfg.viewmode = 'vertical';
ft_databrowser(cfg, data_after_ICA_mono);

save ICA_results_mono comp_mono
save data_after_ICA_mono data_after_ICA_mono

%% re-reference
cfg = [];
cfg.reref       = 'yes';
cfg.detrend = 'yes';
cfg.channel     = 'all';
cfg.refchannel  = {'M1', 'M2'}; % the average of these two is used as the new reference, 
data_bi_ICA_filt_reRef            = ft_preprocessing(cfg,data_after_ICA_bi);
data_mono_ICA_filt_reRef            = ft_preprocessing(cfg,data_after_ICA_mono);

%% check the noise in bilingual dataset
cfg = [];  
cfg.viewmode = 'vertical';
ft_databrowser(cfg, data_bi_ICA_filt_reRef);

%% check the noise in monolingual dataset
ft_databrowser(cfg, data_mono_ICA_filt_reRef);

%%
cfg = [];
cfg.channel = setdiff(labels,{'M1','M2'});
data_mono_ICA_filt_reRef  = ft_selectdata(cfg, data_mono_ICA_filt_reRef);
data_bi_ICA_filt_reRef  = ft_selectdata(cfg, data_bi_ICA_filt_reRef);

save data_bi_ICA_filt_reRef data_bi_ICA_filt_reRef
save data_mono_ICA_filt_reRef data_mono_ICA_filt_reRef



