% add FieldTRip to the path

% run('G:\My Drive\Matlab\fieldtrip-master\ft_defaults.m')
%%
clear
load('data_bi_ICA_filt_reRef.mat');
load('data_mono_ICA_filt_reRef.mat');

% correctin the timestamp >> pulling the time for 0.5 sec
data_mono_ICA_filt_reRef.time= cellfun(@(x) x-0.5,data_mono_ICA_filt_reRef.time,'un',0);
data_bi_ICA_filt_reRef.time= cellfun(@(x) x-0.5,data_bi_ICA_filt_reRef.time,'un',0);
%% remove bad trils
% jump
cfg = [];
cfg.latency = [-0.3, 0.7];
tmp = ft_selectdata(cfg, data_bi_ICA_filt_reRef);

cfg.continuous = 'yes';
cfg.artfctdef.zvalue.channel = 'all';
cfg.artfctdef.zvalue.cutoff = 30;
cfg.artfctdef.zvalue.trlpadding = 0;
cfg.artfctdef.zvalue.artpadding = 0;
cfg.artfctdef.zvalue.fltpadding = 0;
cfg.artfctdef.zvalue.cumulative = 'yes';
cfg.artfctdef.zvalue.medianfilter = 'yes';
cfg.artfctdef.zvalue.medianfiltord = 10;
cfg.artfctdef.zvalue.absdiff = 'yes';
cfg.artfctdef.zvalue.interactive = 'yes';
[~, artifact_jump] = ft_artifact_zvalue(cfg,tmp);

%%
cfg=[];
cfg.artfctdef.reject = 'complete';
cfg.artfctdef.jump.artifact = artifact_jump;
data_bi_ICA_filt_reRef_clean= ft_rejectartifact(cfg,data_bi_ICA_filt_reRef);

%% remove bad trils
% jump
cfg = [];
cfg.latency = [-0.3, 0.7];
tmp = ft_selectdata(cfg, data_mono_ICA_filt_reRef);

cfg.continuous = 'yes';
cfg.artfctdef.zvalue.channel = 'all';
cfg.artfctdef.zvalue.cutoff = 30;
cfg.artfctdef.zvalue.trlpadding = 0;
cfg.artfctdef.zvalue.artpadding = 0;
cfg.artfctdef.zvalue.fltpadding = 0;
cfg.artfctdef.zvalue.cumulative = 'yes';
cfg.artfctdef.zvalue.medianfilter = 'yes';
cfg.artfctdef.zvalue.medianfiltord = 10;
cfg.artfctdef.zvalue.absdiff = 'yes';
cfg.artfctdef.zvalue.interactive = 'yes';%'no';
[~, artifact_jump] = ft_artifact_zvalue(cfg,tmp);

%%
cfg=[];
cfg.artfctdef.reject = 'complete';
cfg.artfctdef.jump.artifact = artifact_jump;
data_mono_ICA_filt_reRef_clean= ft_rejectartifact(cfg,data_mono_ICA_filt_reRef);

%% down sampling before decoding
cfg = [];
cfg.resamplefs = 100;
cfg.detrend    = 'no';
data_mono_ICA_filt_reRef_clean = ft_resampledata(cfg, data_mono_ICA_filt_reRef_clean);
data_bi_ICA_filt_reRef_clean = ft_resampledata(cfg, data_bi_ICA_filt_reRef_clean);

save data_bi_ICA_filt_reRef_clean_100Hz data_bi_ICA_filt_reRef_clean
save data_mono_ICA_filt_reRef_clean_100Hz data_mono_ICA_filt_reRef_clean

%% reformat the data for MVPA light 
disp ('turning to MVPA toolbox format')
data_bi_ICA_filt_reRef_clean.data_MVPA = zeros(length(data_bi_ICA_filt_reRef_clean.trial),length(data_bi_ICA_filt_reRef_clean.label),size(data_bi_ICA_filt_reRef_clean.trial{1, 1},2));

for i = 1:length(data_bi_ICA_filt_reRef_clean.trial)
    data_bi_ICA_filt_reRef_clean.data_MVPA(i,:,:) = data_bi_ICA_filt_reRef_clean.trial {i};
end
data_bi_ICA_filt_reRef_clean.trialinfo(data_bi_ICA_filt_reRef_clean.trialinfo==0)=2;

%%

cfg = [];
cfg.metric          = 'acc';
cfg.classifier      = 'svm';
cfg.preprocess      = {'average_samples','zscore'};
cfg.preprocess_param.group_size = 8;

[perf_bi, res_bi] = mv_classify_across_time (cfg, data_bi_ICA_filt_reRef_clean.data_MVPA, data_bi_ICA_filt_reRef_clean.trialinfo);
close all
mv_plot_result(res_bi, data_bi_ICA_filt_reRef_clean.time{1});

%%

save timeDecoding_bi_8tialAVG_zscore res_bi

%% channel decoding ( with FieldTrip)
cfg=[];
cfg.trials = data_bi_ICA_filt_reRef_clean.trialinfo_av==1;
trial1 = ft_selectdata(cfg, data_bi_ICA_filt_reRef_clean);

cfg=[];
cfg.trials = data_bi_ICA_filt_reRef_clean.trialinfo_av==2;
trial2 = ft_selectdata(cfg, data_bi_ICA_filt_reRef_clean);


%%
cfg = [] ;  
cfg.method      = 'mvpa';
cfg.metric      = 'acc';
cfg.classifier  = 'svm';
cfg.searchlight = 'yes';
cfg.design      = data_bi_ICA_filt_reRef_clean.trialinfo_av;
cfg.latency     = [0.6, 1];
cfg.avgovertime = 'yes';

stat = ft_timelockstatistics(cfg, trial1, trial2);
figure;
cfg              = [];
cfg.parameter    = 'accuracy';
cfg.layout    = 'quickcap64.mat';         
cfg.xlim         = [0, 0];

cfg.colorbar     = 'yes';
ft_topoplotER(cfg, stat);

decoding.loc = stat;

%%

